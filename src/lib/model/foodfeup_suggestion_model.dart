import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../view/Pages/foodfeup_suggestion_view.dart';
import '../view/Pages/secondary_page_view.dart';

class FoodFeupSuggestionPage extends StatefulWidget {
  const FoodFeupSuggestionPage({Key key}) : super(key: key);

  @override
  _FoodFeupSuggestionPageState createState() => _FoodFeupSuggestionPageState();
}

class _FoodFeupSuggestionPageState extends SecondaryPageViewState {
  final int weekDay = DateTime
      .now()
      .weekday;


  final List<String> options = [//TODO: why is this here?
    'indiferente',
    'Carne',
    'Peixe',
    'Vegetariano',
    'Dieta',
    'Sopa',
  ];

  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget LoadingScreen() {

    return Center(
        child: SizedBox(
          width: 60,
          height: 60,
          child: CircularProgressIndicator(),
        )
    );
  }


  @override
  Widget getBody(BuildContext context) {
      return FoodFeupSuggestion();
  }
}