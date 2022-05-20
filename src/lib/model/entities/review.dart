import 'package:intl/intl.dart';
import 'package:uni/model/utils/day_of_week.dart';
import 'package:uni/model/entities/meal.dart';

class Review{
  int stars;
  final Meal meal;
  final int rest_id;
  final String username;
  DateTime date;
  String comment;

  Review(this.stars, this.username, this.date, this.meal, this.rest_id);


  void addComment(String c)
  {
    this.comment = c;
  }

  void printReview()
  {
    print("Stars: $stars , Username: $username , Comment: $comment ");

  }
}

