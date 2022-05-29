import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gsheets/gsheets.dart';
import 'package:uni/utils/constants.dart' as Constants;
import 'package:uni/view/Pages/foodfeup_suggestion_view.dart';
import 'package:uni/view/Pages/secondary_page_view.dart';

class FoodFeupSuggestionPage extends StatefulWidget {
  const FoodFeupSuggestionPage({Key key}) : super(key: key);

  @override
  _FoodFeupSuggestionPageState createState() => _FoodFeupSuggestionPageState();
}

class _FoodFeupSuggestionPageState extends SecondaryPageViewState {
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
  String mealRatingQuant = "23";//TODO i dont have this info in google sheets
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
    String dropdownValue = 'Indiferente';//TODO get var from

    final List<String> sheetRatings = await sheet.values.column(4);

    print(sheetRatings);
    //List<int> sheetRatings = ratings.map(int.parse).toList();//parse list to INT
    //final List<String> sheetFood = await sheet.values.column(2);
    int lines = sheetRatings.length;

    if (dropdownValue == 'Indiferente'){
      for(int i = 0; i < lines; i++){
        if (double.parse(sheetRatings[i]) > highestRating){
          highestRating = double.parse(sheetRatings[i]);
          lineCounter = i + 1;//gsheets is indexed starting from 1
        }
      }
    }else{
      final List<String> sheetRestaurants = await sheet.values.column(1);
      for(int i = 0; i < lines; i++){
        if (double.parse(sheetRatings[i]) > highestRating && sheetRestaurants == dropdownValue){
          highestRating = double.parse(sheetRatings[i]);
          lineCounter = i + 1;
        }
      }
    }

    List<String> bestMeal = await sheet.values.row(lineCounter);

    print(bestMeal);

    establishment =  bestMeal[0];
    mealName = bestMeal[1];
    mealType = bestMeal[2];
    mealRating = double.parse(bestMeal[3]);
    //this.mealRatingQuant = "23",//TODO i dont have this info in google sheets

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
          establishment: establishment);
    }
    return FoodFeupSuggestion();
  }
}