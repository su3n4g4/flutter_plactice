import 'item.dart';

abstract class ItemRepository {
  Future<List<Item>> fetchAll();
  Future<void> getById(String itemId);
  Future<void> add(Item item);
  Future<void> updata(Item item);
}
