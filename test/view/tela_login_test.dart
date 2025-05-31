import 'package:app_cookbook/modules/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  testWidgets("[Caixa-Preta] Login com senha vazia", (WidgetTester tester) async {
    final binding = TestWidgetsFlutterBinding.ensureInitialized();
    binding.window.physicalSizeTestValue = const Size(1080, 1920);
    binding.window.devicePixelRatioTestValue = 1.0;

    
    await tester.pumpWidget(
      MaterialApp(
        home: LoginPage(),
      )
    );
  

  final campoEmail = find.widgetWithText(TextFormField, 'Email');
  await tester.enterText(campoEmail, "fernando@unifeob.com");


  await tester.tap(find.byKey(const Key('botao_login')));
  await tester.pump();

  expect(find.text("Campo obrigatório"), findsOneWidget);
  });

  testWidgets("[Caixa-Preta] Login com Email vazio", (WidgetTester tester) async {
    final binding = TestWidgetsFlutterBinding.ensureInitialized();
    binding.window.physicalSizeTestValue = const Size(1080, 1920);
    binding.window.devicePixelRatioTestValue = 1.0;

    
    await tester.pumpWidget(
      MaterialApp(
        home: LoginPage(),
      )
    );
  

  final campoEmail = find.widgetWithText(TextFormField, 'Senha');
  await tester.enterText(campoEmail, "12345678");


  await tester.tap(find.byKey(const Key('botao_login')));
  await tester.pump();

  expect(find.text("Campo obrigatório"), findsOneWidget);
  });
  testWidgets("[Caixa-Preta] Login com email inválido", (WidgetTester tester) async {
    final binding = TestWidgetsFlutterBinding.ensureInitialized();
    binding.window.physicalSizeTestValue = const Size(1080, 1920);
    binding.window.devicePixelRatioTestValue = 1.0;

    
    await tester.pumpWidget(
      MaterialApp(
        home: LoginPage(),
      )
    );
  

  final campoEmail = find.widgetWithText(TextFormField, 'Email');
  await tester.enterText(campoEmail, "fernando@unifeob");


  await tester.tap(find.byKey(const Key('botao_login')));
  await tester.pump();

  expect(find.text("E-mail inválido"), findsOneWidget);
  });
}