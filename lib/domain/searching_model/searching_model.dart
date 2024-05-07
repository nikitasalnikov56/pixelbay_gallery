import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/api/pixabay_service.dart';
import 'package:flutter_debouncer/flutter_debouncer.dart';

class SearchingModel extends ChangeNotifier {
  SearchingModel(this._pixabayService);
  
  final PixabayService _pixabayService;
  
  final searchController = TextEditingController();

  void onSearch() {
    Debouncer().debounce(
        duration: const Duration(milliseconds: 300),
        onDebounce: () {
        
          _pixabayService.searchPhotos(searchController.text);
        });
    notifyListeners();
  }
}
