import 'package:flutter/material.dart';
import 'package:gsheets/gsheets.dart';
import 'package:uni/utils/constants.dart' as Constants;

class FoodFeupSuggestion extends StatefulWidget{
  const FoodFeupSuggestion({Key key}) : super(key: key);

  @override
  FoodFeupSuggestionState createState() => FoodFeupSuggestionState();
}

class FoodFeupSuggestionState extends State<FoodFeupSuggestion> {
  FoodFeupSuggestionState({
    Key key,
    //this.options,
    this.mealType = "Vegetariano",
    this.mealRating = 4,
    this.mealRatingQuant = "23",
    this.mealName = "Jardineira de soja (batata,ervilhas e cenoura)",
    this.establishment = "Cantina almoço",
    this.dropdownValue = 'Indiferente'
    });

  final List<String> options = ["Indiferente","Carne","Peixe","Vegetariano","Dieta","Sopa"];
  String dropdownValue;
  String mealType;
  int mealRating;
  String mealRatingQuant;
  String mealName;
  String establishment;

  @override
  Widget build(BuildContext context){
    /*establishment = "Cantina almoço";
    mealType = "Vegetariano";
    mealRating = 4;
    mealRatingQuant = "23";
    mealName = "Jardineira de soja (batata,ervilhas e cenoura)";*/

    return (SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Padding(padding: EdgeInsets.symmetric(horizontal: 0, vertical: 15)),
          Text("Recomendação",
            style: TextStyle(fontWeight: FontWeight.w400,fontSize: 30),),
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
          setState(() {
            //readdatafromgsheets

            dropdownValue = newValue;
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

  Future getHighestInCategory() async{
    final gsheets = GSheets(Constants.credentials);
    // fetch spreadsheet by its id
    final ss = await gsheets.spreadsheet(Constants.spreadsheetId);

    final sheet = ss.worksheetByTitle('Sheet2');

    int highestRating = -1;
    int lineCounter = -1;

    final List<String> ratings = await sheet.values.column(4);
    List<int> sheetRatings = ratings.map(int.parse).toList();//parse list to INT
    //final List<String> sheetFood = await sheet.values.column(2);
    int lines = sheetRatings.length;

    if (dropdownValue == 'Indiferente'){
      for(int i = 0; i < lines; i++){
        if (sheetRatings[i] > highestRating){
          highestRating = sheetRatings[i];
          lineCounter = i + 1;//gsheets is indexed starting from 1
        }
      }
    }else{
      final List<String> sheetRestaurants = await sheet.values.column(1);
      for(int i = 0; i < lines; i++){
        if (sheetRatings[i] > highestRating && sheetRestaurants == dropdownValue){
          highestRating = sheetRatings[i];
          lineCounter = i + 1;
        }
      }
    }

    List<String> bestMeal = await sheet.values.row(lineCounter);

    this.mealType = bestMeal[2];
    this.mealRating = int.parse(bestMeal[3]);
    //this.mealRatingQuant = "23",//TODO i dont have this info in google sheets
    this.mealName = bestMeal[1];
    this.establishment =  bestMeal[0];


    /*for(List daylist in aggMeals){
      for(Meal meal in daylist){
        bool isPresent = false;
        for(int i = 0; i < sheetFood.length; i++){
          if(meal.name == sheetFood[i] && restaurantName == sheetRestaurants[i]){
            isPresent = true;
            meal.rating = double.parse(await sheet.values.value(column: 4, row: i + 1)) ;
            break;
          }
        }
        if(!isPresent){
          lines = lines + 1;
          meal.rating = 0;
          sheet.values.insertRow( lines, [restaurantName, meal.name,meal.type,0] );
        }
      }
    }*/
  }


  }