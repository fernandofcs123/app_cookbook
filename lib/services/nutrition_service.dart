import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class NutritionService {
  static final _apiKey = dotenv.env['GOOGLE_API_KEY']!;

  // Use o endpoint v1 e modelo text-bison-001
  static final _url = 'https://generativelanguage.googleapis.com/v1/'
      'models/text-bison-001:generateText?key=$_apiKey';

  static Future<String> getNutrition(String recipeText) async {
    final prompt = '''
Você é um nutricionista de alta precisão. Receba esta receita:

$recipeText

Retorne sucintamente:
- Calorias totais
- Macronutrientes (proteínas, carboidratos, gorduras)
- Fibras, açúcares e sódio
- Porção padrão
''';

    final payload = {
      'prompt': {'text': prompt},
      'temperature': 0.2,
      'candidateCount': 1,
    };

    final resp = await http.post(
      Uri.parse(_url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(payload),
    );

    if (resp.statusCode != 200) {
      throw Exception('Erro na API (${resp.statusCode}): ${resp.body}');
    }

    final data = jsonDecode(resp.body) as Map<String, dynamic>;
    final candidates = data['candidates'] as List<dynamic>?;
    if (candidates == null || candidates.isEmpty) {
      throw Exception('Resposta vazia da API');
    }
    return candidates.first['output'] as String;
  }
}
