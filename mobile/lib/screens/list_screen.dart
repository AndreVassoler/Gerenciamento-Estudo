import 'package:flutter/material.dart';
import 'package:nome_do_projeto/services/estudo_service.dart';
import 'package:nome_do_projeto/models/studo_model.dart';

class ActivityListScreen extends StatefulWidget {
  @override
  _ActivityListScreenState createState() => _ActivityListScreenState();
}

class _ActivityListScreenState extends State<ActivityListScreen> {
  List<Activity> _activities = [];
  bool _isLoading = true;
  final StudyService _studyService = StudyService();

  @override
  void initState() {
    super.initState();
    fetchActivities();
  }

  Future<void> fetchActivities() async {
    try {
      final studies = await _studyService.fetchStudies();
      setState(() {
        _activities = studies
            .map((study) => Activity(
                  id: study.id ?? 0,
                  name: study.titulo,
                  description: study.descricao,
                ))
            .toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print("Erro ao carregar atividades: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Atividades'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _activities.isEmpty
              ? Center(child: Text('Nenhuma atividade cadastrada'))
              : ListView.builder(
                  itemCount: _activities.length,
                  itemBuilder: (context, index) {
                    final activity = _activities[index];
                    return Card(
                      child: ListTile(
                        title: Text(activity.name),
                        subtitle: Text(activity.description),
                      ),
                    );
                  },
                ),
    );
  }
}
