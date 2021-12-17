import 'dart:convert';
import 'package:covid19viewer/raijung.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class MySelectJungWhatPage extends StatefulWidget {
  const MySelectJungWhatPage({Key? key}) : super(key: key);
  @override
  State<MySelectJungWhatPage> createState() => _MySelectJungWhatPageState();
}

class _MySelectJungWhatPageState extends State<MySelectJungWhatPage> {
  var province = [];
  Map<String, int> data = {};

  @override
  void initState() {
    super.initState();
    getCovid19();
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd/MM/yyyy เวลา kk:mm').format(now);
    return Scaffold(
      backgroundColor: const Color(0xff182128),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              Color(0xff231b33),
              Color(0xff182128),
            ],
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 40, left: 35),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("เลือกจังหวัดที่ต้องการหาข้อมูล",
                          style: GoogleFonts.kanit(
                              fontSize: 24, color: Colors.white)),
                    ],
                  ),
                  const Divider(color: Colors.transparent),
                ],
              ),
            ),
            Flexible(
              child: ListView.builder(
                  itemCount: province.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: const Icon(
                        CupertinoIcons.map,
                        color: Color(0xff2668f4),
                      ),
                      trailing: Text(
                        "แตะเพือดูข้อมูล",
                        style:
                            GoogleFonts.kanit(color: Colors.cyan, fontSize: 15),
                      ),
                      title: Text(
                        (index + 1).toString() +
                            ". " +
                            province[index].toString(),
                        style: GoogleFonts.kanit(color: Colors.white),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (builder) => RaiJungPage(
                              index: index,province:province[index],
                            ),
                          ),
                        );
                      },
                    );
                  }),
            ),
          ],
        ),
      ),

      // bottomNavigationBar: BottomAppBar(
      //   shape: const CircularNotchedRectangle(),
      //   notchMargin: 8.0,
      //   clipBehavior: Clip.antiAlias,
      //   child: Container(
      //     decoration: const BoxDecoration(
      //       color: Colors.transparent,
      //       border: Border(
      //         top: BorderSide(
      //           color: Colors.black87,
      //           width: 0.5,
      //         ),
      //       ),
      //     ),
      //     child: BottomNavigationBar(
      //         selectedFontSize: 12,
      //         unselectedFontSize: 12,
      //         selectedItemColor: Colors.blueGrey,
      //         unselectedItemColor: Colors.blue.shade200,
      //         currentIndex: 1,
      //         backgroundColor: Colors.black87,
      //         onTap: (index) {
      //           setState(() {
      //             // _currentIndex = index;
      //           });
      //         },
      //         items: const [
      //           BottomNavigationBarItem(
      //             icon: Icon(
      //               Icons.info,
      //             ),
      //             label: 'ข้อมูลรายจังหวัด',
      //           ),
      //           BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
      //           BottomNavigationBarItem(
      //             icon: Icon(Icons.more),
      //             label: 'ตัวเลือกอื่น ๆ ',
      //           )
      //         ]),
      //   ),
      // ),
      // floatingActionButtonLocation:
      //     FloatingActionButtonLocation.miniCenterDocked,
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.all(4.0),
      //   child: FloatingActionButton(
      //     backgroundColor: const Color(0xff2668f4),
      //     child: const Icon(Icons.home),
      //     onPressed: () => setState(() {
      //       // _currentIndex = 1;
      //     }),
      //   ),
      //  ),
    );
  }

  Future<void> getCovid19() async {
    var dio = Dio();
    var response = await dio.get(
        'https://covid19.ddc.moph.go.th/api/Cases/today-cases-by-provinces');
    print("RES IS");
    print(response);
    print("RES SIZE IS");
    print(response.data.length);

    for (var i = 0; i < response.data.length - 1; i++) {
      setState(() {
        province.add(response.data[i]["province"]);
      });
    }
  }
}
