import 'package:sample/exports/exports.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    StudentDataController data = Get.find<StudentDataController>();
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
          },
        );
        return value ?? false;
      },
      child: Scaffold(
        //======================appbar========================//
        appBar: PreferredSize(
          preferredSize: Size(size.width, 50),
          child: AppBarWidget(
            title: 'Student\'s Data',
            data: data,
            isAddpage: false,
          ),
        ),

//==============================================body================================================//
        body: Obx(
          () => data.datacontroler.isEmpty
              ? const Center(
                  child: Text(
                    'No Data found',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                )
              : ListView.separated(
                  itemCount: data.datacontroler.length,
                  itemBuilder: (BuildContext context, intex) {
                    final datas = data.datacontroler[intex];
                    return ListTile(
                      tileColor: Colors.blueGrey,
                      onTap: () {
                        data.goToFullDetailesPage(data: datas);
                      },
                      leading: CommonCircleAvatar(
                        img: datas.img ?? '',
                        radius: 40,
                        size: const Size(40, 40),
                      ),
                      title: Text(
                        'Name' + ' : ${datas.name}'.toUpperCase(),
                        style: const TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        'Reg.No :  ${datas.reg}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      trailing: Wrap(
                        children: [
                          IconButton(
                            onPressed: () {
                              data.goToEditPage(data: datas);
                            },
                            icon: const Icon(Icons.edit),
                            color: Colors.green[600],
                          ), //======================editbtn===================//
                          IconButton(
                            onPressed: () {
                              if (datas.key != null) {
                                data.deleteData(datas.key);
                              } else {}
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
                ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.teal[400],
          hoverColor: Colors.teal[800],
          onPressed: () => {data.goToAddPage()},
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

//========== Clear all data popup===========//
Future<dynamic> popup({StudentDataController? data}) async {
  return Get.defaultDialog(
    middleText: '',
    backgroundColor: Colors.blueGrey,
    title: 'Clear Data',
    content: const Text('Are you sure to Clear all the data'),
    titlePadding: const EdgeInsets.all(10),
    titleStyle: const TextStyle(color: Colors.white, fontSize: 15),
    textConfirm: 'Clear Data',
    textCancel: 'No',
    onConfirm: () async => {
      await data!.killdata(),
      Get.back(),
    },
    onCancel: () => Get.back(),
  );
}
//========== Clear all data popup===========//