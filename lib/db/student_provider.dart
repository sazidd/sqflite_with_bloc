import 'package:sqflit/models/student.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class StudentProvider {
  Database _database;
  Future openDb() async {
    if (_database == null) {
      _database = await openDatabase(join(await getDatabasesPath(), "my.db"),
          version: 1, onCreate: (Database db, int version) async {
        await db.execute(
            "CREATE TABLE student(id INTEGER PRIMARY KEY autoincrement,name TEXT)");
      });
    }
  }

  Future<List<Student>> getStudentList() async {
    await openDb();
    final List<Map<String, dynamic>> maps = await _database.query('student');
    return List.generate(maps.length, (i) {
      return Student(id: maps[i]['id'], name: maps[i]['name']);
    });
  }

  Future insertStudent(Student student) async {
    await openDb();
    return _database.insert('student', student.toMap());
  }

  Future updateStudent(Student student) async {
    await openDb();
    return _database.update('student', student.toMap(),
        where: "id = ?", whereArgs: [student.id]);
  }

  Future<int> deleteStudent(int id) async {
    await openDb();
    return _database.delete('student', where: "id = ?", whereArgs: [id]);
  }
}
