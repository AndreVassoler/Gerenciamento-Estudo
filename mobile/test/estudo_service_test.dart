import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:nome_do_projeto/models/studo_model.dart';
import 'package:nome_do_projeto/services/estudo_service.dart';

import 'estudo_service_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('StudyService fetchStudies Test', () {
    late MockClient mockClient;
    late StudyService studyService;

    setUp(() {
      mockClient = MockClient();
      // Passa o mockClient para o StudyService
      studyService = StudyService();
    });

    test('Deve retornar uma lista de estudos ao fazer um GET', () async {
      final mockResponse = jsonEncode([
        {
          'id': 1,
          'titulo': 'Matemática Básica',
          'descricao': 'Estudo sobre operações fundamentais',
          'subject': {'name': 'Matemática'}
        },
        {
          'id': 2,
          'titulo': 'Física',
          'descricao': 'Introdução à mecânica',
          'subject': {'name': 'Física'}
        },
      ]);

      // Configura o mockClient para retornar a resposta simulada
      when(mockClient.get(Uri.parse('http://localhost:3000/studies')))
          .thenAnswer((_) async => http.Response(mockResponse, 200));

      // Executa o método fetchStudies e verifica o resultado
      final studies = await studyService.fetchStudies();

      // Verifica o conteúdo dos estudos retornados
      expect(studies.length, 2);
      expect(studies[0].titulo, 'Matemática Básica');
      expect(studies[1].titulo, 'Física');
      expect(studies[0].subject.name, 'Matemática');
      expect(studies[1].subject.name, 'Física');
    });

    test('Deve lançar uma exceção se o código de status não for 200', () async {
      // Configura o mockClient para simular um erro 404
      when(mockClient.get(Uri.parse('http://localhost:3000/studies')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      // Verifica se uma exceção é lançada
      expect(() async => await studyService.fetchStudies(), throwsException);
    });
  });
}
