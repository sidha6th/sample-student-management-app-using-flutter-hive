import 'package:flutter/cupertino.dart';
import 'package:sample/exports/exports.dart';

class Searchpage extends StatelessWidget {
  Searchpage({Key? key}) : super(key: key);

  final controller = Get.find<StudentDataController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[400],
        elevation: 30,
        title: CupertinoTextField(
          onChanged: (value) => controller.getSearchResult(value),
        ),
      ),
      body: Obx(
        () {
          if (controller.searchData.isEmpty) {
            return const Center(
              child: SizedBox(
                child: Text('No Data Found'),
              ),
            );
          } else {
            return ListView.separated(
              itemCount: controller.searchData.length,
              itemBuilder: (BuildContext context, index) {
                final data = controller.searchData[index];

                return ListTile(
                  hoverColor: Colors.blueGrey[900],
                  tileColor: Colors.blueGrey,
                  onTap: () {
                    controller.goToFullDetailesPage(data: data);
                  },
                  //================list tile click====================//
                  leading: CommonCircleAvatar(
                    img: data.img ?? '',
                    size: const Size(40, 40),
                    radius: 40,
                  ),
                  title: Text(
                    'Name : ' + data.name.toUpperCase(),
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    'Reg.No : ' + data.reg,
                    style: const TextStyle(color: Colors.white),
                  ),
                  trailing: Wrap(
                    children: [
                      IconButton(
                        onPressed: () {
                          controller.goToEditPage(data: data);
                        },
                        icon: const Icon(Icons.edit),
                        color: Colors.green[600],
                      ), //======================edit  btn===================//
                      IconButton(
                        onPressed: () {
                          if (data.key != null) {
                            controller.deleteData(data.key);
                          }
                        },
                        icon: const Icon(Icons.delete),
                        color: Colors.red,
                      ), //=================remove btn===================//
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, intex) => const Divider(
                height: 1,
              ),
            );
          }
        },
      ),
    );
  }
}
