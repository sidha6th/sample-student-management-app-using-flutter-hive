
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sample/addData.dart';
import 'package:sample/db/dataBase.dart';
import 'fullDetailPage.dart';

class Searchpage extends StatefulWidget {
  

  const Searchpage({ Key? key}) : super(key: key);
  @override
  _SearchpageState createState() => _SearchpageState();
}
final TextEditingController search=TextEditingController();

class _SearchpageState extends State<Searchpage> {
_SearchpageState();
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[400],
        elevation: 30,
        title: TextField(onChanged:(value){
          setState(() {
            
          });
        },
          decoration: const InputDecoration(suffixIcon: Icon(Icons.search,color: Colors.white,size: 30,),hintText: 'Search Here..',fillColor: Colors.white),
          controller: search,
        ),
      ),
      body:ValueListenableBuilder(
            valueListenable: studentDataNotifier,
            builder: (BuildContext context, List<StudentModel> studentlist,
                Widget? child) {
              return ListView.separated(
                  itemBuilder: (BuildContext context, intex) {
                 var  values = studentlist[intex];
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
                    if(values.name.toString().toLowerCase().contains(search.text.toLowerCase())){
                    return ListTile(
                      hoverColor: Colors.blueGrey[900],
                      tileColor: Colors.blueGrey,
                      onTap: () {
                        listTileClick(context, values,image);


                      },
                      //================list tile click====================//

                      leading: CircleAvatar(
                        backgroundImage: image,
                      ),

                      title: Text(
                        'Name:  ' + '${values.name}'.toUpperCase(),
                        style:const TextStyle(color: Colors.white),
                      ),
                      subtitle: Text('Reg.No:  ${values.reg}',
                          style:const TextStyle(color: Colors.white)),

                      trailing: Wrap(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctxA) =>
                                      AddStudents(value: values)));
                            },
                            icon:const Icon(Icons.edit),
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
                            icon:const Icon(Icons.delete),
                            color: Colors.red,
                          ), //=================remove btn===================//
                        ],
                      ),
                    );}else{
                      return Container();
                    }
                  },
                  separatorBuilder: (BuildContext context, intex) =>
                      const Divider(
                        height: 1,
                      ),
                  itemCount: studentlist.length);
            }),


    );
  }

            //=============list tile click=============//


   listTileClick(BuildContext context, StudentModel value,img) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => StudentfullDetail(
              values: value,
            )));
  }




}