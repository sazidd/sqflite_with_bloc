import 'package:flutter/material.dart';
import 'package:sqflit/bloc/sqflit_bloc.dart';
import 'package:sqflit/models/student.dart';
import 'package:sqflit/screens/show_all.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNew extends StatefulWidget {
  final bool edit;
  final Student student;

  AddNew({this.edit, this.student});

  @override
  _AddNewState createState() => _AddNewState();
}

class _AddNewState extends State<AddNew> {
  TextEditingController _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  // StudentProvider dbManager = StudentProvider();

  SqflitBloc sqflitBloc;

  @override
  void initState() {
    super.initState();
    sqflitBloc = context.read<SqflitBloc>();
    if (widget.edit == true) {
      _nameController.text = widget.student.name;
    }
  }

  @override
  void dispose() {
    super.dispose();
    sqflitBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hi'),
      ),
      body: ListView(
        children: <Widget>[
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(hintText: 'type your name'),
                ),
                RaisedButton(
                  child: Text('Save'),
                  onPressed: () {
                    _saveData();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ShowAll(),
                      ),
                    );
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void _saveData() {
    if (widget.edit == false) {
      sqflitBloc.add(
        InsertStudent(
          student: Student(
            name: _nameController.text,
          ),
        ),
      );
    } else {
      sqflitBloc.add(
        UpdateStudent(
          student: Student(
            id: widget.student.id,
            name: _nameController.text,
          ),
        ),
      );
    }
  }
}
