import 'dart:convert';
import 'package:covid19viewer/home.dart';

import 'package:covid19viewer/selectjungwhat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class MyMainScreenPage extends StatefulWidget {
  const MyMainScreenPage({Key? key}) : super(key: key);
  @override
  State<MyMainScreenPage> createState() => _MyMainScreenPageState();
}

class _MyMainScreenPageState extends State<MyMainScreenPage>
    with SingleTickerProviderStateMixin {
  var _dataFromAPI;
  Map<String, int> data = {};
  int currentIndex = 0;
  late TabController controller;
  var pageController = PageController();
  var screens = [
    const MyHomePage(),
    const MySelectJungWhatPage(),
  ];
  @override
  void initState() {
    super.initState();
    getCovid19();
    currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd/MM/yyyy เวลา kk:mm').format(now);debugShowCheckedModeBanner:false;
    return Scaffold(
      backgroundColor: const Color(0xff182128),
      body: PageView(
          children: screens,
          onPageChanged: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          controller: pageController),
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
                // BottomNavigationBarItem(
                //   icon: Icon(Icons.more),
                //   label: 'ตัวเลือกอื่น ๆ ',
                // )
              ]),
        ),
      ),
      // floatingActionButtonLocation:
      //     FloatingActionButtonLocation.miniStartDocked,
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: FloatingActionButton(
      //       backgroundColor: const Color(0xff2668f4),
      //       child: const Icon(
      //         Icons.home,
      //         size: 40,
      //       ),
      //       onPressed: () {
      //         setState(() {
      //           Navigator.pushAndRemoveUntil(
      //               context,
      //               MaterialPageRoute(builder: (builder) => MyMainScreenPage()),
      //               (route) => false);
      //         });
      //       }),
      // ),
    );
  }

  Future<Map> getCovid19() async {
    var url =
        Uri.parse('https://covid19.ddc.moph.go.th/api/Cases/today-cases-all');
    var response = await http.get(url);
    _dataFromAPI = jsonDecode(utf8.decode(response.bodyBytes));
    // ignore: avoid_print
    print(_dataFromAPI[0]["txn_date"]);
    // ignore: avoid_print
    print(_dataFromAPI);
    return _dataFromAPI[0];

  }
}
