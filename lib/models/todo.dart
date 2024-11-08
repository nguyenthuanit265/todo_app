class Todo {
  final String id;
  final String title;
  final DateTime dateTime;
  bool isCompleted;

  Todo({
    required this.id,
    required this.title,
    required this.dateTime,
    this.isCompleted = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'dateTime': dateTime.toIso8601String(),
      'isCompleted': isCompleted,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'],
      title: map['title'],
      dateTime: DateTime.parse(map['dateTime']),
      isCompleted: map['isCompleted'],
    );
  }
}