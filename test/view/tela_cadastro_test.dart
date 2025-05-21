import 'package:app_cookbook/modules/cadastro/cadastro_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  testWidgets("[Caixa-Preta] Cadastro com senhas diferentes", (WidgetTester tester) async {
    final binding = TestWidgetsFlutterBinding.ensureInitialized();
    binding.window.physicalSizeTestValue = const Size(1080, 1920);
    binding.window.devicePixelRatioTestValue = 1.0;

    await tester.pumpWidget(
      MaterialApp(
        home: CadastroPage(),
      )
    );

    final campoNome = find.widgetWithText(TextFormField, 'Nome');
    final campoTelefone = find.widgetWithText(TextFormField, 'Telefone');
    final campoEmail = find.widgetWithText(TextFormField, 'E-mail');
    final campoSenha = find.widgetWithText(TextFormField, 'Senha');
    final campoConfirmarSenha = find.widgetWithText(TextFormField, 'Confirmar senha');

    await tester.enterText(campoNome, "Fernando");
    await tester.enterText(campoTelefone, "19982124598");
    await tester.enterText(campoEmail, "fernando@unifeob.com");
    await tester.enterText(campoSenha, "fernando123");
    await tester.enterText(campoConfirmarSenha, "fernando1234");

    final criarButton = find.byKey(const Key("botao_criar"));
    await tester.tap(criarButton);
    await tester.pump();

    expect(find.text("Senhas diferentes"), findsOneWidget);
});
    testWidgets("[Caixa-Preta] Cadastro com email inválido", (WidgetTester tester) async {
    final binding = TestWidgetsFlutterBinding.ensureInitialized();
    binding.window.physicalSizeTestValue = const Size(1080, 1920);
    binding.window.devicePixelRatioTestValue = 1.0;

    await tester.pumpWidget(
      MaterialApp(
        home: CadastroPage(),
      )
    );

    final campoNome = find.widgetWithText(TextFormField, 'Nome');
    final campoTelefone = find.widgetWithText(TextFormField, 'Telefone');
    final campoEmail = find.widgetWithText(TextFormField, 'E-mail');
    final campoSenha = find.widgetWithText(TextFormField, 'Senha');
    final campoConfirmarSenha = find.widgetWithText(TextFormField, 'Confirmar senha');

    await tester.enterText(campoNome, "Fernando");
    await tester.enterText(campoTelefone, "19982124598");
    await tester.enterText(campoEmail, "fernando@unifeob");
    await tester.enterText(campoSenha, "fernando123");
    await tester.enterText(campoConfirmarSenha, "fernando123");

    final criarButton = find.byKey(const Key("botao_criar"));
    await tester.tap(criarButton);
    await tester.pump();

    expect(find.text("E-mail inválido"), findsOneWidget);
  });

  testWidgets("[Caixa-Preta] Cadastro com telefone inválido", (WidgetTester tester) async {
    final binding = TestWidgetsFlutterBinding.ensureInitialized();
    binding.window.physicalSizeTestValue = const Size(1080, 1920);
    binding.window.devicePixelRatioTestValue = 1.0;

    await tester.pumpWidget(
      MaterialApp(
        home: CadastroPage(),
      )
    );

    final campoNome = find.widgetWithText(TextFormField, 'Nome');
    final campoTelefone = find.widgetWithText(TextFormField, 'Telefone');
    final campoEmail = find.widgetWithText(TextFormField, 'E-mail');
    final campoSenha = find.widgetWithText(TextFormField, 'Senha');
    final campoConfirmarSenha = find.widgetWithText(TextFormField, 'Confirmar senha');

    await tester.enterText(campoNome, "Fernando");
    await tester.enterText(campoTelefone, "1936314035");
    await tester.enterText(campoEmail, "fernando@unifeob.com");
    await tester.enterText(campoSenha, "fernando123");
    await tester.enterText(campoConfirmarSenha, "fernando123");

    final criarButton = find.byKey(const Key("botao_criar"));
    await tester.tap(criarButton);
    await tester.pump();

    expect(find.text("Número de telefone inválido"), findsOneWidget);
  });
}