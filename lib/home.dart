import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _dataFromAPI;
  Map<String, int> data = {};

  final screens = [
    MyHomePage(),
  
  ];
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
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(top: 50, left: 35),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("COVID - 19 Today in Thailand",
                              style: GoogleFonts.kanit(
                                  fontSize: 24, color: Colors.white)),
                        ],
                      ),
                      Row(
                        children: [
                          Text("สถานการณ์โควิดในประเทศไทยวันนี้",
                              style: GoogleFonts.kanit(
                                  fontSize: 18, color: Colors.white70)),
                        ],
                      ),
                      const Divider(color: Colors.transparent),
                      
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:8.0),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    margin: const EdgeInsets.only(left: 30, right: 30),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Color(0xff2668f4),
                    ),
                    child: Row(
                      children: [
                        Text("ข้อมูลวันที่ " + formattedDate.toString(),
                            style: GoogleFonts.kanit(
                                fontSize: 16, color: Colors.white)),
                      ],
                    ),
                  ),
                ),
                const Divider(color: Colors.transparent),
                buildNewPatient(context)
              ],
            ),
          ),
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

  Container buildNewPatient(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        bottom: 60,
      ),
      child: FutureBuilder(
        future: getCovid19(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var result = snapshot.data;

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 2.7,
                        height: MediaQuery.of(context).size.height / 5,
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.black12.withOpacity(0.2),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                    margin: const EdgeInsets.all(4),
                                    padding: const EdgeInsets.all(8),
                                    decoration: const BoxDecoration(
                                      color: Color(0xfff0c94a),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: const Icon(
                                      CupertinoIcons.person,
                                      color: Colors.black,
                                    )),
                              ],
                            ),
                            const Divider(),
                            Row(
                              children: [
                                Text(
                                  "ผู้ป่วยรายใหม่",
                                  style: GoogleFonts.kanit(
                                      fontSize: 16, color: Colors.white70),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  result["new_case"].toString() + "  คน",
                                  style: GoogleFonts.kanit(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2.7,
                        height: MediaQuery.of(context).size.height / 5,
                        padding: EdgeInsets.all(10),
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.black12.withOpacity(0.2),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                    margin: const EdgeInsets.all(4),
                                    padding: const EdgeInsets.all(8),
                                    decoration: const BoxDecoration(
                                      color: Color(0xfff3ab3f),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: const Icon(
                                      CupertinoIcons.person_2,
                                      color: Colors.black,
                                    )),
                              ],
                            ),
                            const Divider(),
                            Row(
                              children: [
                                Text(
                                  "ผู้ป่วยรายใหม่สะสม",
                                  style: GoogleFonts.kanit(
                                      fontSize: 16, color: Colors.white70),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  result["total_case"].toString() + "  คน",
                                  style: GoogleFonts.kanit(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 2.7,
                        height: MediaQuery.of(context).size.height / 5,
                        padding: const EdgeInsets.all(10),
                       margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.black12.withOpacity(0.2),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                    margin: const EdgeInsets.all(4),
                                    padding: const EdgeInsets.all(8),
                                    decoration: const BoxDecoration(
                                      color: Color(0xfffa9092),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: const Icon(
                                      CupertinoIcons.person,
                                      color: Colors.black,
                                    )),
                              ],
                            ),
                            const Divider(),
                            Row(
                              children: [
                                Text(
                                  "เสียชีวิต",
                                  style: GoogleFonts.kanit(
                                      fontSize: 16, color: Colors.white70),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  result["new_death"].toString() + "  คน",
                                  style: GoogleFonts.kanit(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2.7,
                        height: MediaQuery.of(context).size.height / 5,
                        padding: const EdgeInsets.all(10),
                         margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.black12.withOpacity(0.2),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                    margin: const EdgeInsets.all(4),
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.red.shade400,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                    ),
                                    child: const Icon(
                                      CupertinoIcons.person_2,
                                      color: Colors.black,
                                    )),
                              ],
                            ),
                            const Divider(),
                            Row(
                              children: [
                                Text(
                                  "เสียชีวิตสะสม",
                                  style: GoogleFonts.kanit(
                                      fontSize: 16, color: Colors.white70),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  result["total_death"].toString() + "  คน",
                                  style: GoogleFonts.kanit(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 2.7,
                        height: MediaQuery.of(context).size.height / 5,
                        padding: const EdgeInsets.all(10),
                         margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.black12.withOpacity(0.2),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                    margin: const EdgeInsets.all(4),
                                    padding: const EdgeInsets.all(8),
                                    decoration: const BoxDecoration(
                                      color: Color(0xff95ce81),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: const Icon(
                                      CupertinoIcons.person,
                                      color: Colors.black,
                                    )),
                              ],
                            ),
                            const Divider(),
                            Row(
                              children: [
                                Text(
                                  "หายป่วย",
                                  style: GoogleFonts.kanit(
                                      fontSize: 16, color: Colors.white70),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  result["new_recovered"].toString() + "  คน",
                                  style: GoogleFonts.kanit(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2.7,
                        height: MediaQuery.of(context).size.height / 5,
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.black12.withOpacity(0.2),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                    margin: const EdgeInsets.all(4),
                                    padding: const EdgeInsets.all(8),
                                    decoration: const BoxDecoration(
                                      color: Colors.green,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: const Icon(
                                      CupertinoIcons.person_2,
                                      color: Colors.black,
                                    )),
                              ],
                            ),
                            const Divider(),
                            Row(
                              children: [
                                Text(
                                  "หายป่วยสะสม",
                                  style: GoogleFonts.kanit(
                                      fontSize: 16, color: Colors.white70),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  result["total_recovered"].toString() + "  คน",
                                  style: GoogleFonts.kanit(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }

          if (!snapshot.hasData) {
            return const CupertinoActivityIndicator();
          }
          return const CupertinoActivityIndicator();
        },
      ),
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
    print(_dataFromAPI[0]);

    return _dataFromAPI[0];
  }
}
