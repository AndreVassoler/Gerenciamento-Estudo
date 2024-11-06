import 'package:flutter/material.dart';
import 'package:nome_do_projeto/models/studo_model.dart';
import 'package:nome_do_projeto/models/subject_model.dart';
import 'package:nome_do_projeto/services/estudo_service.dart';

class StudyFormScreen extends StatefulWidget {
  final Estudo? study;

  StudyFormScreen({this.study});

  @override
  _StudyFormScreenState createState() => _StudyFormScreenState();
}

class _StudyFormScreenState extends State<StudyFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _subjectController = TextEditingController();
  final StudyService _studyService = StudyService();

  @override
  void initState() {
    super.initState();
    if (widget.study != null) {
      _titleController.text = widget.study!.titulo;
      _descriptionController.text = widget.study!.descricao;
      _subjectController.text = widget.study!.subject.name;
    }
  }

  Future<void> _saveStudy() async {
    if (_formKey.currentState!.validate()) {
      // Verifica se o formulário é válido
      final study = Estudo(
        id: widget.study?.id,
        titulo: _titleController.text,
        descricao: _descriptionController.text,
        subject: Subject(name: _subjectController.text),
      );

      if (widget.study == null) {
        await _studyService.addStudy(study);
      } else {
        await _studyService.updateStudy(study);
      }

      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.study == null ? 'Novo Estudo' : 'Editar Estudo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Título'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o título';
                  } else if (value.length < 3) {
                    return 'O título deve ter pelo menos 3 caracteres';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Descrição'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a descrição';
                  } else if (value.length < 10) {
                    return 'A descrição deve ter pelo menos 10 caracteres';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _subjectController,
                decoration: InputDecoration(labelText: 'Matéria'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a matéria';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveStudy,
                child: Text(widget.study == null ? 'Adicionar' : 'Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
