import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uni/view/Pages/secondary_page_view.dart';

import 'package:uni/view/Widgets/foodfeup_suggestion_selection.dart';


class FoodFeupSuggestionSelectionView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FoodFeupSuggestionSelectionViewState();
}

class FoodFeupSuggestionSelectionViewState extends SecondaryPageViewState {

  @override
  Widget getBody(BuildContext context) {
    return  Container(
        margin:  EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
        child:  FoodFeupSuggestionSelection()
    );
  }
}