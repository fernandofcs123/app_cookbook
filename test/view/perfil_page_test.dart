import 'package:app_cookbook/modules/home/perfil_page/perfil_page.dart';
import 'package:app_cookbook/ui/video_perfil_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('PerfilPage renderiza corretamente os elementos principais', (
    WidgetTester tester,
  ) async {
    // Build da página
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: PerfilPage())));

    // Verifica se o nome do usuário aparece
    expect(find.text('Jorge Jesus'), findsWidgets); // aparece várias vezes

    // Verifica se o texto "Vídeos" está presente
    expect(find.text('Vídeos'), findsOneWidget);

    // Verifica se o botão "Seguir" está presente
    expect(find.text('Seguir'), findsOneWidget);

    // Verifica se todos os VideoPerfilCards foram renderizados (7 vídeos = 7 widgets)
    expect(find.byType(VideoPerfilCard), findsNWidgets(7));
  });
}
