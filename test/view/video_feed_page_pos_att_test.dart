import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../mocks/mock_login_page.dart';
import '../mocks/mock_video_feed_page.dart';


void main() {
  testWidgets('Simula navegação do Login para Home ao clicar no botão',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        routes: {
          '/': (context) => const MockLoginPage(),
          '/home': (context) => const MockVideoFeedPage(),
        },
      ),
    );

    // Verifica se campos e botão estão presentes
    expect(find.byKey(const Key('email_field')), findsOneWidget);
    expect(find.byKey(const Key('senha_field')), findsOneWidget);
    expect(find.byKey(const Key('botao_login')), findsOneWidget);

    // Preenche campos (simula o comportamento real)
    await tester.enterText(find.byKey(const Key('email_field')), 'bruno.aleixo@sou.unifeob.edu.br');
    await tester.enterText(find.byKey(const Key('senha_field')), 'bruno@123');

    // Clica no botão de login
    await tester.tap(find.byKey(const Key('botao_login')));
    await tester.pumpAndSettle();

    // Verifica se navegou para a página de vídeos
    expect(find.text('Bolo de fuba de forno'), findsOneWidget);
  });
}
