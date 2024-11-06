import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nome_do_projeto/screens/studyFormScreen.dart';

void main() {
  testWidgets('Deve exibir os campos e validar o formulário no StudyFormScreen',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: StudyFormScreen(),
      ),
    );

    expect(find.byType(TextFormField),
        findsNWidgets(3)); // Título, Descrição e Matéria
    expect(find.text('Adicionar'), findsOneWidget); // Botão de adicionar

    await tester.tap(find.text('Adicionar'));
    await tester.pump();

    expect(find.text('Por favor, insira o título'), findsOneWidget);
    expect(find.text('Por favor, insira a descrição'), findsOneWidget);
    expect(find.text('Por favor, insira a matéria'), findsOneWidget);

    await tester.enterText(
        find.widgetWithText(TextFormField, 'Título'), 'Estudo de Matemática');
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Descrição'), 'Revisão de álgebra');
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Matéria'), 'Matemática');

    await tester.tap(find.text('Adicionar'));
    await tester.pump();

    expect(find.text('Por favor, insira o título'), findsNothing);
    expect(find.text('Por favor, insira a descrição'), findsNothing);
    expect(find.text('Por favor, insira a matéria'), findsNothing);
  });
}
