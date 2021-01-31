import 'package:flutter/material.dart';
import 'package:sqflit/bloc/sqflit_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'add_new.dart';

class ShowAll extends StatefulWidget {
  @override
  _ShowAllState createState() => _ShowAllState();
}

class _ShowAllState extends State<ShowAll> {
  SqflitBloc sqflitBloc;
  TextEditingController searchController = TextEditingController();

  // GetStudentList getStudentList;
  // SqflitLoaded sqflitLoaded;
  // StudentProvider studentProvider;

  @override
  void initState() {
    super.initState();
    sqflitBloc = context.read<SqflitBloc>();
    sqflitBloc.add(GetStudentList());
  }

  @override
  void dispose() {
    super.dispose();
    sqflitBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: FloatingSearchAppBar(body: Container(),),
      // appBar: AppBar(
      //   title: Text('Hello world'),
      // ),
      body: BlocBuilder<SqflitBloc, SqflitState>(
        builder: (context, state) {
          if (state is SqflitLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SqflitError) {
            return Center(
              child: Text(state.errorMessage),
            );
          } else if (state is SqflitLoaded) {
            if (state.student.isEmpty) {
              return Center(
                child: Text('No data found'),
              );
            }
            return ListView(
              children: [
                const SizedBox(height: 56),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          onChanged: (value) {
                            sqflitBloc.add(
                              SearchStudent(query: value),
                            );
                          },
                          controller: searchController,
                          decoration: InputDecoration(
                              hintText: 'Search...',
                              labelText: 'Search',
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
                              )),
                        ),
                      ),
                      // FlatButton(
                      //   onPressed: () {
                      // sqflitBloc.add(
                      //   SearchStudent(query: searchController.text),
                      // );
                      //   },
                      //   child: Text('Search'),
                      // ),
                    ],
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.student.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: 100.0,
                            width: 100.0,
                            child: Column(
                              children: <Widget>[
                                Text('name : ${state.student[index].name}'),
                                RaisedButton(
                                  child: Text('Add new'),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => AddNew(
                                                  edit: false,
                                                )));
                                  },
                                ),
                              ],
                            ),
                          ),
                          RaisedButton(
                            child: Text('Delete'),
                            onPressed: () {
                              sqflitBloc.add(
                                DeleteStudent(student: state.student[index]),
                              );
                            },
                          ),
                          RaisedButton(
                            child: Text('Edit'),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddNew(
                                            edit: true,
                                            student: state.student[index],
                                          )));
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}
