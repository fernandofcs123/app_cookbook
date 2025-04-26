import 'package:app_cookbook/modules/cadastro/cadastro_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  testWidgets("Exibir mensagens de erro de campos vazios", (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: CadastroPage(),
      )
    );

    final criarButton = find.byKey(const Key("botao_criar"));
    await tester.tap(criarButton);
    await tester.pump();

    expect(find.text("Campo obrigatório"), findsNWidgets(3));
  });
}