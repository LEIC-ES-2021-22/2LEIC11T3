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
  const FoodFeupEstablishmentPage({Key key}) : super(key: key);

  @override
  _FoodFeupEstablishmentPageState createState() => _FoodFeupEstablishmentPageState();
}

class _FoodFeupEstablishmentPageState extends SecondaryPageViewState
    with SingleTickerProviderStateMixin {
  final int weekDay = DateTime.now().weekday;

  TabController tabController;
  ScrollController scrollViewController;

  final List<String> daysOfTheWeek = [
    'Segunda-feira',
    'Terça-feira',
    'Quarta-feira',
    'Quinta-feira',
    'Sexta-feira',
    'Sabado',
    'Domingo'
  ];

  Future<Worksheet> readFromSheets() async {
    // init GSheets
    final gsheets = GSheets(Constants.credentials);
    // fetch spreadsheet by its id
    final ss = await gsheets.spreadsheet(Constants.spreadsheetId);
    // get worksheet by its title
    final sheet = await ss.worksheetByTitle('Sheet1');

    print("SADSDASKFAS\n\n\n\ ");
    print(await sheet.values.row(2));
    print("SADSDASKFAS\n\n\n\ ");

    return sheet;
  }


  List<List<Meal>> _groupMealsByDay()  {
    final aggMeals = <List<Meal>>[];
    Worksheet sheet;
    Future<Worksheet> future = Future.delayed(
        Duration(seconds: 2),
        () => readFromSheets()
    );

    
    future.then((value) => sheet);
    //print(sheet.values.row(2));

    for (int i = 0; i < daysOfTheWeek.length; i++) {
      final List<Meal> meals = List.filled(2,Meal("Carne", "teste", DayOfWeek.monday, DateTime.now()));
        //final List<Meal> meals = List.filled(2, null);
        //meals[0] = Meal(sheet.toString());
        //for (int j = 0; j < 2; j++) {
        //if (schedule[j].day == i) Meals.add(schedule[j]);

      //}
      aggMeals.add(meals);
    }
    return aggMeals;
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

  @override
  Widget getBody(BuildContext context) {
    return StoreConnector<AppState, Tuple2<List<Lecture>, RequestStatus>>(
      converter: (store) => Tuple2(store.state.content['schedule'],
          store.state.content['scheduleStatus']),
      builder: (context, lectureData) {
        return FoodFeupEstablishmentPageView(
            tabController: tabController,
            scrollViewController: scrollViewController,
            daysOfTheWeek: daysOfTheWeek,
            aggMeals: _groupMealsByDay()
        );
      },
    );
  }
}
