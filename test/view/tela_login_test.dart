import 'package:app_cookbook/modules/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:validatorless/validatorless.dart';

void main(){
  testWidgets("[Caixa-Preta] Login com campos vazios", (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: LoginPage(),
        ),
      )
    );
  

  final loginButton = find.byKey(const Key("botao_login"));
  await tester.tap(loginButton);
  await tester.pump();

  expect(find.text("Campo obrigatório"), findsNWidgets(2));
  });
}