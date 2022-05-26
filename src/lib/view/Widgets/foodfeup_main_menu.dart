import 'package:flutter/material.dart';
import 'package:uni/controller/restaurant_fetcher/restaurant_fetcher_html.dart';
import 'package:uni/model/food_feup_establishment_page_model.dart';
import 'package:uni/model/foodfeup_suggestion_model.dart';
import 'package:uni/main.dart';

class FoodFeupMainMenu extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return FoodFeupMainMenuState();
  }
}

class FoodFeupMainMenuState extends State<FoodFeupMainMenu>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: FutureBuilder<List<Widget>>(
            future: getWidgets(context),
            builder: (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
              List<Widget> children;
              if (snapshot.hasData) {
                children = snapshot.data;
              } else if (snapshot.hasError) {
                children = <Widget>[
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('Error: ${snapshot.error}'),
                  )
                ];
              } else {
                children = const <Widget>[
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text('Awaiting result...'),
                  )
                ];
              }
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: children,
                ),
              );
            },
          ),
        ),


      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

bool transitionToEstablishment(BuildContext context, String buttonName, Map meals) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => FoodFeupEstablishmentPage(restaurantName: buttonName, meals: meals)));

  return true;
}

bool transitionToSuggestion(BuildContext context, String buttonName, Map unused) {
  Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FoodFeupSuggestionPage()));

  return true;
}

Future<List<Widget>> getWidgets(BuildContext context) async {
  final List<Widget> widgets = [];
  await RestaurantFetcherHtml().getRestaurants(state).then((restaurants) {
    for(var rest in restaurants) {
        widgets.add(Padding(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0)));
        widgets.add(createButton(context, rest.name, rest.timetable, Colors.red, rest.meals, transitionToEstablishment));
      }
    }
  );

  widgets.add(Padding(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0)));
  widgets.add(createButton(context, 'Recomendação', 'Hoje', Colors.grey , {},transitionToSuggestion));

  return widgets;
}

Widget createButton(BuildContext context, String buttonName, String timeTable,
    Color colour, Map meals, Function action) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
    child: SizedBox(
      height: 70,
      width: 300,
      child: ElevatedButton(
        key: Key("establishment_button_$buttonName"),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          primary: colour,
        ),
        onPressed: ()=> action(context, buttonName, meals),

        child: ListView(
            children: generateButtonText(context, buttonName, timeTable),
          ),
        )
      ),
  );
}

List<Widget> generateButtonText(BuildContext context, String buttonName, String timeTable) {
  final List<Widget> widgets = [];
  if(timeTable == '') {
    widgets.add(Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 0)));
  } else {
    widgets.add(Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)));
  }

  widgets.add(
    Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Text(buttonName,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 20,
                overflow: TextOverflow.ellipsis
            ),
            textAlign: TextAlign.center),
      ),
    ),
  );
  widgets.add(Text(timeTable,
      style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400,
          fontSize: 16),
      textAlign: TextAlign.center));

  return widgets;
}