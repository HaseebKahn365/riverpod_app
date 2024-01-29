/*

this application simply tests for different categories of activites and the activitiies that reside in each category.
but with riverpod in mind, we will be extending our classes from the ChangeNotifier class and then we will be using the notify listeners to notify the listeners of any changes in the state of the application.

Following is the structure of the classes.

class Category {
  bool isCountBased;
  String name;
  String ActivityConnectUID;
  DateTime createdOn;

  List<Activity> activityList;

  Category({required this.isCountBased, required this.name, required this.ActivityConnectUID, required this.createdOn, required this.activityList});

  void addToActivityList(Activity activity) {
    activityList.add(activity);
  }
}

class Activity {
  String name;
  List<String> tags;
  DateTime createdOn;
  Map<DateTime, int> countMap;

  Activity({required this.name, required this.tags, required this.createdOn, required this.countMap});
}
lets implement along with the ChangeNotifier class.

 */

import 'package:flutter/material.dart';

class Category extends ChangeNotifier {
  final bool isCountBased;
  final String name;
  String ActivityConnectUID;
  final DateTime createdOn;

  List<Activity> activityList;

  Category({required this.isCountBased, required this.name, required this.ActivityConnectUID, required this.createdOn, required this.activityList});

  void addToActivityList(Activity activity) {
    activityList.add(activity);
    notifyListeners();
  }
}

class Activity extends ChangeNotifier {
  String name;
  List<String> tags;
  DateTime createdOn;
  Map<DateTime, int> countMap;
  final List<String> notes = [];

  Activity({required this.name, required this.tags, required this.createdOn, required this.countMap});

  void addToCountMap(DateTime date, int count) {
    countMap[date] = count;
    notifyListeners();
  }

  void addNotes(String note) {
    notes.add(note);
    notifyListeners();
  }
}
