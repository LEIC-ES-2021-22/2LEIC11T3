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
    final sheet0 = await ss.worksheetByTitle('Segunda');
    final sheet1 = await ss.worksheetByTitle('Terça');
    final sheet2 = await ss.worksheetByTitle('Quarta');
    final sheet3 = await ss.worksheetByTitle('Quinta');
    final sheet4 = await ss.worksheetByTitle('Sexta');
    final sheet5 = await ss.worksheetByTitle('Sábado');
    final sheet6 = await ss.worksheetByTitle('Domingo');
    List<Worksheet> week;
    week.add(sheet0);
    week.add(sheet1);
    week.add(sheet2);
    week.add(sheet3);
    week.add(sheet4);
    week.add(sheet5);
    week.add(sheet6);

    print("SADSDASKFAS\n\n\n\ ");

    for (int i = 0; i < daysOfTheWeek.length; i++) {
      List<Meal> meals = [];
      for(int j= 1; j < 6; j++){
        List<String> line = await week[i].values.row(j);
        print(line);
        meals.add(Meal(line[0], line[1], DayOfWeek.monday, DateTime.now()));
        int row = 4;
        while (row < line.length && line[row].isNotEmpty)
          {
            print("Im inside the loop");
            int stars;
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
                        stars = int.parse(text);
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

            switch(part){
              case 1:
                usname = text;
                break;
              case 2:
                com = text;
                break;
              default:
                break;
            }



            Review rev = Review(stars, usname, DateTime.now(), meals[j-1], 1);
            if (com != "")
              {
                rev.addComment(com);
              }
            rev.printReview();

            meals[j-1].reviews.add(rev);  //RESTAURANT HARDCODED SEE THIS LATER

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
