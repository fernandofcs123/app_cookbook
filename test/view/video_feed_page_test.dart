import 'package:app_cookbook/modules/home/video_feed_page/video_feed_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:app_cookbook/ui/video_card.dart';
void main() {
testWidgets("Verifica se os vídeos são exibidos corretamente", (WidgetTester tester) async {
  await tester.pumpWidget(MaterialApp(home: VideoFeedPage()));

  // Verifica se os títulos estão corretos
  expect(find.text("Estrogonofe de carne"), findsOneWidget);
  expect(find.text("Pamonha de milho"), findsWidgets); // Dois vídeos com o mesmo título

  // Confirma se os vídeos foram renderizados corretamente
  expect(find.byType(VideoCard), findsWidgets);
});


}