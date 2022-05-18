import 'package:flutter/material.dart';

class FoodFeupRating extends StatefulWidget{
  const FoodFeupRating({Key key}) : super(key: key);

  @override
  FoodFeupRatingState createState() => FoodFeupRatingState();
}

class FoodFeupRatingState extends State<FoodFeupRating>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: getWidgets(context),
        ),
      )
    );
  }
}

bool decoy() {
  return false;
}

List<Widget> getWidgets(BuildContext context) {
  final List<Widget> widgets = [];

  widgets.add(Padding(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0)));
  widgets.add(createButton(context, 'Recomendação', 'Hoje', Colors.grey , decoy));

  return widgets;
}

Widget createButton(BuildContext context, String buttonName, String timeTable, Color colour, Function action) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
    child: SizedBox(
        height: 70,
        width: 300,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            primary: colour,
          ),
          onPressed: ()=> action(context, buttonName),

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