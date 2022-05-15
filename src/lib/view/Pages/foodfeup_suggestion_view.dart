

import 'package:flutter/material.dart';

class FoodFeupSuggestionPageView extends StatelessWidget {
  FoodFeupSuggestionPageView({
    Key key,
    @required this.options
    });

  final List<String> options;
  String dropdownValue;

  @override
  Widget build(BuildContext context){
  dropdownValue = options[0];

    return Column(
      children: [
        DropdownButton<String>(
          value: dropdownValue,
          icon: const Icon(Icons.arrow_downward),
          elevation: 16,
          style: const TextStyle(color: Colors.red),
          underline: Container(
            height: 2,
            color: Colors.redAccent,
          ),
          onChanged: (String newValue){
            dropdownValue = newValue;
          },
          items: options.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
            );
          }).toList(),
        )],
      );
    }
  }