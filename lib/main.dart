import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:io';
import 'books.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:async';
import 'Swipebook.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

List<VolumeInfo> library = [];
bool loading = true;
bool noresult = false;
void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));

}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

Book book = Book();

class _MyAppState extends State<MyApp> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  getBook1(BuildContext innercontext) async {
    loading = false;
    setState(() {});
    print('Im Starting');
    final jsonResponse =
        await http.get('https://www.googleapis.com/books/v1/volumes?q=$text');
    _controller.text = "";
    if (jsonResponse.statusCode == 200) {
      loading = true;
      setState(() {});
    } else {
      noresult = true;
    }

    try {

      var bookie = bookFromJson(jsonResponse.body);
      book = bookie;

      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return (Swipebook(
          book: book,
          onPress: () {
            setState(() {
              print(library.length);
            });
          },
        ));
      }));
    } catch (e) {
      print(e);
      book = Book();
      noresult = true;
    }
    print(book.totalItems);
    if (noresult) {
      print("here");
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("No book found"),
      ));
      noresult = false;
    }
  }

  final _controller = TextEditingController();
  String text;
  void initState() {
    super.initState();
    setState(() {});
    _controller.addListener(() {
      text = _controller.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          body: Container(
            decoration: BoxDecoration(color: Colors.black),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 40.0,
                  height: 30,
                ),
                Text(
                  "Find Your Book",
                  style: GoogleFonts.nunitoSans(
                      textStyle:
                          TextStyle(color: Colors.white, fontSize: 60.0)),
                ),
                SizedBox(
                  width: 30.0,
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.all(1),
                  color: Colors.white,
                  child: Container(
                    color: Colors.black,
                    child: TextField(
                      selectionHeightStyle: BoxHeightStyle.max,
                      style: GoogleFonts.nunitoSans(
                          textStyle:
                              TextStyle(color: Colors.white, fontSize: 15)),
                      decoration: InputDecoration(
                        hintStyle: GoogleFonts.nunitoSans(
                            color: Colors.grey, fontSize: 15.0),
                        hintText: "Enter author name or book name",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(1.0)),
                        fillColor: Colors.black26,
                        filled: true,
                        icon: Icon(
                          Icons.search,
                          color: Colors.grey,
                          size: 40.0,
                        ),
                      ),
                      controller: _controller,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                (loading)
                    ? Builder(
                        builder: (BuildContext innercontext) {
                          return Center(
                            child: Container(
                              padding: EdgeInsets.all(1),
                              color: Colors.grey,
                              child: Container(
                                  //padding: EdgeInsets.fromLTRB(0, 0, 7, 7),
                                  color: Colors.black,
                                  child: RaisedButton(
                                    padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                    colorBrightness: Brightness.light,
                                    elevation: 10,
                                    child: Text(
                                      "Search",
                                      style: GoogleFonts.nunitoSans(
                                          textStyle: TextStyle(
                                              fontStyle: FontStyle.normal,
                                              color: Colors.white,
                                              fontSize: 20.0)),
                                    ),
                                    color: Colors.black,
                                    onPressed: () {
                                      getBook1(context);
                                    },
                                  )),
                            ),
                          );
                        },
                      )
                    : Center(
                        child: Column(
                        children: <Widget>[
                          CircularProgressIndicator(
                            backgroundColor: Colors.black,
                          ),
                        ],
                      )),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Library",
                      style: GoogleFonts.nunitoSans(
                          textStyle: TextStyle(
                              fontStyle: FontStyle.normal,
                              color: Colors.white,
                              fontSize: 30.0)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                (library.length > 0)
                    ? Center(
                        child: Container(
                          color: Colors.black,
                          height: 260.0,
                          width: 500.0,
                          child: Center(
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: library.length,
                              itemBuilder: (context, index) {
                                return Center(
                                  child: Container(
                                    color: Colors.grey,
                                    width: 250,
                                    height: 260.0,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          library[index].title,
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.nunitoSans(
                                              textStyle: TextStyle(
                                                  fontStyle: FontStyle.normal,
                                                  color: Colors.black,
                                                  fontSize: 15.0)),
                                        ),
                                        Image.network(
                                            library[index].imageLinks.thumbnail)
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      )
                    : Center(
                        child: Container(
                          width: 200,
                          height: 200,
                          color: Colors.grey,
                          child: Center(
                            child: Text(
                              "Library Empty",
                              style: GoogleFonts.nunitoSans(
                                  textStyle: TextStyle(
                                      fontStyle: FontStyle.normal,
                                      color: Colors.black,
                                      fontSize: 20.0)),
                            ),
                          ),
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
