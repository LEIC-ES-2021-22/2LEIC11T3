import 'package:flutter/material.dart';
import 'package:uni/model/entities/meal.dart';
import 'package:uni/model/utils/day_of_week.dart';
import 'package:gsheets/gsheets.dart';
import 'package:uni/view/Pages/secondary_page_view.dart';
import 'package:uni/view/Pages/foodfeup_establishment_view.dart';
import 'package:uni/utils/constants.dart' as Constants;

import 'entities/review.dart';

class FoodFeupEstablishmentPage extends StatefulWidget {
  const FoodFeupEstablishmentPage({Key key,
      @required this.restaurantName,
      @required this.meals}) :
        super(key: key);

  final String restaurantName;
  final Map<DayOfWeek, List<Meal>> meals;

  @override
  _FoodFeupEstablishmentPageState createState() => _FoodFeupEstablishmentPageState(
      restaurantName: this.restaurantName,
      meals: this.meals
  );
}

class _FoodFeupEstablishmentPageState extends SecondaryPageViewState
    with SingleTickerProviderStateMixin {
  _FoodFeupEstablishmentPageState(
      {Key key,
        @required this.restaurantName,
        @required this.meals
  });
  final String restaurantName;
  final Map<DayOfWeek, List<Meal>> meals;

  final int weekDay = DateTime
      .now()
      .weekday;

  Worksheet sheet;
  TabController tabController;
  ScrollController scrollViewController;
  final aggMeals = <List<Meal>>[];

  final List<String> daysOfTheWeek = [
    'Segunda-feira',
    'Terça-feira',
    'Quarta-feira',
    'Quinta-feira',
    'Sexta-feira',
    'Sabado',
    'Domingo'
  ];

  Future readFromSheets() async {
    final gsheets = GSheets(Constants.credentials);
    // fetch spreadsheet by its id
    final ss = await gsheets.spreadsheet(Constants.spreadsheetId);
    // get worksheet by its title

    final sheet = await ss.worksheetByTitle('monday');

    //print("SADSDASKFAS\n\n\n\ ");
    for(int i = 0; i < getCurrDayInt()-1; i++) {
      aggMeals.add([]);
    }
    for(DayOfWeek day in meals.keys) {
      aggMeals.add(meals[day]);
    }
    while(aggMeals.length < 7) {
      aggMeals.add([]);
    }

    await check();

    return sheet;
  }

  Future check() async{
    final gsheets = GSheets(Constants.credentials);
    // fetch spreadsheet by its id
    final ss = await gsheets.spreadsheet(Constants.spreadsheetId);

    final sheet = ss.worksheetByTitle('Sheet2');

    final List<String> sheetRestaurants = await sheet.values.column(1);
    final List<String> sheetFood = await sheet.values.column(2);
    int lines = sheetRestaurants.length;

    for(List daylist in aggMeals){
      for(Meal meal in daylist){
        bool isPresent = false;
        for(int i = 0; i < sheetFood.length; i++){
          if(meal.name == sheetFood[i] && restaurantName == sheetRestaurants[i]){
            isPresent = true;
            meal.rating = double.parse(await sheet.values.value(column: 4, row: i + 1)) ;
            meal.numberOfReviews = (await sheet.values.row(i+1)).length - 4;
            break;
          }
        }
        if(!isPresent){
          lines = lines + 1;
          meal.rating = 0;
          sheet.values.insertRow( lines, [restaurantName, meal.name,meal.type,0] );
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: daysOfTheWeek.length);
    final offset = (weekDay > 5) ? 0 : (weekDay - 1) % daysOfTheWeek.length;
    tabController.animateTo((tabController.index + offset));

  }

  @override
  void dispose() {
    tabController.dispose();
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

  @override
  Widget getBody(BuildContext context) {
    if (sheet == null) {
      readFromSheets().then((sheet) {
        setState(() {
          this.sheet = sheet;
        });
      });
      return LoadingScreen();
    } else {
      return FoodFeupEstablishmentPageView(
          tabController: tabController,
          scrollViewController: scrollViewController,
          daysOfTheWeek: daysOfTheWeek,
          aggMeals: aggMeals
      );
    }
  }
}
