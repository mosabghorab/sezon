import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sezon/src/config/constants.dart';
import 'package:sezon/src/modules/_app/ui/pages/navbar_page/navbar_page_controller.dart';

class NavbarPage extends StatefulWidget {
  const NavbarPage({Key? key}) : super(key: key);

  @override
  State<NavbarPage> createState() => _NavbarPageState();
}

class _NavbarPageState extends State<NavbarPage> {
  // controller.
  late final NavbarPageController _navbarPageController =
      Get.find<NavbarPageController>();

  // dispose.
  @override
  void dispose() {
    // dispose and delete controller to not get a memory leak party :).
    Get.delete<NavbarPageController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: GetBuilder<NavbarPageController>(
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
      body: GetBuilder<NavbarPageController>(
        key: UniqueKey(),
        id: 'selectedPageIndex',
        builder: (controller) => controller.pages[controller.selectedPageIndex],
      ),
    );
  }
}
