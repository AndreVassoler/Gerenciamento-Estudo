import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/studo_model.dart';

class Activity {
  final int id;
  final String name;
  final String description;

  Activity({required this.id, required this.name, required this.description});

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
      };
}

class StudyService {
  static const String baseUrl = "http://localhost:3000/studies";

  Future<void> addStudy(Estudo estudo) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: json.encode(estudo.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception("Erro ao adicionar o estudo");
    }
  }

  Future<List<Estudo>> fetchStudies() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Estudo.fromJson(json)).toList();
    } else {
      throw Exception("Erro ao buscar estudos");
    }
  }

  Future<void> updateStudy(Estudo estudo) async {
    if (estudo.id == null) {
      throw Exception("ID do estudo é nulo, não é possível atualizar");
    }

    final response = await http.put(
      Uri.parse('$baseUrl/${estudo.id}'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(estudo.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception("Erro ao atualizar o estudo");
    }
  }
}
