import 'package:flutter/material.dart';
import 'package:news_route/apis/api_manager.dart';
import 'package:news_route/models/source_response/source.dart';

class CategoryDetailsViewmodel extends ChangeNotifier {
  //hold data
  List<Source>? sourceList;
  String? errorMessage;
  int selectedIndex = 0;

  //handle logic

  void changeIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  void getSource(String categoryId) async {
    sourceList = null;
    errorMessage = null;
    notifyListeners();
    try {
      var response = await ApiManager.getSources(categoryId);
      if (response?.status == 'error') {
        errorMessage = response!.message;
      } else {
        sourceList = response!.sources;
      }
    } catch (e) {
      errorMessage = 'error has occured';
    }

    notifyListeners();
  }
}
