import 'package:flutter/material.dart';

import 'item.dart';
import 'item_repository.dart';
import 'item_edit_page.dart';

class ItemListPage extends StatefulWidget {
  final ItemRepository repository;

  const ItemListPage({
    super.key,
    required this.repository,
  });

  @override
  State<ItemListPage> createState() => _ItemListPageState();
}

class _ItemListPageState extends State<ItemListPage> {
  List<Item> items = [];

  @override
  void initState() {
    super.initState();
    _load(); 
  }

  Future<void> _load() async {
    final result = await widget.repository.fetchAll();
    setState(() {
      items = result;
    });
  }

  Future<void> _goToAddPage() async {
    // 追加画面から title/note を受け取る
    final result = await context.push<ItemEditResult>('/items/new');

    if (result == null) return;

    final newItem = Item(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: result.title,
      note: result.note?.isEmpty == true ? null : result.note,
    );

    await widget.repository.add(newItem);
    await _load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('アイテム一覧'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: items.isEmpty
          ? const Center(
              child: Text(
                'アイテムがありません\n右下のボタンから追加してください',
                textAlign: TextAlign.center,
              ),
            )
          : ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return Card(
                child: ListTile(
                  title: Text(item.title),
                  subtitle: item.note != null && item.note!.isNotEmpty
                    ? Text(
                        item.note!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      )
                    : null,
                ),
              );
            },
          ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _goToAddPage,
        child: const Icon(Icons.add),
      ),
    );
  }
}


