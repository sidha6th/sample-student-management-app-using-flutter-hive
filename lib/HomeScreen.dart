import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sample/db/dataBase.dart';
import 'package:sample/searchdata.dart';
import 'addData.dart';
import 'fullDetailPage.dart';

class HomeScreen extends StatelessWidget {
const  HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    getallstudents();
    return WillPopScope(
      onWillPop: () async {
        var value = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Quit ?'),
                content: const Text('Are you sure you want to exit?'),
                actions: <Widget>[
                  ElevatedButton(
                    child: const Text('No'),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                  ElevatedButton(
                    child: const Text('Yes, exit'),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                  ),
                ],
              );
            });

        return value == true;
      },
      child: SafeArea(
          child: Scaffold(
        //======================appbar========================//

        appBar: AppBar(
          elevation: 30,
          backgroundColor: Colors.teal[400],
          centerTitle: true,
          title: const Center(
              child: Text(
            'Student\'s Data',
            style: TextStyle(fontFamily: 'RobotoMono'),
          )),
          actions: [
            Padding(
              padding: const EdgeInsets.all(10),
              //===================search button =================//
              child: IconButton(
                  onPressed: () {
                    search(context);
                  },
                  icon: const Icon(
                    Icons.search_sharp,
                    size: 27,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                  onPressed: () {
                    killdata(context);
                  },
                  icon: const Icon(Icons.restore_page_sharp)),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.teal[400],
          hoverColor: Colors.teal[800],
          onPressed: () => addBtnClick(context),
          child: const Icon(Icons.add),
        ),

        body: ValueListenableBuilder(
            valueListenable: studentDataNotifier,
            builder: (BuildContext context, List<StudentModel> studentlist,
                Widget? child) {
              return ListView.separated(
                  itemBuilder: (BuildContext context, intex) {
                    var values = studentlist[intex];
                    var real = values.img;
                    debugPrint('real img length ${real.toString().length}');
                   
                    dynamic image= const AssetImage(r'assets\images\defaultimage.jpg');
                    if (real.toString().length<2) {
                      debugPrint('assetimage');
                      image = const AssetImage(r'assets\images\defaultimage.jpg');
                    } else {
                      debugPrint('memmory image');
                     dynamic images = const Base64Decoder().convert(real.toString());
                      image = MemoryImage(images);
                    }
                    return ListTile(
                      hoverColor: Colors.blueGrey[900],
                      tileColor: Colors.blueGrey,
                      onTap: () {
                        listTileClick(context, values, image);
                      },
                      
                      //================list tile click====================//
                      leading:  CircleAvatar(backgroundImage: image,),
                      title: Text(
                        'Name:  ' + '${values.name}'.toUpperCase(),
                        style: const TextStyle(color: Colors.white),
                      ),
                      subtitle: Text('Reg.No:  ${values.reg}',
                          style: const TextStyle(color: Colors.white)),

                      trailing: Wrap(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctxA) =>
                                      AddStudents(value: values)));
                            },
                            icon: const Icon(Icons.edit),
                            color: Colors.green[600],
                          ), //======================edit  btn===================//
                          IconButton(
                            onPressed: () {
                              if (values.key != null) {
                                deletebtn(values.key);
                              } else {
                                // print('nokeys');
                              }
                            },
                            icon: const Icon(Icons.delete),
                            color: Colors.red,
                          ), //=================remove btn===================//
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, intex) =>
                      const Divider(
                        height: 1,
                      ),
                  itemCount: studentlist.length);
            }),
      )),
    );
  }

//===================list tile click=========================//
  listTileClick(BuildContext context, StudentModel value, img) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => StudentfullDetail(
              values: value,
            )));
  }
//===================list tile click=========================//

//==================add btn click============================//

  addBtnClick(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctxA) =>const AddStudents()));
  }
//==================add btn click=============================//

  search(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) =>const Searchpage()));
  }
}
