import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mocks/mock_login_page.dart';
import '../mocks/mock_perfil_page.dart';

void main() {
  testWidgets('PerfilPage renderiza corretamente os elementos principais', (
    WidgetTester tester,
  ) async {
    // Build da aplicação com rotas simuladas
    await tester.pumpWidget(
      MaterialApp(
        routes: {
          '/': (context) => const MockLoginPage(),
          '/home': (context) => const MockPerfilPage(),
        },
      ),
    );

    // Verifica campos e botão
    expect(find.byKey(const Key('email_field')), findsOneWidget);
    expect(find.byKey(const Key('senha_field')), findsOneWidget);
    expect(find.byKey(const Key('botao_login')), findsOneWidget);

    // Preenche os campos
    await tester.enterText(find.byKey(const Key('email_field')), 'bruno.aleixo@sou.unifeob.edu.br');
    await tester.enterText(find.byKey(const Key('senha_field')), 'bruno@123');

    // Clica no botão de login
    await tester.tap(find.byKey(const Key('botao_login')));
    await tester.pumpAndSettle();

    // Verifica se o nome e username aparecem
    expect(find.text('Bruno Aleixo'), findsOneWidget);
    expect(find.text('bruno@aleixo'), findsOneWidget);

    // Verifica se os vídeos mockados estão presentes
    expect(find.text('Vídeo 1'), findsOneWidget);
    expect(find.text('Vídeo 2'), findsOneWidget);
  });
}
