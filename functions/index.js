// functions/index.js

const { onCall } = require('firebase-functions/v2/https');
const functions = require('firebase-functions');
const admin = require('firebase-admin');
const { GoogleAuth } = require('google-auth-library');
const fetch = require('node-fetch');

admin.initializeApp();

// 1) Configure o GoogleAuth para gerar tokens com o escopo Generative Language
const auth = new GoogleAuth({
  scopes: [
    'https://www.googleapis.com/auth/cloud-platform',
    'https://www.googleapis.com/auth/generative-language'
  ]
});

exports.generateNutritionV2 = onCall({ region: 'us-central1' }, async (event) => {
  try {
    const recipeText = event.data.recipe;
    if (typeof recipeText !== 'string' || !recipeText.trim()) {
      throw new functions.https.HttpsError(
        'invalid-argument',
        'Parâmetro "recipe" deve ser uma string não vazia.'
      );
    }
 
    // 2) Obter o token de acesso
    const client = await auth.getClient();
    const { token: accessToken } = await client.getAccessToken();
    if (!accessToken) {
      throw new functions.https.HttpsError(
        'internal',
        'Não foi possível obter access token.'
      );
    }

    // 3) Montar prompt e payload
    const prompt = `
Você é um nutricionista de alta precisão. Receba esta receita:

${recipeText}

Retorne sucintamente:
- Calorias totais
- Macronutrientes (proteínas, carboidratos, gorduras)
- Fibras, açúcares e sódio
- Porção padrão
`;


    const payload = {
      contents: [
        {
          parts: [{ text: prompt }]
        }
      ]
    };


    // 4) Chamada ao endpoint Generative Language v1beta2
    const url = 'https://generativelanguage.googleapis.com/v1/models/gemini-1.5-flash:generateContent?key=apikey';
    const resp = await fetch(url, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(payload)
    });


    if (!resp.ok) {
      const errText = await resp.text();
      throw new functions.https.HttpsError(
        'internal',
        `Vertex AI error ${resp.status}: ${errText}`
      );
    }

    const json = await resp.json();
    const candidates = json.candidates;
    if (!Array.isArray(candidates) || candidates.length === 0) {
      throw new functions.https.HttpsError(
        'internal',
        'Resposta vazia do Vertex AI'
      );
    }

    // 5) Retorna o texto gerado
    return { output: json?.candidates[0].content.parts[0].text }; // JSON FEIO E DEIXAR ELE BONITO

  } catch (err) {
    // Já são HttpsError ou lançamos internamente
    if (err instanceof functions.https.HttpsError) throw err;
    console.error('generateNutritionV2 error:', err);
    throw new functions.https.HttpsError(
      'internal',
      'Erro interno ao gerar informações nutricionais.'
    );
  }
});
