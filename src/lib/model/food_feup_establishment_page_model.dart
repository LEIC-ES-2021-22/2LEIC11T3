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

  //SEE THIS
  /*bool addReview(Review r) async {

    String text = r.toString();

    final gsheets = GSheets(Constants.credentials);
    final ss = gsheets.spreadsheet(Constants.spreadsheetId);
    Worksheet sheet = ss.worksheetByTitle(r.meal.dayOfWeek.name);

    int line;
    switch(r.meal.type)
    {
      case "Carne":
        line = 1;
        break;
      case "Peixe":
        line = 2;
        break;
      case "Sopa":
        line = 3;
        break;
      case "Dieta":
        line = 4;
        break;
      case "Vegetariano":
        line = 5;
        break;
      default:
        break;
    }

   int pos = sheet.columnCount;

    sheet.values.insertValue(text, column: pos, row: line);

  } */
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

    Worksheet sheet;

    for (int i = 0; i < daysOfTheWeek.length; i++) {
      List<Meal> meals = [];
      // get worksheet by its title
      switch(i){
        case 0:
          sheet = await ss.worksheetByTitle('Segunda-feira');
          break;
        case 1:
          sheet = await ss.worksheetByTitle('Terça-feira');
          break;
        case 2:
          sheet = await ss.worksheetByTitle('Quarta-feira');
          break;
        case 3:
          sheet = await ss.worksheetByTitle('Quinta-feira');
          break;
        case 4:
          sheet = await ss.worksheetByTitle('Sexta-feira');
          break;
        case 5:
          sheet = await ss.worksheetByTitle('Sábado');
          break;
        case 6:
          sheet = await ss.worksheetByTitle('Domingo');
          break;
        default:
          break;
      }
      for(int j= 1; j < 6; j++){
        List<String> line = await sheet.values.row(j);
        print(line);
        meals.add(Meal(line[0], line[1], DayOfWeek.monday, DateTime.now()));
        int row = 4;
        while (row < line.length && line[row].isNotEmpty)
        {
          print("Im inside the loop");
          double stars;
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
                  stars = double.parse(text);
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