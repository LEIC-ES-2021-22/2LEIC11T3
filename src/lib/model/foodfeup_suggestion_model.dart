import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gsheets/gsheets.dart';
import 'package:uni/utils/constants.dart' as Constants;
import 'package:uni/view/Pages/foodfeup_suggestion_view.dart';
import 'package:uni/view/Pages/secondary_page_view.dart';

class FoodFeupSuggestionPage extends StatefulWidget {
  FoodFeupSuggestionPage({Key key, this.dropdownValue}) : super(key: key);
  final String dropdownValue;
  @override
  _FoodFeupSuggestionPageState createState() => _FoodFeupSuggestionPageState(dropdownValue: dropdownValue);
}

class _FoodFeupSuggestionPageState extends SecondaryPageViewState {
  _FoodFeupSuggestionPageState({Key key, this.dropdownValue});
  final String dropdownValue;
  final int weekDay = DateTime
      .now()
      .weekday;

  final List<String> options = [//TODO: why is this here?
    'Indiferente',
    'Carne',
    'Peixe',
    'Vegetariano',
    'Dieta',
    'Sopa',
  ];

  String mealType;
  double mealRating;
  String mealRatingQuant;//TODO i dont have this info in google sheets
  String mealName;
  String establishment;


  Worksheet sheet;

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

  Future getHighestInCategory() async{
    final gsheets = GSheets(Constants.credentials);
    // fetch spreadsheet by its id
    final ss = await gsheets.spreadsheet(Constants.spreadsheetId);

    final sheet = ss.worksheetByTitle('Sheet2');

    double highestRating = -1;
    int lineCounter = -1;

    final List<String> sheetRatings = await sheet.values.column(4);

    int lines = sheetRatings.length;
    if (dropdownValue == 'Indiferente' || dropdownValue == null){
      for(int i = 0; i < lines; i++){
        if (double.parse(sheetRatings[i]) > highestRating){
          highestRating = double.parse(sheetRatings[i]);
          lineCounter = i + 1;//gsheets is indexed starting from 1
        }
      }
    }else{
      final List<String> sheetCategory = await sheet.values.column(3);
      for(int i = 0; i < lines; i++){
        if (double.parse(sheetRatings[i]) > highestRating && sheetCategory[i] == dropdownValue){
          highestRating = double.parse(sheetRatings[i]);
          lineCounter = i + 1;
        }
      }
    }

    List<String> bestMeal = await sheet.values.row(lineCounter);

    establishment =  bestMeal[0];
    mealName = bestMeal[1];
    mealType = bestMeal[2];
    mealRating = double.parse(bestMeal[3]);
    mealRatingQuant = "23"; //TODO i dont have this info in google sheets

    return sheet;
  }


  @override
  Widget getBody(BuildContext context) {
    if (sheet == null) {
      getHighestInCategory().then((sheet) {
        setState(() {
          this.sheet = sheet;
        });
      });
      return LoadingScreen();
    } else {
      return FoodFeupSuggestion(
          mealType: mealType,
          mealRating: mealRating,
          mealRatingQuant: mealRatingQuant,
          mealName: mealName,
          establishment: establishment,
          dropdownValue: dropdownValue
      );
    }
  }
}