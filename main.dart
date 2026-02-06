import 'package:flutter/material.dart';


void main() => runApp(MaterialApp(

debugShowCheckedModeBanner: false,

title: 'Student Management System',

theme: ThemeData(primarySwatch: Colors.blue),

home: StudentHomePage(),

));


class Student {

String name, rollNo, course;

Student(this.name, this.rollNo, this.course);

}


class StudentHomePage extends StatefulWidget {

@override

_StudentHomePageState createState() => _StudentHomePageState();

}


class _StudentHomePageState extends State<StudentHomePage> {

final students = <Student>[];

final nameCtrl = TextEditingController(), rollCtrl = TextEditingController(), courseCtrl = TextEditingController();


void showForm([int? i]) {

if (i != null) {

nameCtrl.text = students[i].name;

rollCtrl.text = students[i].rollNo;

courseCtrl.text = students[i].course;

}

showModalBottomSheet(

context: context,

isScrollControlled: true,

builder: (_) => Padding(

padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 16, left: 16, right: 16, top: 16),

child: Column(mainAxisSize: MainAxisSize.min, children: [

Text(i == null ? "Add Student" : "Edit Student", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

for (var c in [nameCtrl, rollCtrl, courseCtrl]) TextField(controller: c, decoration: InputDecoration(labelText: c == nameCtrl ? "Name" : c == rollCtrl ? "Roll No" : "Course")),

ElevatedButton(

child: Text(i == null ? "Add" : "Update"),

onPressed: () {

setState(() {

if (i == null) students.add(Student(nameCtrl.text, rollCtrl.text, courseCtrl.text));

else students[i] = Student(nameCtrl.text, rollCtrl.text, courseCtrl.text);

});

nameCtrl.clear(); rollCtrl.clear(); courseCtrl.clear();

Navigator.pop(context);

},

)

]),

),

);

}


@override

Widget build(BuildContext context) => Scaffold(

appBar: AppBar(title: Text("Student Management System")),

body: students.isEmpty ? Center(child: Text("No students added yet")) : ListView.builder(

itemCount: students.length,

itemBuilder: (_, i) => Card(

margin: EdgeInsets.all(8),

child: ListTile(

title: Text(students[i].name),

subtitle: Text("Roll: ${students[i].rollNo}\nCourse: ${students[i].course}"),

isThreeLine: true,

trailing: Row(mainAxisSize: MainAxisSize.min, children: [

IconButton(icon: Icon(Icons.edit, color: Colors.blue), onPressed: () => showForm(i)),

IconButton(icon: Icon(Icons.delete, color: Colors.red), onPressed: () => setState(() => students.removeAt(i))),

]),

),

),

),

floatingActionButton: FloatingActionButton(child: Icon(Icons.add), onPressed: showForm),

);

}