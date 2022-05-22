

import 'package:flutter/material.dart';
import 'package:uni/view/Widgets/page_title.dart';

class FoodFeupSuggestionPageView extends StatelessWidget {
  FoodFeupSuggestionPageView({
    Key key,
    @required this.options,
    this.mealType,
    this.mealRating,
    this.mealRatingQuant,
    this.mealName,
    this.establishment
    });

  final List<String> options;
  String dropdownValue;
  String mealType;
  int mealRating;
  String mealRatingQuant;
  String mealName;
  String establishment;

  @override
  Widget build(BuildContext context){
    dropdownValue = options[0];//TODO: read these from somewhere
    establishment = "Cantina almoço";
    mealType = "Vegetariano";
    mealRating = 4;
    mealRatingQuant = "23";
    mealName = "Jardineira de soja (batata,ervilhas e cenoura)";



    return (SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Padding(padding: EdgeInsets.symmetric(horizontal: 0, vertical: 15)),
          createDropdownButton(Theme.of(context).accentColor),
          Padding(padding: EdgeInsets.symmetric(horizontal: 0, vertical: 15)),
          Text(establishment,
              style: TextStyle(fontWeight: FontWeight.w400,fontSize: 30),),
          Padding(padding: EdgeInsets.symmetric(horizontal: 0, vertical: 15)),
          Text(mealType,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 30,
              color:Theme.of(context).accentColor ),),
          Padding(padding: EdgeInsets.symmetric(horizontal: 0, vertical: 3)),
          Row( children: [
            Text("Stars go here"),
            Text("(" + mealRatingQuant + ")",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,
                color:Theme.of(context).accentColor ))
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          Padding(padding: EdgeInsets.symmetric(horizontal: 0, vertical: 15)),
          Divider(thickness: 3,indent: 20,endIndent: 20,color: Theme.of(context).accentColor),
          Padding(padding: EdgeInsets.symmetric(horizontal: 0, vertical: 15)),
          Text(mealName,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18,
              color:Colors.black , ), textAlign: TextAlign.center,overflow: TextOverflow.fade),
          Padding(padding: EdgeInsets.symmetric(horizontal: 0, vertical: 40)),
          createReviewButton(Theme.of(context).accentColor)]
        ,)
      ));
    }

    Widget createDropdownButton(Color color){
      return DropdownButton<String>(
        value: dropdownValue,
        icon: const Icon(Icons.arrow_downward),
        style: const TextStyle(color: Colors.black),
        borderRadius: BorderRadius.circular(1),
        underline: Container(
          height: 2,
          color: color,
        ),
        onChanged: (String newValue){//TODO:Make this update the page content
          dropdownValue = newValue;
        },
        items: options.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      );
    }

  Widget createReviewButton(Color color){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: SizedBox(
          height: 55,
          width: 55,
          child: ElevatedButton(
            child: Center(
              child: Icon(Icons.star,color: Colors.white,size: 35,),
            ),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(55),
              ),
              primary: color,
            ),
            onPressed: decoy,//TODO change to real function

          )
      ),
    );
  }

  bool decoy(){
    return false;
  }

  }