import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:uni/model/foodfeup_suggestion_model.dart';


class FoodFeupSuggestionSelection extends StatefulWidget {

  const FoodFeupSuggestionSelection({Key key}) : super(key: key);

  @override
  FoodFeupSuggestionSelectionState createState() => FoodFeupSuggestionSelectionState();
}

class FoodFeupSuggestionSelectionState extends State<FoodFeupSuggestionSelection> {
  String dropdownValue;
  final List<String> options = ["Indiferente","Carne","Peixe","Vegetariano","Dieta","Sopa"];

  @override
  Widget build(BuildContext context) {
    return Center(
        child:
        Column(
         children: [
           Padding(padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20)),
           Text("Recomendação",
           style: TextStyle(fontWeight: FontWeight.w400,fontSize: 30)),
           Padding(padding: EdgeInsets.symmetric(horizontal: 0, vertical: 15)),
           createDropdownButton(Theme.of(context).accentColor),
    ]
    ));
    throw UnimplementedError();
  }

  Widget createDropdownButton(Color color){
    return DropdownButton<String>(
      key: const Key("dropdown_options"),
      hint: Text("selecione aqui", style: TextStyle(color: Colors.black54)),
      value: null,
      icon: const Icon(Icons.arrow_downward),
      style: const TextStyle(color: Colors.black),
      borderRadius: BorderRadius.circular(1),
      underline: Container(
        height: 2,
        color: color,
      ),
      onChanged: (String newValue){
        setState(() {
          dropdownValue = newValue;
          transitionToSuggestion(context);
        });
      },
      items: options.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  bool transitionToSuggestion(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FoodFeupSuggestionPage(dropdownValue: dropdownValue)));

    return true;
  }
}