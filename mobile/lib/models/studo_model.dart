import 'package:nome_do_projeto/models/subject_model.dart';

class Estudo {
  final int? id;
  final String titulo;
  final String descricao;
  final Subject subject;

  Estudo(
      {this.id,
      required this.titulo,
      required this.descricao,
      required this.subject});

  factory Estudo.fromJson(Map<String, dynamic> json) {
    return Estudo(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()),
      titulo: json['titulo'] as String,
      descricao: json['descricao'] as String,
      subject: Subject.fromJson(json['subject']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titulo': titulo,
      'descricao': descricao,
      'subject': subject.toJson(),
    };
  }
}
