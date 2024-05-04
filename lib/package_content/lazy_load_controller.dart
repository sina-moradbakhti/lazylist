import 'package:flutter/material.dart';

class LazyListController<T> extends ChangeNotifier {
  late List<T> _items;
  late int currentPage;
  bool _loading = false;

  LazyListController({
    required List<T> items,
    this.currentPage = 1,
  }) {
    _items = items;
    notifyListeners();
  }

  bool get loading => _loading;
  List<T> get items => _items;

  addItems(List<T> newItems) {
    _items.addAll(newItems);
    notifyListeners();
  }

  addItem(T newItems) {
    _items.add(newItems);
    notifyListeners();
  }

  clear() {
    _items.clear();
    notifyListeners();
  }

  nextPage() => currentPage++;
  previousPage() => currentPage--;

  startLoading() {
    _loading = true;
    notifyListeners();
  }

  stopLoading() {
    _loading = false;
    notifyListeners();
  }

  refresh() => notifyListeners();
}
