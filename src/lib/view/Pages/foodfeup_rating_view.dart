import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uni/view/Pages/secondary_page_view.dart';
import 'package:uni/view/Widgets/foodfeup_ratingUI1.dart';


class FoodFeupRatingView extends StatefulWidget {
  final String restaurant, mealname;
  final List<List<String>> comments;
  FoodFeupRatingView({Key key, @required this.restaurant, @required this.mealname, @required this.comments});
  @override
  State<StatefulWidget> createState() => FoodFeupRatingViewState(restaurant:this.restaurant,
      mealname: this.mealname, comments: this.comments);
}

class FoodFeupRatingViewState extends SecondaryPageViewState {
  String restaurant, mealname;
  final List<List<String>> comments;
  FoodFeupRatingViewState({@required this.restaurant, @required this.mealname, @required this.comments} );

  @override
  Widget getBody(BuildContext context) {
    return  Container(
        margin:  EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
        child:  FoodFeupRating1(restaurant: restaurant, mealname: mealname, comms: this.comments)
    );
  }
}