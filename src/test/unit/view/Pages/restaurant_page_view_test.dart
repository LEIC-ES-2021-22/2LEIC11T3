import 'package:intl/intl.dart';
import 'package:uni/model/entities/exam.dart';
import 'package:uni/model/entities/meal.dart';
import 'package:uni/model/utils/day_of_week.dart';
import 'package:uni/view/Pages/foodfeup_establishment_view.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:uni/view/Widgets/meal_slot.dart';

import '../../../testable_widget.dart';

void main() {

  group('RestPage', ()
  {
    final List<String> daysOfTheWeek = [
      'Segunda-feira',
      'Terça-feira',
      'Quarta-feira',
      'Quinta-feira',
      'Sexta-feira'
    ];

    final DayOfWeek d = parseDayOfWeek("Segunda-Feira");
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    DateTime dateTime = dateFormat.parse("2019-07-19 8:40:23");

    Meal m1 = Meal("Carne", "Almondegas", d, dateTime);

    Meal m2 = Meal("Carne", "Almondegas", d, dateTime);

    final DayOfWeek d2 = parseDayOfWeek("Terça-Feira");
    DateTime dateTime2 = dateFormat.parse("2019-07-20 8:40:23");

    Meal m3 = Meal("Carne", "Almondegas", d2, dateTime2);

    final DayOfWeek d3 = parseDayOfWeek("Terça-Feira");
    DateTime dateTime3 = dateFormat.parse("2019-07-20 8:40:23");

    Meal m4 = Meal("Carne", "Almondegas", d3, dateTime3);

    testWidgets('When given one meal on a single day',
            (WidgetTester tester) async {
          final List<List<Meal>> aggMeals = [
            [m1],
            [],
            [],
            [],
            []
          ];

          final widget = makeTestableWidget(
              child: DefaultTabController(
                  length: daysOfTheWeek.length,
                  child: FoodFeupEstablishmentPageView(
                    daysOfTheWeek: daysOfTheWeek,
                    aggMeals: aggMeals,
                    tabController: null,
                  )));
          await tester.pumpWidget(widget);

          expect(
              find.descendant(
                  of: find.),
                  matching: find.byType(Container)),
              findsOneWidget);
  });



    testWidgets('When given two meals on a single day',
            (WidgetTester tester) async {
          final List<List<Meal>> aggMeals = [
            [m1, m2],
            [],
            [],
            [],
            []
          ];

          final widget = makeTestableWidget(
              child: DefaultTabController(
                  length: daysOfTheWeek.length,
                  child: FoodFeupEstablishmentPageView(
                    daysOfTheWeek: daysOfTheWeek,
                    aggMeals: aggMeals,
                    tabController: null,
                  )));
          await tester.pumpWidget(widget);

          expect(
              find.descendant(
                  of: find.byKey(Key('schedule-slot-time-Almondegas')),
                  matching: find.byType(MealSlot)),
              findsNWidgets(2));
        });

    testWidgets('When given several meala on sevral days',
            (WidgetTester tester) async {
          final List<List<Meal>> aggMeals = [
            [m1, m2],
            [],
            [m3],
            [m4],
            []
          ];

          final widget = makeTestableWidget(
              child: DefaultTabController(
                  length: daysOfTheWeek.length,
                  child: FoodFeupEstablishmentPageView(
                    daysOfTheWeek: daysOfTheWeek,
                    aggMeals: aggMeals,
                    tabController: null,
                  )));
          await tester.pumpWidget(widget);
        });



});
}