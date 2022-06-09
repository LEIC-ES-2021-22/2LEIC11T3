import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uni/view/Pages/secondary_page_view.dart';
import 'package:uni/view/Widgets/bug_report_form.dart';

import '../Widgets/foodfeup_main_menu.dart';
import '../Widgets/foodfeup_ratingUI.dart';
import '../Widgets/foodfeup_ratingUI1.dart';


class FoodFeupRatingView extends StatefulWidget {
  final String restaurant, mealname;
  FoodFeupRatingView({Key key, @required this.restaurant, @required this.mealname });
  @override
  State<StatefulWidget> createState() => FoodFeupRatingViewState(restaurant, mealname);
}

class FoodFeupRatingViewState extends SecondaryPageViewState {
  String restaurant, mealname;
  FoodFeupRatingViewState(@required this.restaurant, @required this.mealname );

  @override
  Widget getBody(BuildContext context) {
    return  Container(
        margin:  EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
        child:  FoodFeupRating1(restaurant: restaurant, mealname: mealname)
    );
  }
}