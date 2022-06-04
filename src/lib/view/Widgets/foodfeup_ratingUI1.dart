import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gsheets/gsheets.dart';
import 'package:tuple/tuple.dart';
import 'package:uni/utils/constants.dart' as Constants;

import 'package:uni/model/entities/review.dart';

import '../../controller/local_storage/app_shared_preferences.dart';

class FoodFeupRating1 extends StatefulWidget{
  final String restaurant, mealname;
  const FoodFeupRating1({Key key, @required this.restaurant, @required this.mealname}) : super(key: key);

  @override
  FoodFeupRating1State createState() => FoodFeupRating1State();
}

class FoodFeupRating1State extends State<FoodFeupRating1> {
  static GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  static Key _k1 = new GlobalKey();

  String rest;
  String meal;
  double rate;
  String username;
  String comment = "";
  bool anonymousComment = false;

  @override
  Widget build(BuildContext context) {
    rest = widget.restaurant;
    meal = widget.mealname;
    return Scaffold(
        body: Center(
          child: ListView(
            children: getWidgets(context),
          ),
        )
    );
  }

  List<Widget> getWidgets(BuildContext context) {
    final List<Widget> widgets = [];

    widgets.add(
        Padding(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8)));
    widgets.add(generateText(
        context, "Toque para avaliar:", TextAlign.center, Colors.black, 16));
    widgets.add(
        Padding(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8)));
    widgets.add(generateRatingBar(context));
    widgets.add(
        Padding(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8)));
    widgets.add(
        generateText(context, "Deixe um commentário", TextAlign.left, Theme
            .of(context)
            .accentColor, 20));
    widgets.add(
        Padding(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8)));
    widgets.add(generateTextInput(context));

    return widgets;
  }

  Widget generateText(BuildContext context, String text, TextAlign alignment,
      Color color, double fontSize) {
    return Text(text,
        style: TextStyle(
            color: color,
            fontWeight: FontWeight.w400,
            fontSize: fontSize
        ),
        textAlign: alignment,
        overflow: TextOverflow.visible
    );
  }

  Widget generateRatingBar(BuildContext context) {
    return Center(
        child: RatingBar.builder(
          initialRating: 0,
          minRating: 0,
          glow: false,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemSize: 50,
          itemPadding: EdgeInsets.symmetric(horizontal: 1.5),
          itemBuilder: (context, _) =>
              Icon(
                Icons.star,
                color: Colors.amber,
              ),
          onRatingUpdate: (rating) {
            rate = rating;
          },
        ));
  }

  Widget generateTextInput(BuildContext context) {
    return Theme(
      data: ThemeData(
        primaryColor: Colors.black,
        primaryColorDark: Colors.black,
      ),
      child: TextField(
        onChanged: (text){comment = text;},
        textAlignVertical: TextAlignVertical.top,
        cursorColor: Colors.black,
        key: _k1,
        maxLines: 2,
        decoration: InputDecoration(
            hintText: 'Clique aqui',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.black),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.black),
              borderRadius: BorderRadius.circular(15),
            )),
      ),
    );
  }
}

