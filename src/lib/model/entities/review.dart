import 'package:intl/intl.dart';
import 'package:uni/model/utils/day_of_week.dart';
import 'package:uni/model/entities/meal.dart';

class Review{
  double stars;
  Meal meal;
  int rest_id;
  String username;
  DateTime date;
  String comment;

  Review(double st, String un, DateTime d, Meal m, int rid){
    this.stars = st;
    this.username = un;
    this.date = d;
    this.meal = m;
    this.rest_id = rid;
    this.comment = "";
  }



  void addComment(String c)
  {
    this.comment = c;
  }

  void printReview()
  {
    print("Stars: $stars , Username: $username , Comment: $comment ");

  }

  @override
  String toString() {
    // TODO: implement toString

    if (comment != "")
      {
        return stars.toString() + "&" + username + "&" + comment;
      }
    else
      {
        return stars.toString() + "&" + username;
      }

  }
}

