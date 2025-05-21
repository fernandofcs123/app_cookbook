const functions = require('firebase-functions');
const fetch = require('node-fetch'); // Certifique-se de ter isso no seu package.json
const cors = require('cors')({ origin: true });

const API_KEY = 'SUA_API_KEY_DO_GOOGLE_PALM_AQUI'; // Substitua pela sua chave real

exports.generateNutrition = functions.https.onRequest((req, res) => {
  cors(req, res, async () => {
    const { ingredients } = req.body;

    if (!ingredients) {
      return res.status(400).send('Ingredientes não fornecidos.');
    }

    try {
      const response = await fetch(`https://generativelanguage.googleapis.com/v1/models/text-bison-001:generateText?key=${API_KEY}`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          prompt: {
            text: `Me diga os valores nutricionais dos seguintes ingredientes: ${ingredients}`,
          },
          temperature: 0.7,
          candidateCount: 1,
        }),
      });

      const rawText = await response.text(); // 👈 captura a resposta crua
      console.log('Resposta bruta da API:', rawText); // 👈 loga o texto da resposta

      let data;
      try {
        data = JSON.parse(rawText); // 👈 tenta fazer parse da resposta
      } catch (parseError) {
        console.error('Erro ao converter resposta da API para JSON:', parseError);
        return res.status(500).send('Erro ao processar resposta da API.');
      }

      if (data.candidates && data.candidates.length > 0) {
        const resultado = data.candidates[0].output;
        console.log('Resultado gerado:', resultado);
        return res.status(200).send(resultado);
      } else {
        console.error('Resposta inesperada da API:', data);
        return res.status(500).send('A API retornou uma resposta inesperada.');
      }

    } catch (error) {
      console.error('Erro na requisição à API:', error);
      return res.status(500).send('Erro ao se comunicar com o modelo de linguagem.');
    }
  });
});
