import 'package:tuple/tuple.dart';
import 'package:uni/model/app_state.dart';
import 'package:uni/model/entities/lecture.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:uni/model/entities/meal.dart';
import 'package:uni/model/utils/day_of_week.dart';
import 'package:gsheets/gsheets.dart';
import 'package:uni/view/Pages/secondary_page_view.dart';

import '../view/Pages/foodfeup_establishment_view.dart';
import '../../utils/constants.dart' as Constants;

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
    final sheet = await ss.worksheetByTitle('Sheet1');

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

    /*
    for (int i = 0; i < daysOfTheWeek.length; i++) {
      List<Meal> meals = [];
      for(int j= 1; j < 6; j++){
        List<String> line = await sheet.values.row(j);
        //print(line);
        meals.add(Meal(line[0], line[1], DayOfWeek.monday, DateTime.now()));
      }
      aggMeals.add(meals);
    }
    */
    for(int i = 0; i < aggMeals.length; i++) {
      for(Meal m in aggMeals[i]){
        print(m.name + " " + m.type + " " + m.dayOfWeek.toString() + " " + m.date.toString());
      }
      print("-------");
    }
    return sheet;
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
