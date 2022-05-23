import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gsheets/gsheets.dart';
import 'package:uni/model/entities/review.dart';
import 'package:uni/model/food_feup_establishment_page_model.dart';
import 'package:uni/model/utils/day_of_week.dart';
import 'package:uni/utils/constants.dart' as Constants;

import '../../model/entities/meal.dart';

class FoodFeupRating extends StatefulWidget{
  const FoodFeupRating({Key key}) : super(key: key);

  @override
  FoodFeupRatingState createState() => FoodFeupRatingState();
}

class FoodFeupRatingState extends State<FoodFeupRating> {
  static GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  static Key _k1 = new GlobalKey();
  double rate;
  String username;
  String comment;
  bool anonymousComment = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: ListView(
            children: getWidgets(context),
          ),
        )
    );
  }

  bool addToSheets()
  {

    print(comment);
    print(username);
    print(rate);

    Review rev = Review(rate, username, DateTime.now(), Meal("Carne", "Carne com carne",
        DayOfWeek.friday, DateTime.now()), 1);
    rev.addComment(comment);

    //CHANGE MEAL AND RESTAURANT ATTRIBUTES LATER
    print("line51");
    addReview(rev);
  }
  //SEE THIS
  Future<bool> addReview(Review r) async {

    String text = r.toString();

    final gsheets = GSheets(Constants.credentials);
    final ss = await gsheets.spreadsheet(Constants.spreadsheetId);
    Worksheet sheet = ss.worksheetByTitle(r.meal.dayOfWeek.name);

    int line;
    switch(r.meal.type)
    {
      case "Carne":
        line = 1;
        break;
      case "Peixe":
        line = 2;
        break;
      case "Sopa":
        line = 3;
        break;
      case "Dieta":
        line = 4;
        break;
      case "Vegetariano":
        line = 5;
        break;
      default:
        break;
    }
    List<String> row = await sheet.values.row(line);
    await sheet.values.insertValue(text, column: row.length, row: line);
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
    widgets.add(
        Padding(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2)));
    widgets.add(generateCheckBox(context, "Anonimo"));
    widgets.add(
        Padding(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2)));

    widgets.add(generatePostCommentButtom(context));
    widgets.add(
        Padding(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8)));

    widgets.add(Divider(color: Theme
        .of(context)
        .accentColor, thickness: 4));
    widgets.add(
        Padding(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2)));
    widgets.add(
        generateText(context, "Todos os comentários:", TextAlign.center, Theme
            .of(context)
            .accentColor, 26));
    widgets.add(generateText(context, "(1 comentário)", TextAlign.center, Theme
        .of(context)
        .accentColor, 12));

    widgets.add(
        Padding(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8)));
    widgets.add(
        generateCommentField(context, "Comentário bonito aqui", "upxxxxxxxxx"));
    widgets.add(
        generateCommentField(context, "Comentário bonito aqui", "upxxxxxxxxx"));
    widgets.add(
        generateCommentField(context, "It is a long established fact that a reader"
            " will be distracted by the readable content of a page when looking at "
            "its layout. The point of using Lorem Ipsum is that it has a more-or-less "
            "normal distribution of letters, as opposed to using 'Content here, content "
            "here', making it look like readable English. Many desktop publishing "
            "packages and web page editors now use Lorem Ipsum as their default model"
            " text, and a search for 'lorem ipsum' will uncover many web sites still in their"
            " infancy. Various versions have evolved over the years, sometimes by accident, "
            "sometimes on purpose (injected humour and the like). ", "upxxxxxxxxx"));
    widgets.add(
        generateCommentField(context, "Comentário bonito aqui", "upxxxxxxxxx"));
    widgets.add(
        generateCommentField(context, "Comentário bonito aqui", "upxxxxxxxxx"));
    widgets.add(
        generateCommentField(context, "Comentário bonito aqui", "upxxxxxxxxx"));
    widgets.add(
        generateCommentField(context, "Comentário bonito aqui", "upxxxxxxxxx"));
    widgets.add(
        generateCommentField(context, "Comentário bonito aqui", "upxxxxxxxxx"));

    return widgets;
  }

  Widget generateCommentField(BuildContext context, String text, String user) {
    username = user;    //save the username
    return Padding(padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
            child: Center(
              child : SizedBox (
                height: 50,
                child: Row(
                  children: [
                      Column(
                        children: [
                          Icon(IconData(0xe491, fontFamily: 'MaterialIcons')),
                          generateText(context, user, TextAlign.left, Colors.black, 12),
                        ],
                    ),
                    VerticalDivider(color: Colors.grey, thickness: 4),
                    Expanded( child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                        child: generateText(context, text, TextAlign.left, Colors.black, 12)))

        ],
      ),
    )
    )
    );


  }


  Widget generateText(BuildContext context, String text, TextAlign alignment,
      Color color, double fontSize) {
    return Expanded(child:
          Text(text,
              style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w400,
                   fontSize: fontSize
              ),
              textAlign: alignment,
              overflow: TextOverflow.visible)
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
            print(rating);
          },
        ));
  }

  Widget generateTextInput(BuildContext context) {
    comment = "";
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

  Widget generateCheckBox(BuildContext context, String text) {
    return Row(
        children: [
          Checkbox(
            value: this.anonymousComment,
            onChanged: (bool value) {
              setState(() {
                this.anonymousComment = value;
              });
            },
          ),
          generateText(
              context, "Enviar de forma anónima", TextAlign.left, Colors.black,
              16)
        ]
    );
  }

  Widget generatePostCommentButtom(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        child: SizedBox(
            height: 40,
            width: 300,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  primary: Theme
                      .of(context)
                      .accentColor,
                ),
                onPressed: () => addToSheets(),

                child: ListView(
                  children:
                  [ Center(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text("Post",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                              overflow: TextOverflow.ellipsis
                          ),
                          textAlign: TextAlign.center),
                    ),
                  ),
                  ],
                )
            )
        )
    );
  }
}

