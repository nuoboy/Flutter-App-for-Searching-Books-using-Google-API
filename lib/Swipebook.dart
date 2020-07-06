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
import 'main.dart';
import 'books.dart';
import 'description.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

int num = 0;

bool member(String name) {
  for (int i = 0; i < library.length; i++) {
    if (library[i].title == name) {
      return false;
    }
  }
  return true;
}

String authors(authorlist) {
  String author = "";
  for (int i = 0; i < authorlist.length; i++) {
    if (i == 0) {
      author = author + authorlist[i];
    } else {
      author = author + "," + authorlist[i];
    }
  }
  return author;
}

class Swipebook extends StatefulWidget {
  final VoidCallback onPress;
  Book book;
  Swipebook({this.book, this.onPress});
  @override
  _SwipebookState createState() => _SwipebookState(onPress: onPress);
}

class _SwipebookState extends State<Swipebook> {
  final globalKey = GlobalKey<ScaffoldState>();

  final VoidCallback onPress;
  _SwipebookState({this.onPress});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 150.0,
          ),
          Container(
            color: Colors.transparent,
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 300.0,
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 30.0,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: <Widget>[
              Swiper(
                onIndexChanged: (int index) {
                  num = index;
                  setState(() {});
                },
                onTap: (int index) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return (description(
                      para: book.items[index].volumeInfo.description,
                    ));
                  }));
                },
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    color: Colors.grey,
                    width: 500.0,
                    height: 400.0,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 20.0,
                        ),
                        Center(
                          child: Text(book.items[index].volumeInfo.title,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.lato(
                                  textStyle: TextStyle(fontSize: 20.0),
                                  color: Colors.black)),
                        ),
                        Center(
                          child: Text(
                              authors(book.items[index].volumeInfo.authors),
                              textAlign: TextAlign.center,
                              style: GoogleFonts.lato(
                                  textStyle: TextStyle(fontSize: 15.0),
                                  color: Colors.black)),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          width: 200,
                          height: 200,
                          child: Image.network(book
                                      .items[index].volumeInfo.imageLinks ==
                                  null
                              ? "https://thebookworm1305.files.wordpress.com/2013/05/classic_red_book_cover.jpg"
                              : book.items[index].volumeInfo.imageLinks
                                  .thumbnail),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        (book.items[index].volumeInfo.averageRating != null)
                            ? RatingBarIndicator(
                                itemCount: 5,
                                itemSize: 30.0,
                                rating:
                                    book.items[index].volumeInfo.averageRating,
                                itemBuilder: (context, index) {
                                  return Icon(
                                    Icons.star,
                                    color: Colors.amberAccent,
                                  );
                                },
                              )
                            : Text("Rating not available",
                                style: GoogleFonts.lato(
                                    textStyle: TextStyle(fontSize: 15.0),
                                    color: Colors.black)),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  );
                },
                itemCount: book.items.length,
                itemWidth: 350.0,
                itemHeight: 400.0,
                layout: SwiperLayout.TINDER,
                loop: false,
                pagination: SwiperPagination(
                    builder: SwiperPagination.dots,
                    alignment: Alignment.bottomCenter),
              ),
              SizedBox(height: 20),
              Builder(builder: (BuildContext innerContext) {
                return Center(
                    child: FloatingActionButton(
                  elevation: 10.0,
                  focusColor: Colors.grey,
                  hoverColor: Colors.grey,
                  onPressed: () {
                    if (member(book.items[num].volumeInfo.title)) {
                      library.add(book.items[num].volumeInfo);
                    } else {
                      print("snack");
                      final snack = SnackBar(
                        content: Text("Book already added in library"),
                      );
                      Scaffold.of(innerContext).showSnackBar(snack);
                    }
                    print(library);
                    onPress();
                    print('1');
                  },
                  shape: CircleBorder(
                      side: BorderSide(color: Colors.white, width: 1)),
                  child: Icon(Icons.add),
                  backgroundColor: Colors.black,
                ));
              })
            ],
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
