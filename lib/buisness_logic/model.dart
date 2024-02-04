/*
Parent: 
This is a newly introduced class that will contain a list of categories and addToCategoryList() method. It will also contain an instance of DEVLogs. There will only be one instance of the parent class. It will provide all the state to the entire application form the main function. The .toString method should also be overloaded for this class to observe the number of items in the list of categories. Following tables show all the hierarchy of the classes and methods and data members inside each class.
Parent:
List<Category> categoryList;
addToCategoryList(); //with notifyListeners();
.toString //overloaded

Category:
Bool isCountBased;
String name;
String ActivityConnectUID;
DateTime createdOn;
List<Activities> activityList;
addToActivityList(); //with notifyListeners();
.toString //overloaded

Activity:
String name;
DateTime createdOn;
List<String> tags;
DateTime lastUpdated;
Map<DateTime, Value> countMap;
addToCountMap(); //with notifyListeners();
.toString //overloaded

DEVLogs:
List<Project> projectList;
addToProjectList(); //with notifyListeners();
.toString //overloaded

Project:
String name;
DateTime createdOn;
Future<bool> uploadToFirestore(); 
List<ProjectRecord> projectRecordList;
addToProjectRecordList(); //with notifyListeners();

ProjectRecord:
List<Image> images;
DateTime createdOn;
String description;
.toString //overloaded

Migration to Riverpod
We will use the same model classes designs that we have used but now we will use only one instance of the parent used as a provider for maintaining the overall state of the app rather than creating multiple instances of the model classes. We will use the notifyListeners in the methods that cause changes to the UI. We will extend all the classes from the ChangeNotifier. Along with this, we will use the Consumer Stateful Widget in the UI so that we could reuse most of the existing code defined in the existing stateful widgets. 


 */

//Parent:

import 'package:flutter/material.dart';

class Parent extends ChangeNotifier {
  List<Category> categoryList = [];

  void addToCategoryList(Category category) {
    categoryList.add(category);
    notifyListeners();
  }

  @override
  String toString() {
    return 'Parent: ${categoryList.length}';
  }
}

//Category:

class Category extends ChangeNotifier {
  bool isCountBased;
  String name;
  String ActivityConnectUID;
  DateTime createdOn;
  List<Activity> activityList = [];

  Category({
    required this.isCountBased,
    required this.name,
    required this.ActivityConnectUID,
    required this.createdOn,
  });

  void addToActivityList(Activity activity) {
    activityList.add(activity);
    notifyListeners();
  }

  @override
  String toString() {
    return 'Category: ${activityList.length}';
  }
}

class Activity extends ChangeNotifier {
  String name;
  DateTime createdOn;
  List<String> tags = [];
  DateTime lastUpdated;
  Map<DateTime, int> countMap = {};

  Activity({
    required this.name,
    required this.createdOn,
    required this.tags,
    required this.lastUpdated,
  });

  void addToCountMap(DateTime dateTime, int value) {
    countMap[dateTime] = value;
    notifyListeners();
  }

  @override
  String toString() {
    return 'Activity: ${countMap.length}';
  }
}
