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

    /*
    for (int i = 0; i < daysOfTheWeek.length; i++) {
      List<Meal> meals = [];
      for(int j= 1; j < 6; j++){
        List<String> line = await sheet.values.row(j);
        //print(line);
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
    */
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
