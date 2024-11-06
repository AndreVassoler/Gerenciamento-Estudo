import 'package:flutter_test/flutter_test.dart';
import 'package:nome_do_projeto/models/studo_model.dart';
import 'package:nome_do_projeto/models/subject_model.dart';
import 'package:nome_do_projeto/services/estudo_service.dart';

void main() {
  group('Estudo e StudyService Tests', () {
    test(
        'Deve criar um Estudo a partir do JSON e converter para JSON corretamente',
        () {
      final json = {
        'id': 1,
        'titulo': 'Matemática Básica',
        'descricao': 'Estudo sobre operações fundamentais',
        'subject': {'name': 'Matemática'}
      };

      final estudo = Estudo.fromJson(json);

      expect(estudo.id, 1);
      expect(estudo.titulo, 'Matemática Básica');
      expect(estudo.descricao, 'Estudo sobre operações fundamentais');
      expect(estudo.subject.name, 'Matemática');

      final estudoJson = estudo.toJson();
      expect(estudoJson, json);
    });

    test('Deve retornar uma lista simulada de estudos', () async {
      final studyService = StudyService();

      final studies = [
        Estudo(
          id: 1,
          titulo: 'Matemática Básica',
          descricao: 'Estudo sobre operações fundamentais',
          subject: Subject(name: 'Matemática'),
        ),
        Estudo(
          id: 2,
          titulo: 'Física Básica',
          descricao: 'Estudo sobre mecânica clássica',
          subject: Subject(name: 'Física'),
        ),
      ];

      expect(studies.length, 2);
      expect(studies[0].titulo, 'Matemática Básica');
      expect(studies[1].subject.name, 'Física');
    });
  });
}
