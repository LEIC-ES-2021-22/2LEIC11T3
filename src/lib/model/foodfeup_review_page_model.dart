import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gsheets/gsheets.dart';
import 'package:uni/utils/constants.dart' as Constants;
import 'package:uni/view/Pages/foodfeup_suggestion_view.dart';
import 'package:uni/view/Pages/secondary_page_view.dart';
import 'package:uni/view/Widgets/foodfeup_ratingUI1.dart';

class FoodFeupReviewPage extends StatefulWidget {
  final String meal, resturant;
  const FoodFeupReviewPage({Key key, @required this.meal, @required this.resturant}) : super(key: key);

  @override
  _FoodFeupReviewPageState createState() => _FoodFeupReviewPageState(meal: this.meal, rest: this.resturant);
}

class _FoodFeupReviewPageState extends SecondaryPageViewState {
  String meal, rest;
  _FoodFeupReviewPageState({@required this.meal, @required this.rest}) {}

  List<List<String>> comments;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget LoadingScreen() {
    return Center(
        child: SizedBox(
          width: 60,
          height: 60,
          child: CircularProgressIndicator(),
        )
    );
  }

  Future getComments() async {
    this.comments = [];

    final gsheets = GSheets(Constants.credentials);
    final ss = await gsheets.spreadsheet(Constants.spreadsheetId);
    Worksheet sheet = ss.worksheetByTitle("Sheet2");

    List<String> col = await sheet.values.column(2);
    for(int i = 0; i < col.length; i++)
    {

      if (col[i] == meal)
      {
        List<String> row = await sheet.values.row(i+1);
        int index = 0;
        for(String s in row) {
          if(index < 4 ) {
            index = index + 1;
            continue;
          }
          List<String> comm = s.split('&');
          if(comm[2] != "") {
            comments.add(comm);
          }
          index = index + 1;
        }

      }
    }

    return comments;
  }

  @override
  Widget getBody(BuildContext context) {
    if (this.comments == null) {
      getComments().then((l) {
        setState(() {
          this.comments = l;
        });
      });
      return LoadingScreen();
    } else {
      return FoodFeupRating1(

      );
    }
  }
}