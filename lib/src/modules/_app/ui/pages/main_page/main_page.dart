import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sezon/src/config/constants.dart';
import 'package:sezon/src/modules/_app/ui/pages/main_page/main_page_controller.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // controller.
  late final MainPageController _mainPageController =
      Get.find<MainPageController>();

  // dispose.
  @override
  void dispose() {
    // dispose and delete controller to not get a memory leak party :).
    _mainPageController.dispose();
    Get.delete<MainPageController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: GetBuilder<MainPageController>(
          id: 'selectedPageIndex',
          builder: (controller) => BottomNavigationBar(
                onTap: controller.onBottomTapBarTapped,
                currentIndex: controller.selectedPageIndex,
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.white,
                items: List.generate(
                  controller.pagesInfo.length,
                  (index) => BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      '${Constants.assetsVectorsPath}${controller.pagesInfo[index]['icon']}.svg',
                      color: controller.selectedPageIndex == index
                          ? Get.theme.primaryColor
                          : null,
                    ),
                    label: controller.pagesInfo[index]['title'],
                  ),
                ),
              )),
      body: GetBuilder<MainPageController>(
        key: UniqueKey(),
        id: 'selectedPageIndex',
        builder: (controller) =>
            controller.pages()[controller.selectedPageIndex],
      ),
    );
  }
}
