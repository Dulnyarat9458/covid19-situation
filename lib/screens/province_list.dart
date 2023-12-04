import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:covid19viewer/screens/province_detail.dart';

class MyProvinceListPage extends StatefulWidget {
  const MyProvinceListPage({Key? key}) : super(key: key);
  @override
  State<MyProvinceListPage> createState() => _MyProvinceListPageState();
}

class _MyProvinceListPageState extends State<MyProvinceListPage> {
  var province = [];
  Map<String, int> data = {};

  @override
  void initState() {
    super.initState();
    getCovid19();
  }

  @override
  Widget build(BuildContext context) {
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
                      Text(
                        "เลือกจังหวัดที่ต้องการหาข้อมูล",
                        style: GoogleFonts.kanit(
                            fontSize: 24, color: Colors.white),
                      ),
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
                          builder: (builder) => ProvinceDetailPage(
                            index: index,
                            province: province[index],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getCovid19() async {
    var dio = Dio();
    var response = await dio.get(
        'https://covid19.ddc.moph.go.th/api/Cases/today-cases-by-provinces');
    for (var i = 0; i < response.data.length - 1; i++) {
      setState(() {
        province.add(response.data[i]["province"]);
      });
    }
  }
}
