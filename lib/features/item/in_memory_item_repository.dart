import 'dart:async';

import 'item.dart';
import 'item_repository.dart';

class InMemoryItemRepository implements ItemRepository {
  final List<Item> _items = [];

  @override
  Future<List<Item>> fetchAll() async {
    // 将来APIを叩くことを想定して、あえてFutureにしておく
    return _items;
  }

  @override
  Future<void> add(Item item) async {
    _items.add(item);
  }
}
