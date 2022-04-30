import 'package:flutter/material.dart';

class FoodFeupMainMenu extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return FoodFeupMainMenuState();
  }
}

class FoodFeupMainMenuState extends State<FoodFeupMainMenu>{

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: ListView(
            children: getWidgets(context),
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

bool decoy() {
    print('sucessful');
    return true;
}

List<Widget> getWidgets(BuildContext context) {
  final List<Widget> widgets = [];
  widgets.add(Padding(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0)));
  widgets.add(createButton(context, 'Cantina', '11h30-14h00 / 18h30-20h30', Colors.red , decoy));
  widgets.add(Padding(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0)));
  widgets.add(createButton(context, 'Grill', '12h00-14h00', Colors.red , decoy));
  widgets.add(Padding(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0)));
  widgets.add(createButton(context, 'Cafetaria', '8h30-17h30', Colors.red , decoy));
  widgets.add(Padding(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0)));
  widgets.add(createButton(context, 'Restaurante INEGI', '', Colors.red , decoy));
  widgets.add(Padding(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0)));
  widgets.add(createButton(context, 'Bar INESC TEC', '', Colors.red , decoy));
  widgets.add(Padding(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0)));
  widgets.add(createButton(context, 'Recomendação', 'Hoje', Colors.grey , decoy));

  return widgets;
}

Widget createButton(BuildContext context, String buttonName, String timeTable, Color colour, Function action) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
    child: SizedBox(
      height: 75,
      width: 250,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          primary: colour,
        ),
        onPressed: action,

        child: ListView(
            children: generateButtonText(context, buttonName, timeTable),
          ),
        )
      ),
  );
}

List<Widget> generateButtonText(BuildContext context, String buttonName, String timeTable) {
  final List<Widget> widgets = [];
  widgets.add(Padding(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 7)));
  widgets.add(Text(buttonName,
      style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400,
          fontSize: 20),
      textAlign: TextAlign.center));
  widgets.add(Text(timeTable,
      style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400,
          fontSize: 14),
      textAlign: TextAlign.center));

  return widgets;
}