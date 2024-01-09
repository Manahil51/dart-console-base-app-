import 'dart:io';
import 'dart:convert';

List<Map<String, dynamic>> students = [
  {'name': 'ali', 'age': 12, 'grade': 'A', 'class': '5'},
  {'name': 'ahmed', 'age': 14, 'grade': 'B', 'class': '7'},
  {'name': 'haris', 'age': 13, 'grade': 'A', 'class': '6'},
  {'name': 'sara', 'age': 11, 'grade': 'C', 'class': '4'},
];

class StudentManagement {
  List<Map<String, dynamic>> students = [];

  StudentManagement() {
    loadStudentData();
  }

  void loadStudentData() {
    try {
      File file = File('students.json');
      if (file.existsSync()) {
        String data = file.readAsStringSync();
        students = List<Map<String, dynamic>>.from(jsonDecode(data));
        print('Student data loaded from file.\n');
      }
    } catch (e) {
      print('Error loading student data: $e\n');
    }
  }

  void addStudent() {
    print('enter student details:');
    stdout.write('name: ');
    String name = stdin.readLineSync()!;
    stdout.write('age:');
    int age = int.parse(stdin.readLineSync()!);
    stdout.write('Grade:');
    String grade = stdin.readLineSync()!;
    stdout.write('Class:');
    String Class = stdin.readLineSync()!;

    Map<String, dynamic> newStudent = {
      'name': name,
      'age': age,
      'grade': grade,
    };
    students.add(newStudent);
    print('student added successfully!\n');
  }

  void searchstudent(String studentname) {
    var foundstudent =
        students.where((student) => student['name'] == studentname).toList();
    if (foundstudent.isEmpty) {
      print('student not found');
    } else {
      print('found student:');
      for (var student in foundstudent) {
        print(
            'name: ${student['name']},age: ${student['age']}, grade: ${student['grade']}');
      }
    }
  }

  void searchStudentGrade(String studentgrade) {
    var foundgrade =
        students.where((student) => student['grade'] == studentgrade).toList();
    if (foundgrade.isEmpty) {
      print('grade not found');
    } else {
      print('found grade:');
      for (var student in foundgrade) {
        print(
            'name: ${student['name']},age: ${student['age']}, grade: ${student['grade']}');
      }
    }
  }

  void searchStudentClass(String studentClass) {
    var foundclass =
        students.where((student) => student['class'] == studentClass).toList();
    if (foundclass.isEmpty) {
      print('student not found');
    } else {
      print('found student:');
      for (var student in foundclass) {
        print(
            'name:${student['name']},age:${student['age']},grade:${student['grade']},class:${student['class']},');
      }
    }
  }

  void updateStudent() {
    print("enter the name if the student to update :");
    String nameToUpdate = stdin.readLineSync()!;
    var foundstudent =
        students.where((student) => student['name'] == nameToUpdate).toList();
    if (foundstudent.isEmpty) {
      print('student not found');
    } else {
      var studentToUpdate = foundstudent.first;
      print('enter new detail for ${studentToUpdate['name']}:');
      stdout.write('new age:');
      studentToUpdate['age'] = int.parse(stdin.readLineSync()!);
      stdout.write('new grade:');
      studentToUpdate['grade'] = stdin.readLineSync()!;
      stdout.write('New Class:');
      studentToUpdate['class'] = stdin.readLineSync()!;
      print('student updated successfully!\n');
    }
  }

  void studentToDelete() {
    print('enter the name of student to delete:');
    String nameToDelete = stdin.readLineSync()!;
    students.removeWhere((student) => student['name'] == nameToDelete);
    print('student deleted successfully');
  }

  void printStudentList() {
    print('Student List:');
    for (var student in students) {
      print(
          'name:${student['name']}, age:${student['age']}, grade:${student['grade']}, class:${student['class']},');
    }
  }

  void saveStudentData() {
    try {
      File file = File('students.json');
      String data = jsonEncode(students);
      file.writeAsStringSync(data);
      print('Student data saved to file.\n');
    } catch (e) {
      print('Error saving student data: $e\n');
    }
  }
}

void main() {
  var studentManagement = StudentManagement();

  while (true) {
    print('1. add student');
    print('2. update student');
    print('3. delete student');
    print('4. search student by Name');
    print('5. search Student by grade');
    print('6. search student by class');
    print('7. print student list');
    print('8. exit.');

    stdout.write('Enter your choice:');
    String choice = stdin.readLineSync()!;
    switch (choice) {
      case '1':
        studentManagement.addStudent();
        break;
      case '2':
        studentManagement.updateStudent();
        break;
      case '3':
        studentManagement.studentToDelete();
        break;
      case '4':
        stdout.write('Enter student name to search: ');
        String name = stdin.readLineSync()!;
        studentManagement.searchstudent(name);
        break;
      case '5':
        stdout.write('Enter student grade to search: ');
        String grade = stdin.readLineSync()!;
        studentManagement.searchStudentGrade(grade);
        break;
      case '6':
        stdout.write('Enter student class to search: ');
        String studentClass = stdin.readLineSync()!;
        studentManagement.searchStudentClass(studentClass);
        break;
      case '7':
        studentManagement.printStudentList();
        break;
      case '8':
        studentManagement.saveStudentData();
        exit(0);
        break;
      default:
        print('Invalid choice. Please enter a number between 1 and 8.\n');
    }
  }
}
