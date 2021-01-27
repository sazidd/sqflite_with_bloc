class Student {
  final int id;
  final String name;

  Student({this.id, this.name});

  Map<String, dynamic> toMap() {
    return {'name': name};
  }
}
