import 'package:flutter/material.dart';

class ProductAdd extends ChangeNotifier {
  final Map<int, int> _totals = {};

  int getTotalCount() {
    return _totals.values.fold(0, (a, b) => a + b);
  }

  int getTotalForProduct(int productId) {
    return _totals[productId] ?? 0;
  }

  void incrementTotal(int productId) {
    _totals[productId] = (_totals[productId] ?? 0) + 1;
    notifyListeners();
  }

  void decrementTotal(int productId) {
    if (_totals.containsKey(productId) && _totals[productId]! > 0) {
      _totals[productId] = _totals[productId]! - 1;
      if (_totals[productId] == 0) {
        _totals.remove(productId);
      }
      notifyListeners();
    }
  }

  void clearTotals() {
    _totals.clear();
    notifyListeners();
  }
}