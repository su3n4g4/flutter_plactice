class Item {
  final String id;
  final String title;
  final String? note;

  Item({
    required this.id,
    required this.title,
    this.note,
  });
}