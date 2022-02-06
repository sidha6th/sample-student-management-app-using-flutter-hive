import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
part 'dataBase.g.dart';

@HiveType(typeId: 0)
class StudentModel {  
  @HiveField(0)
  int? key;
  @HiveField(1)
  final name;
  @HiveField(2)
  final age;
  @HiveField(3)
  final reg;
  @HiveField(4)
  final std;
  @HiveField(5)
  String? img;
  StudentModel(
      {required this.name,
      required this.age,
      required this.reg,
      required this.std,
      this.img,
      this.key});
}

ValueNotifier<List<StudentModel>> studentDataNotifier = ValueNotifier([]);

// =======================DB Functions========================//

addData(value) async {
  final studendDB = await Hive.openBox<StudentModel>('studentDB');
  int keys = await studendDB.add(value);
  value.key = keys;
  await studendDB.put(value.key, value);
  getallstudents();
}

getallstudents() async {
  final studendDB = await Hive.openBox<StudentModel>('studentDB');
  studentDataNotifier.value.clear();
  studentDataNotifier.value.addAll(studendDB.values);
  studentDataNotifier.notifyListeners();
}

deletebtn(key) async {
  final studendDB = await Hive.openBox<StudentModel>('studentDB');
  //print('deleteing key $key ');
  studendDB.delete(key);
  getallstudents();
}

editdata(StudentModel value) async {
  final studendDB = await Hive.openBox<StudentModel>('studentDB');
  await studendDB.put(value.key, value);
  getallstudents();
}

killdata(context) async {
  showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text('Delete All Data !'.toUpperCase()),
          content:const Text('Are you sure you want to Delete all Data'),
          actions: [
            ElevatedButton(
                onPressed: () async {
                  final studendDB =
                      await Hive.openBox<StudentModel>('studentDB');
                  await studendDB.clear();
                  getallstudents();
                  Navigator.pop(context);
                },
                child:const Text('Yes')),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child:const Text('No'))
          ],
        );
      });
}



getdata() async {
  final studendDB = await Hive.openBox<StudentModel>('studentDB');
  studentDataNotifier.value.clear();
  studentDataNotifier.value.addAll(studendDB.values);
  // studentDataNotifier.notifyListeners();
  return studentDataNotifier;
}