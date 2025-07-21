import 'package:flutter/material.dart';

class sharedData extends ChangeNotifier {
  var activeUser = {};
  String activeBookID = '';
  void setActiveUser(user){
    activeUser = user;
    notifyListeners();
  }
  void setActiveBookID(id){
    activeBookID = id;
    notifyListeners();
  }
}