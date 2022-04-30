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
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Food Feup"),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
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

  widgets.add(createLogo(context));
  widgets.add(Padding(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16)));
  widgets.add(createButton(context, 'Cantina', decoy));
  widgets.add(Padding(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16)));
  widgets.add(createButton(context, 'Restaurante', decoy));

  return widgets;
}

Widget createLogo(BuildContext context) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
    child: Center(
      child: SizedBox(
        width: 100,
        height: 100,
        child: Image.asset('Images/logo.png'),
      ),
    ),
  );
}

Widget createButton(BuildContext context, String buttonName, Function action) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
    child: SizedBox(
      height: 50,
      width: 250,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          primary: Colors.red,
        ),
        onPressed: action,

        child: Text(buttonName,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 20),
            textAlign: TextAlign.center),
      ),
    ),
  );
}