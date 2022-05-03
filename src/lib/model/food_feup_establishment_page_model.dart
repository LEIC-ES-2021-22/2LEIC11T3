import 'package:tuple/tuple.dart';
import 'package:uni/model/app_state.dart';
import 'package:uni/model/entities/lecture.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:uni/model/entities/meal.dart';
import 'package:uni/model/utils/day_of_week.dart';
import 'package:uni/view/Pages/schedule_page_view.dart';
import 'package:uni/view/Pages/secondary_page_view.dart';

import '../view/Pages/foodfeup_establishment_view.dart';

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

  List<List<Meal>> _groupMealsByDay() {
    final aggMeals = <List<Meal>>[];

    for (int i = 0; i < daysOfTheWeek.length; i++) {
      final List<Meal> Meals = <Meal>[];
      Meals[0] = Meal("Carne", "teste", DayOfWeek.monday, DateTime.now());
      Meals[1] = Meal("Peixe", "teste2", DayOfWeek.monday, DateTime.now());
      //for (int j = 0; j < 2; j++) {
        //if (schedule[j].day == i) Meals.add(schedule[j]);

      //}
      aggMeals.add(Meals);
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
