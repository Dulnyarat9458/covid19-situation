import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _dataFromAPI;
  Map<String, int> data = {};
  @override
  void initState() {
    super.initState();
    getCovid19();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[buildNewPatient(context)],
          ),
        ),
      ),
    );
  }

  Container buildNewPatient(BuildContext context) {
    return Container(
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
                        height: MediaQuery.of(context).size.height / 5.8,
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.black12.withOpacity(0.2),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "ผู้ป่วยรายใหม่",
                              style: GoogleFonts.kanit(
                                  fontSize: 16, color: Colors.white),
                            ),
                            Text(
                              result["new_case"].toString() + "  คน",
                              style: GoogleFonts.kanit(
                                  fontSize: 18, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2.7,
                        height: MediaQuery.of(context).size.height / 5.8,
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.black12.withOpacity(0.2),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "ผู้ป่วยรายใหม่สะสม",
                              style: GoogleFonts.kanit(
                                  fontSize: 16, color: Colors.white),
                            ),
                            Text(
                              result["total_case"].toString() + "  คน",
                              style: GoogleFonts.kanit(
                                  fontSize: 18, color: Colors.white),
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
                        height: MediaQuery.of(context).size.height / 5.8,
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.black12.withOpacity(0.2),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "เสียชีวิต",
                              style: GoogleFonts.kanit(
                                  fontSize: 16, color: Colors.white),
                            ),
                            Text(
                              result["new_death"].toString() + "  คน",
                              style: GoogleFonts.kanit(
                                  fontSize: 18, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2.7,
                        height: MediaQuery.of(context).size.height / 5.8,
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.black12.withOpacity(0.2),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "เสียชีวิตสะสม",
                              style: GoogleFonts.kanit(
                                  fontSize: 16, color: Colors.white),
                            ),
                            Text(
                              result["total_death"].toString() + "  คน",
                              style: GoogleFonts.kanit(
                                  fontSize: 18, color: Colors.white),
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
                        height: MediaQuery.of(context).size.height / 5.8,
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.black12.withOpacity(0.2),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "หายป่วย",
                              style: GoogleFonts.kanit(
                                  fontSize: 16, color: Colors.white),
                            ),
                            Text(
                              result["new_recovered"].toString() + "  คน",
                              style: GoogleFonts.kanit(
                                  fontSize: 18, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2.7,
                        height: MediaQuery.of(context).size.height / 5.8,
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.black12.withOpacity(0.2),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "หายป่วยสะสม",
                              style: GoogleFonts.kanit(
                                  fontSize: 16, color: Colors.white),
                            ),
                            Text(
                              result["total_recovered"].toString() + "  คน",
                              style: GoogleFonts.kanit(
                                  fontSize: 18, color: Colors.white),
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
            var result = snapshot.data;
            double amount = 10000;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [Text("Loading")],
              ),
            );
          }
          return LinearProgressIndicator();
        },
      ),
    );
  }

  Future<Map> getCovid19() async {
    var url =
        Uri.parse('https://covid19.ddc.moph.go.th/api/Cases/today-cases-all');
    var response = await http.get(url);

    _dataFromAPI = jsonDecode(utf8.decode(response.bodyBytes));
    print(_dataFromAPI[0]["txn_date"]);
    print(_dataFromAPI[0]);

    return _dataFromAPI[0];
  }
}
