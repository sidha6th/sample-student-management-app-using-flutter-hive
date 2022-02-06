import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sample/db/dataBase.dart';


class StudentfullDetail extends StatelessWidget {
  final StudentModel values;

 const StudentfullDetail({Key? key, required this.values}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      var real = values.img;
                    // print('real img length ${real.toString().length}');
                    dynamic images;
                    
                    if(real.toString().length<2){
                     images=const AssetImage(r'assets\images\defaultimage.jpg');
                    }else{
                      images =const Base64Decoder().convert(real.toString());
                    images=MemoryImage(images);
                    }
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(elevation: 30,

          backgroundColor: Colors.teal[400],
          title: Text('student Details'.toUpperCase()),
          centerTitle: true,
        ),
        backgroundColor: Colors.lightBlueAccent[400],
        body: Container(
          decoration: BoxDecoration(
              border: Border.all(
            width: 1,
            color: Colors.white,
          )),
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Center(
                    child:CircleAvatar(backgroundImage: images,) ),                Text(
                  'name    : ${values.name}',
                  style:const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
                Text('Age       : ${values.age}',
                    style:const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    )),
                Text('Reg.No : ${values.reg}',
                    style:const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    )),
                Text('Class    : ${values.std}',
                    style:const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
