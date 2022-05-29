import 'package:intl/intl.dart';
import 'package:uni/model/utils/day_of_week.dart';
import 'package:uni/model/entities/meal.dart';

class Review{
  double stars;
  String meal;
  String rest_name;
  String username;
  String comment;

  Review(double st, String un, String m, String rn){
    this.stars = st;
    this.username = un;
    this.meal = m;
    this.rest_name = rn;
    this.comment = "";
    print("contrutor");
  }




  void addComment(String c)
  {
    this.comment = c;
  }

    @override

  String toString()
  {
    return ("$stars&$username&$comment");

  }
}

