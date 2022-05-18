
import 'package:flutter/material.dart';
import 'package:uni/view/Widgets/page_title.dart';
import 'package:uni/view/Widgets/request_dependent_widget_builder.dart';

import '../../model/entities/meal.dart';
import '../Widgets/meal_slot.dart';

class FoodFeupEstablishmentPageView extends StatelessWidget {
  FoodFeupEstablishmentPageView(
      {Key key,
        @required this.tabController,
        @required this.daysOfTheWeek,
        @required this.aggMeals,
        this.scrollViewController});

  final List<String> daysOfTheWeek;
  final List<List<Meal>> aggMeals;
  final TabController tabController;
  final ScrollController scrollViewController;

  @override
  Widget build(BuildContext context) {
    final MediaQueryData queryData = MediaQuery.of(context);

    return Column(children: <Widget>[
      ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: <Widget>[
          PageTitle(key: Key("establishment_menu"),name: 'Comida'),
          TabBar(
            controller: tabController,
            isScrollable: true,
            tabs: createTabs(queryData, context),
          ),
        ],
      ),
      Expanded(
          child: TabBarView(
            controller: tabController,
            children: createMealList(context),
          ))
    ]);
  }

  /// Returns a list of widgets empty with tabs for each day of the week.
  List<Widget> createTabs(queryData, BuildContext context) {
    final List<Widget> tabs = <Widget>[];
    for (var i = 0; i < daysOfTheWeek.length; i++) {
      tabs.add(Container(
        color: Theme.of(context).backgroundColor,
        width: queryData.size.width * 1 / 3,
        child: Tab(key: Key('establishment-page-tab-$i'), text: daysOfTheWeek[i]),
      ));
    }
    return tabs;
  }

  List<Widget> createMealList(context) {
    final List<Widget> tabBarViewContent = <Widget>[];
    for (int i = 0; i < daysOfTheWeek.length; i++) {
      tabBarViewContent.add(createMealListByDay(context, i));
    }
    return tabBarViewContent;
  }

  /// Returns a list of widgets for the rows with a singular class info.
  List<Widget> createMealRows(meals, BuildContext context) {
    final List<Widget> mealContent = <Widget>[];
    for (int i = 0; i < meals.length; i++) {
      final Meal meal = meals[i];
      mealContent.add(MealSlot(
        type: meal.type,
        name: meal.name,
        rating: 0,
        ratingQuantity: 0,
      ));
    }
    return mealContent;
  }

  Widget Function(dynamic daycontent, BuildContext context) dayColumnBuilder(
      int day) {
    Widget createDayColumn(dayContent, BuildContext context) {
      return Container(
          key: Key('establishment-page-day-column-$day'),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: createMealRows(dayContent, context),
          ));
    }

    return createDayColumn;
  }

  Widget createMealListByDay(BuildContext context, int day) {
    return RequestDependentWidgetBuilder(
      context: context,
      //status: scheduleStatus,
      contentGenerator: dayColumnBuilder(day),
      content: aggMeals[day],
      contentChecker: aggMeals[day].isNotEmpty,
      onNullContent:
      Center(child: Text('Não possui aulas à ' + daysOfTheWeek[day] + '.')),
      index: day,
    );
  }
}