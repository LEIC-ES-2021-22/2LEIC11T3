

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
        children: [createDropdownButton(),
        PageTitle(name: establishment),
        Text(mealType),
        Row( children: [
          Text("Stars go here"),
          Text("(" + mealRatingQuant + ")")
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
        Text(mealName),
        createReviewButton()]
        ,)
      ));
    }

    Widget createDropdownButton(){
      return DropdownButton<String>(
        value: dropdownValue,
        icon: const Icon(Icons.arrow_downward),
        elevation: 16,
        style: const TextStyle(color: Colors.red),
        underline: Container(
          height: 2,
          color: Colors.redAccent,
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

  Widget createReviewButton(){
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
              primary: Colors.red,
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