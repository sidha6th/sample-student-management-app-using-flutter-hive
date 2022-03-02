import 'package:sample/exports/exports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final controller=Get.put(StudentDataController());
  final document = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(document.path);
  if (!Hive.isAdapterRegistered(StudentModelAdapter().typeId)) {
    Hive.registerAdapter(StudentModelAdapter());
  }
  await controller.getdata();
  runApp(const Myapp());
}

class Myapp extends StatefulWidget {
  const Myapp({Key? key}) : super(key: key);

  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(backgroundColor: Colors.black,fontFamily: 'RobotoMono'),
      debugShowCheckedModeBanner: false,
      home:const SplashScreen(),
    );
  }
}
