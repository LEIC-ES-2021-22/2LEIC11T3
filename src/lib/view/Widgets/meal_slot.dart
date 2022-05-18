import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uni/view/Pages/foodfeup_rating_view.dart';
import 'package:uni/view/Widgets/foodfeup_ratingUI.dart';
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
        margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: createMealSlotPrimInfo(context),
        ));
  }

  List<Widget> createMealSlotPrimInfo(context){
    final mealTypeTextField = createTextField(
      this.type,
      Theme.of(context).textTheme.headline3.apply(fontSizeDelta: 5),
      TextAlign.center);
    final mealNameTextField = createTextField(
        this.name,
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8)),
                ratingValueTextField,
                ratingQuantityTextField,
              ],
            )
          ]
      ),
      Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8)),
      Expanded(child: mealNameTextField),
      Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8)),
      createReviewButton(context)
    ];
  }

  Widget createTextField(text, style, alignment) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      softWrap: false,
      maxLines: 2,
      textAlign: alignment,
      style: style,
    );
  }

  bool transitionToRatingPage(BuildContext context){
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FoodFeupRatingView()));

    return true;
  }

  Widget createReviewButton(BuildContext context){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: SizedBox(
          height: 30,
          width: 30,
          child: ElevatedButton(
            child: Center(
              child: Icon(Icons.star,color: Colors.white,size: 10,),
            ),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              primary: Colors.red,
            ),
            onPressed: () => transitionToRatingPage(context),


          )
      ),
    );
  }

}