import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uni/view/Widgets/row_container.dart';

class MealSlot extends StatelessWidget{
  final String type;
  final String name;
  final int rating;
  final int ratingQuantity;

  MealSlot({
    Key key,
    @required this.type,
    @required this.name,
    this.rating,
    this.ratingQuantity,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return RowContainer(
        child: Container(
          padding:
          EdgeInsets.only(top: 10.0, bottom: 10.0, left: 22.0, right: 22.0),
          child: createMealSlotRow(context),
        ));
  }

  Widget createMealSlotRow(context) {
    return  Container(
        key: Key('schedule-slot-time-${this.name}'),
        margin: EdgeInsets.only(top: 3.0, bottom: 3.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: createMealSlotPrimInfo(context),
        ));
  }

  List<Widget> createMealSlotPrimInfo(context){
    final mealTypeTextField = createTextField(
      "Carne",
      Theme.of(context).textTheme.headline3.apply(fontSizeDelta: 5),
      TextAlign.center);
    final mealNameTextField = createTextField(
        "Espetade de aves no forno com batata frita e alface",//this.name,//TODO: fix overlow for long text
        Theme.of(context).textTheme.headline4.apply(fontSizeDelta: -4),
        TextAlign.center);
    final ratingValueTextField = createTextField(
        "5",
        Theme.of(context).textTheme.headline4.apply(fontSizeDelta: -4),
        TextAlign.center);
    final ratingQuantityTextField = createTextField(
        "(20)",
        Theme.of(context).textTheme.headline4.apply(fontSizeDelta: -4),
        TextAlign.center);


    return [
      Column(
        children:<Widget>[
          Row(
          children: <Widget>[
          mealTypeTextField,
            ],
          ),
          Row(
            children: <Widget>[
              ratingValueTextField,
              ratingQuantityTextField,
            ],
          )
      ]
      ),
      mealNameTextField,
      mealNameTextField
    ];
  }

  Widget createTextField(text, style, alignment) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: style,
    );
  }

}