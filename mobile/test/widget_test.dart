import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nome_do_projeto/services/estudo_service.dart';
import 'package:nome_do_projeto/models/studo_model.dart';
import 'package:nome_do_projeto/models/subject_model.dart';

import 'widget_test.mocks.dart';

@GenerateMocks([StudyService])
void main() {
  group('StudyService Tests', () {
    late MockStudyService mockStudyService;

    setUp(() {
      // Instancia o mock do serviço
      mockStudyService = MockStudyService();
    });

    test('Deve retornar uma lista simulada de estudos', () async {
      // Dados simulados
      final mockStudies = [
        Estudo(
          id: 1,
          titulo: 'Estudo Simulado de Matemática',
          descricao: 'Revisão de álgebra e geometria',
          subject: Subject(name: 'Matemática'),
        ),
        Estudo(
          id: 2,
          titulo: 'Estudo Simulado de Física',
          descricao: 'Introdução à mecânica',
          subject: Subject(name: 'Física'),
        ),
      ];

      // Configura o mock para retornar dados simulados
      when(mockStudyService.fetchStudies())
          .thenAnswer((_) async => mockStudies);

      // Executa e verifica
      final studies = await mockStudyService.fetchStudies();
      expect(studies.length, 2);
      expect(studies[0].titulo, 'Estudo Simulado de Matemática');
    });
  });
}
