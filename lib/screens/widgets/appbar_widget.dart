import 'package:sample/exports/exports.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({
    required this.title,
    required this.isAddpage,
    Key? key,
    required this.data,
  }) : super(key: key);
  final String title;
  final bool isAddpage;
  final StudentDataController data;

  @override
  Widget build(BuildContext context) {
    StudentDataController searchController = Get.find<StudentDataController>();
    return AppBar(
      automaticallyImplyLeading: isAddpage == true ? true : false,
      elevation: 30,
      backgroundColor: Colors.teal[400],
      centerTitle: true,
      title: Text(
        title,
        style: const TextStyle(fontFamily: 'RobotoMono'),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(10),
          //===================search button =================//
          child: isAddpage == false
              ? IconButton(
                  onPressed: () => {
                     searchController.searchData.clear(),
                    searchController.searchData
                        .addAll(searchController.datacontroler),
                    Get.to(
                      Searchpage(),
                    ),
                  },
                  icon: const Icon(
                    Icons.search_sharp,
                    size: 27,
                  ),
                )
              : const SizedBox(),
        ),
        isAddpage == false
            ? Padding(
                padding: const EdgeInsets.only(right: 10),
                child: IconButton(
                    onPressed: () async {
                      return popup(data: data);
                    },
                    icon: const Icon(Icons.restore_page_sharp)),
              )
            : const SizedBox(),
      ],
    );
  }
}
