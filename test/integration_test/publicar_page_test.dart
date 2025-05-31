import 'package:app_cookbook/modules/home/publicar_page/publicar_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import '../mocks/firebase_mock.mocks.dart';

Future<void> main() async {

  testWidgets("Teste de publicação de vídeo com mock", (WidgetTester tester) async {
    final mockFirestore = MockFirebaseFirestore();
    final mockCollection = MockCollectionReference();
    final mockDocument = MockDocumentReference();

    // Simular a interação com Firestore
    when(mockFirestore.collection('videos')).thenReturn(mockCollection as CollectionReference<Map<String, dynamic>>);
    when(mockCollection.add(any)).thenAnswer((_) async => mockDocument);


    await tester.pumpWidget(const MaterialApp(home: PublicarPage()));

    // Inserir título e descrição
    await tester.enterText(find.byType(TextField).first, "Meu título de teste");
    await tester.enterText(find.byType(TextField).last, "Descrição de teste");

    // Clicar no botão de publicar
    await tester.tap(find.text("Publicar"));
    await tester.pump();

    // Verificar se o mock de Firestore foi chamado
    verify(mockCollection.add(any)).called(1);

    // Verificar se a mensagem de sucesso aparece
    expect(find.text("Publicado com sucesso!"), findsOneWidget);
  });
}