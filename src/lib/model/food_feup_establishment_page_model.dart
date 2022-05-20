import 'package:flutter/material.dart';
import 'package:uni/model/entities/meal.dart';
import 'package:uni/model/utils/day_of_week.dart';
import 'package:gsheets/gsheets.dart';
import 'package:uni/view/Pages/secondary_page_view.dart';
import 'package:uni/view/Pages/foodfeup_establishment_view.dart';
import 'package:uni/utils/constants.dart' as Constants;

import 'entities/review.dart';

class FoodFeupEstablishmentPage extends StatefulWidget {
  const FoodFeupEstablishmentPage({Key key}) : super(key: key);

  @override
  _FoodFeupEstablishmentPageState createState() => _FoodFeupEstablishmentPageState();
}

class _FoodFeupEstablishmentPageState extends SecondaryPageViewState
    with SingleTickerProviderStateMixin {
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

    print("SADSDASKFAS\n\n\n\ ");

    for (int i = 0; i < daysOfTheWeek.length; i++) {
      List<Meal> meals = [];
      for(int j= 1; j < 6; j++){
        List<String> line = await sheet.values.row(j);
        print(line);
        meals.add(Meal(line[0], line[1], DayOfWeek.monday, DateTime.now()));
        int row = 4;
        while (line[row].isNotEmpty)
          {
            print("Im inside the loop");
            int str;
            String usname;
            String com;
            int part = 0;
            String text = "";
            for (int k = 0; k < line[row].length; k++){
              print("For number: $k");
                if (part == 3)
                  break;

                if (line[row][k] == "&")
                  {
                    switch(part){
                      case 0:
                        str = int.parse(text);
                        text = "";
                        break;
                      case 1:
                        usname = text;
                        text = "";
                        break;
                      case 2:
                        com = text;
                        text = "";
                        break;
                      default:
                        break;
                    }

                    part++;

                  }
                else{
                  text += line[row][k];
                }
              }

            Review rev = Review(str, usname, DateTime.now(), meals[j], 1);
            if (com != "")
              {
                rev.addComment(com);
              }
            rev.printReview();

            meals[j].reviews.add(rev);  //RESTAURANT HARDCODED SEE THIS LATER

            row++;

          }



      }
      aggMeals.add(meals);
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
