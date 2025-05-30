// lib/services/nutrition_service.dart

import 'package:cloud_functions/cloud_functions.dart';

class NutritionService {
  // Instância do Firebase Functions
  static final _functions = FirebaseFunctions.instanceFor(region: 'us-central1');
  

  /// Chama a Cloud Function `generateNutritionV2` e retorna a saída gerada.
  static Future<String> getNutrition(String recipeText) async {
    // Dispara a chamada HTTPS callable
    final callable = _functions.httpsCallable('generateNutritionV2',
      options: HttpsCallableOptions(timeout: const Duration(seconds: 60)),
    );
    final result = await callable.call(<String, dynamic>{
      'recipe': recipeText,
    });

    print(result.data);

    if (result.data == null || result.data['output'] == null) {
      throw Exception('Resposta da função vazia ou inválida');
    }


    // O dado retornado vem no campo `data` do HttpsCallableResult
    final data = result.data as Map<String, dynamic>;
    return data['output'] as String;
  }
}
