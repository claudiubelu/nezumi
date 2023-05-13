import 'package:flutter/material.dart';

class Event_card {
  int Index;
  String Title;
  String Description;
  DateTime date;

  Event_card(this.Index, this.Title, this.Description, this.date);
}

int timestamp = DateTime.now().millisecondsSinceEpoch;

List<Event_card> Events = [
  Event_card(1, 'Titlu1', 'desc1', DateTime.parse('1969-07-20 20:18:04Z')),
  Event_card(2, 'Titlu2', 'desc1', DateTime.parse('1969-07-20 20:18:04Z')),
  Event_card(3, 'Titlu3', 'desc1', DateTime.parse('1969-07-20 20:18:04Z')),
  Event_card(4, 'Titlu1', 'desc1', DateTime.parse('1969-07-20 20:18:04Z')),
  Event_card(9, 'Titlu1', 'desc1', DateTime.parse('1969-07-20 20:18:04Z')),
  Event_card(5, 'Titlu1', 'desc1', DateTime.parse('1969-07-20 20:18:04Z')),
  Event_card(6, 'Titlu1', 'desc1', DateTime.parse('1969-07-20 20:18:04Z')),
  Event_card(7, 'Titlu1', 'desc1', DateTime.parse('1969-07-20 20:18:04Z')),
  Event_card(8, 'Titlu1', 'desc1', DateTime.parse('1969-07-20 20:18:04Z')),
];