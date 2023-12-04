import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:covid19viewer/screens/home.dart';
import 'package:covid19viewer/screens/province_list.dart';

class MyTemplate extends StatefulWidget {
  const MyTemplate({Key? key}) : super(key: key);
  @override
  State<MyTemplate> createState() => _MyTemplatePageState();
}

class _MyTemplatePageState extends State<MyTemplate>
    with SingleTickerProviderStateMixin {
  Map<String, int> data = {};
  int currentIndex = 0;
  late TabController controller;
  var pageController = PageController();
  var screens = [
    const MyHomePage(),
    const MyProvinceListPage(),
  ];
  @override
  void initState() {
    super.initState();
    getCovid19();
    currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff182128),
      body: PageView(
        children: screens,
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        controller: pageController,
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        clipBehavior: Clip.antiAlias,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.transparent,
            border: Border(
              top: BorderSide(
                color: Colors.black87,
                width: 0.5,
              ),
            ),
          ),
          child: BottomNavigationBar(
            selectedFontSize: 12,
            unselectedFontSize: 12,
            selectedItemColor: Colors.blue.shade200,
            unselectedItemColor: Colors.blue,
            currentIndex: currentIndex,
            backgroundColor: Colors.black87,
            onTap: (index) {
              setState(() {
                currentIndex = index;
                pageController.animateToPage(currentIndex,
                    duration: const Duration(microseconds: 500),
                    curve: Curves.easeOut);
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'หน้าหลัก',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.info,
                ),
                label: 'ข้อมูลรายจังหวัด',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Map> getCovid19() async {
    var url =
        Uri.parse('https://covid19.ddc.moph.go.th/api/Cases/today-cases-all');
    var response = await http.get(url);
    var dataFromAPI = jsonDecode(utf8.decode(response.bodyBytes));
    return dataFromAPI[0];
  }
}
