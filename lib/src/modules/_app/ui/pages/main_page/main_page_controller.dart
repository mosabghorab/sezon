import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sezon/src/modules/_app/ui/pages/home_page/home_page.dart';
import 'package:sezon/src/modules/_app/ui/pages/home_page/home_page_controller.dart';

class MainPageController extends GetxController {
  // notifiable.
  int _selectedPageIndex = 0;

  int get selectedPageIndex => _selectedPageIndex;

  set selectedPageIndex(int value) {
    _selectedPageIndex = value;
    update(['selectedPageIndex']);
  }

  // pages info.
  List<Map<String, dynamic>> pagesInfo = [
    {
      'title': 'الرئيسية',
      'icon': 'home',
    },
    {
      'title': 'الفئات',
      'icon': 'categories',
    },
    {
      'title': 'طلباتي',
      'icon': 'orders',
    },
    {
      'title': 'المفضلة',
      'icon': 'favorite',
    },
  ];

  // pages.
  List<Widget> pages = [
    Builder(builder: (context) {
      Get.put<HomePageController>(HomePageController());
      return const HomePage();
    })
    // ChangeNotifierProvider<NotificationsScreenController>(
    //   create: (_) => NotificationsScreenController(),
    //   child: const NotificationsScreen(),
    // ),
    // ChangeNotifierProvider<ChatsScreenController>(
    //   create: (_) => ChatsScreenController(),
    //   child: const ChatsScreen(),
    // ),
    // ChangeNotifierProvider<MyListingScreenController>(
    //   create: (_) => MyListingScreenController(),
    //   child: const MyListingScreen(),
    // ),
  ];

  // on bottom nav bar tapped.
  void onBottomTapBarTapped(int index) {
    selectedPageIndex = index;
  }
}
