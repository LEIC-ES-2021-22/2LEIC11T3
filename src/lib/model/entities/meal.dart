import 'package:intl/intl.dart';
import 'package:uni/model/entities/review.dart';
import 'package:uni/model/utils/day_of_week.dart';

class Meal{
  final String type;
  final String name;
  final DayOfWeek dayOfWeek;
  final DateTime date;
  double rating;
  int numberOfReviews;

  List<Review> reviews;
  Meal(this.type, this.name, this.dayOfWeek, this.date)
  {
    reviews = [];
  }



  Map<String, dynamic> toMap(restaurantId) {
    final DateFormat format = DateFormat('d-M-y');
    return {
      'id':null,
      'day':toString(this.dayOfWeek),
      'type':this.type,
      'name':this.name,
      'date': this.date != null ? format.format(this.date) : null,
      'id_restaurant':restaurantId};
  }
}