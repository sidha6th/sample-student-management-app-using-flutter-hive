import 'dart:io';
import 'package:sample/exports/exports.dart';

class StudentDataController extends GetxController {
  RxList<StudentModel> datacontroler = <StudentModel>[].obs;
  RxList<StudentModel> searchData = <StudentModel>[].obs;
  String tempimg = '';
// ======================= text editing controlles =====================//
  final TextEditingController name = TextEditingController();
  final TextEditingController reg = TextEditingController();
  final TextEditingController age = TextEditingController();
  final TextEditingController std = TextEditingController();
// ======================= text editing controlles =====================//

// ======================= open the main db box ========================//
  Future<Box<StudentModel>> openBox() async {
    Box<StudentModel> studendDB = await Hive.openBox<StudentModel>('studentDB');
    return studendDB;
  }
// ==================== end of open the main db box ====================//

// ====================== add the single data to db ====================//
  addData(StudentModel data) async {
    final studendDB = await Hive.openBox<StudentModel>('studentDB');
    int keys = await studendDB.add(data);
    data.key = keys;
    await studendDB.put(data.key, data);
    datacontroler.add(data);
    clearAllTextField();
  }
// ================== end of add single data to the db =================//

//================ getting all the data from the db ====================//
  getdata() async {
    Box<StudentModel> studendDB = await openBox();
    datacontroler.clear();
    datacontroler.addAll(studendDB.values);
  }
//============== end of getting all the data from the db ===============//

//===================== edit the single data ===========================//
  editData(StudentModel data) async {
    Box<StudentModel> studendDB = await openBox();
    await studendDB.put(data.key, data);
    datacontroler.clear();
    datacontroler.addAll(studendDB.values);
  }
//================== end of edit the single data =======================//

//====================== delete the single data ========================//
  deleteData(key) async {
    Box<StudentModel> studendDB = await openBox();
    studendDB.delete(key);
    datacontroler.clear();
    datacontroler.addAll(studendDB.values);
    searchData.clear();
    searchData.addAll(datacontroler);
  }
//================end of  delete the single data =======================//

// ======================== Clear all the data =========================//
  killdata() async {
    Box<StudentModel> studendDB = await openBox();
    await studendDB.clear();
    datacontroler.clear();
  }
// ====================== End of Clear all the data ====================//

//============================== add photo =============================//
   addPhoto() async {
    dynamic image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
      return '';
    } else {
      Uint8List bytesimg = File(image.path).readAsBytesSync();
      String encodededimg = base64Encode(bytesimg);
      tempimg = encodededimg;
      update();
    }
  }
//======================== end of add photo ============================//

//======================== search results ==============================//
  getSearchResult(String value) {
    searchData.clear();
    if (datacontroler.isNotEmpty) {
      for (var item in datacontroler) {
        if (item.name.toString().toLowerCase().contains(
              value.toLowerCase(),
            )) {
          StudentModel data = StudentModel(
              name: item.name,
              age: item.age,
              reg: item.reg,
              std: item.std,
              key: item.key,
              img: item.img,
              );
          searchData.add(data);
        }
      }
    }
  }
//======================== end of search results ========================//

  clearAllTextField() {
    name.clear();
    reg.clear();
    age.clear();
    std.clear();
  }

//============================= navigation ===============================//
  goToAddPage() {
    tempimg = '';
    clearAllTextField();
    Get.to(
      const AddStudents(
        isadd: true,
      ),
    );
  }

  goToEditPage({required StudentModel data}) {
    tempimg = data.img.toString();
    Get.to(
      AddStudents(
        value: data,
        isadd: false,
      ),
    );
  }

  goToFullDetailesPage({required StudentModel data}) {
    Get.to(
      StudentfullDetail(
        values: data,
        img: data.img,
      ),
    );
  }
}
