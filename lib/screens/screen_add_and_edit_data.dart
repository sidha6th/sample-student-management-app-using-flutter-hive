import 'package:sample/exports/exports.dart';

class AddStudents extends StatelessWidget {
  const AddStudents({Key? key,this.value, required this.isadd})
      : super(key: key);
  final bool isadd;
  final StudentModel? value;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final controller = Get.find<StudentDataController>();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(size.width, 50),
        child: AppBarWidget(
          data: controller,
          isAddpage: true,
          title: 'Registration Form',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            SizedBox(
              width: double.infinity,
              child: Center(
                child: GestureDetector(
                  onTap: () async {
                    await controller.addPhoto();
                  },
                  child:
                      GetBuilder<StudentDataController>(builder: (controllers) {
                    return Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SizedBox(
                        width: 90,
                        height: 90,
                        child: Stack(
                          children: [
                            CommonCircleAvatar(
                              img: controller.tempimg,
                              size: const Size(90, 90),
                              radius: 80,
                            ),
                            const Align(
                              alignment: Alignment.bottomRight,
                              child: Icon(
                                Icons.add_a_photo,
                                size: 30,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
            Textfield(
              data: value?.name,
              isnumber: false,
              hindText: 'Student Name',
              textcontroller: controller.name,
            ),
            const CustomSize(
              height: 10,
            ),
            Textfield(
              data: value?.reg,
              isnumber: true,
              textcontroller: controller.reg,
              hindText: 'Reg No.',
            ),
            const CustomSize(
              height: 10,
            ),
            Textfield(
              data: value?.age,
              isnumber: true,
              textcontroller: controller.age,
              hindText: 'Age',
            ),
            const CustomSize(
              height: 10,
            ),
            Textfield(
              data: value?.std,
              isnumber: true,
              textcontroller: controller.std,
              hindText: 'Class',
            ),
            const CustomSize(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                if (controller.name.text.trim().isEmpty ||
                    controller.age.text.trim().isEmpty ||
                    controller.reg.text.trim().isEmpty) {
                  Get.snackbar('', '',
                      titleText: const Text(
                        'Please fill the fields',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      isDismissible: true,
                      colorText: Colors.redAccent);
                } else if (value == null) {
                  final addvalue = StudentModel(
                    name: controller.name.text,
                    age: controller.age.text,
                    reg: controller.reg.text,
                    std: controller.std.text,
                    img: controller.tempimg,
                  );
                  controller.addData(addvalue);
                  Get.off(
                    const HomeScreen(),
                  );
                } else {
                  final values = StudentModel(
                    key: value!.key,
                    name: controller.name.text,
                    age: controller.age.text,
                    reg: controller.reg.text,
                    std: controller.std.text,
                    img: controller.tempimg,
                  );
                  controller.editData(values);
                  Get.off(
                    const HomeScreen(),
                  );
                }
              },
              child: const Text('Submit'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green[400]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
