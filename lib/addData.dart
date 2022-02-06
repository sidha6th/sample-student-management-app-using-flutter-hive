import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sample/db/dataBase.dart';

class AddStudents extends StatefulWidget {
 final StudentModel? value;
 const AddStudents({Key? key, this.value}) : super(key: key);

  @override
  State<AddStudents> createState() => _AddStudentsState();
}
 dynamic image;
String encodededimg = '';

class _AddStudentsState extends State<AddStudents> {
final  TextEditingController _name = TextEditingController();

final  TextEditingController _reg = TextEditingController();

final  TextEditingController _age = TextEditingController();

final  TextEditingController _class = TextEditingController();

  File? sutdentimagepath;

  @override
  Widget build(BuildContext context) {
    if (widget.value != null) {
      _name.text = widget.value?.name;
      _age.text = widget.value?.age;
      _reg.text = widget.value?.reg;
      _class.text = widget.value?.std;
     
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 30,
          backgroundColor: Colors.teal[400],
          centerTitle: true,
          title:const Text(
            'Registration Form',
            style: TextStyle(fontWeight: FontWeight.w900),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            children: [
              TextField(
                textInputAction: TextInputAction.next,
                controller: _name,
                decoration:const InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide()),
                    hintText: 'Student Name'),
              ),
              const SizedBox(
                width: double.infinity,
                height: 10,
              ),
              TextField(
                textInputAction: TextInputAction.next,
                controller: _reg,
                decoration:const InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide()),
                    hintText: 'Reg.No'),
              ),
            const  SizedBox(
                width: double.infinity,
                height: 10,
              ),
              TextField(
                textInputAction: TextInputAction.next,
                controller: _age,
                decoration:const InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide()),
                    hintText: 'Age'),
              ),
            const  SizedBox(
                width: double.infinity,
                height: 10,
              ),
              TextField(
                textInputAction: TextInputAction.next,
                controller: _class,
                decoration:const InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide()),
                    hintText: 'Class'),
              ),
             const SizedBox(
                width: double.infinity,
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                    child: IconButton(
                      onPressed: () async {
                        return addPhoto();
                      },
                      icon:const Icon(Icons.add_photo_alternate),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_name.text.trim().isEmpty ||
                            _class.text.trim().isEmpty ||
                            _reg.text.trim().isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              dismissDirection: DismissDirection.endToStart,
                              content: Text(
                                'Name Age and class are Required !',
                                style: TextStyle(
                                    color: Colors.redAccent[700],
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15),
                              ),
                              padding: const EdgeInsets.all(
                                8.0,
                              ),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          );
                        } else if (widget.value == null) {
                          submitBtn(context);
                        } else {
                          editbtn(context);
                        }
                      },
                      child: const Text('Submit'),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.green[400]),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

//======================submit btn click=========================//

  submitBtn(BuildContext context) async {
    final name = _name.text;
    final age = _age.text; 
    final reg = _reg.text;
    final std = _class.text;
    
    if(encodededimg.toString().length<2){
      image ='0';
    }else{
     image = encodededimg;
     }
    final addvalue = StudentModel(name: name, age: age, reg: reg, std: std, img: image);
    await addData(addvalue);
    encodededimg='';
    _name.clear();
    _age.clear();
    _reg.clear();
    _class.clear();
    Navigator.of(context).pop();
    studentDataNotifier.notifyListeners();
  }

  editbtn(BuildContext context) async {
    final name = _name.text;
    final age = _age.text;
    final reg = _reg.text;
    final std = _class.text;
     if(encodededimg.toString().length<2){
      image ='0';
    }else{
     image = encodededimg;
     }

    final values = StudentModel(
        key: widget.value!.key,
        name: name,
        age: age,
        reg: reg,
        std: std,
        img: image);
    await editdata(values);
    Navigator.of(context).pop();
  }

//========================add photo================================//
  addPhoto() async {
   
    image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
     return ;
    } else {
      // sutdentimagepath = File(image.path);
      final bytesimg = File(image.path).readAsBytesSync();
//       print(bytesimg);
// print('its encoded img :  $encodededimg');
      encodededimg = base64Encode(bytesimg);
      showDialog(context: context, builder: (ctx){
        return AlertDialog(
          elevation: 30,
          backgroundColor: Colors.greenAccent[400],
          title: const Center(child: Text('Image added successfully',style:TextStyle(color: Colors.white),)),
        );
      });
    }
  }
}
