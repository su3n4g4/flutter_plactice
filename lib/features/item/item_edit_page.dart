import 'package:flutter/material.dart';

/// 追加画面から戻すデータの型
class ItemEditResult {
  final String title;
  final String? note;

  ItemEditResult({
    required this.title,
    this.note,
  });
}

class ItemEditPage extends StatefulWidget {
  const ItemEditPage({super.key});

  @override
  State<ItemEditPage> createState() => _ItemEditPageState();
}

class _ItemEditPageState extends State<ItemEditPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

    @override
    void initState() {
        super.initState();
        
    }

    @override
    void dispose() {
      _titleController.dispose();
      _noteController.dispose();
      super.dispose();
    } 

    void _save() {
      final title = _titleController.text.trim();
      final note = _noteController.text.trim();

      if (title.isEmpty) {
      // ここでは単純にSnackBarだけ出す
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('タイトルを入力してください')),
      );
      return;
    }

    final result = ItemEditResult(
      title: title,
      note: note.isEmpty ? null : note,
    );

    context.pop(ItemEditResult(...));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('アイテムを追加'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'タイトル（必須）',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _noteController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'メモ（任意）',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _save,
                child: const Text('保存'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
