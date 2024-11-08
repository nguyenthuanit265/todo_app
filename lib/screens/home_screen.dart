import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/todo.dart';
import '../services/notification_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Todo> todos = [];
  String selectedFilter = 'All';
  final NotificationService notificationService = NotificationService();
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    notificationService.init();
  }

  List<Todo> getFilteredTodos() {
    var filteredList = todos.where((todo) => !todo.isCompleted).toList();

    // Apply search filter
    if (searchController.text.isNotEmpty) {
      filteredList = filteredList
          .where((todo) => todo.title
              .toLowerCase()
              .contains(searchController.text.toLowerCase()))
          .toList();
    }

    // Apply category filter
    switch (selectedFilter) {
      case 'Today':
        return filteredList.where((todo) {
          return todo.dateTime.day == DateTime.now().day &&
              todo.dateTime.month == DateTime.now().month &&
              todo.dateTime.year == DateTime.now().year;
        }).toList();
      case 'Upcoming':
        return filteredList.where((todo) {
          return todo.dateTime.isAfter(DateTime.now());
        }).toList();
      default:
        return filteredList;
    }
  }

  void addTodo() async {
    final TextEditingController titleController = TextEditingController();
    DateTime? selectedDateTime;

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add New Todo'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Todo Title'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                selectedDateTime = await showDateTimePicker(context);
                setState(() {});
              },
              child: Text('Select Date & Time'),
            ),
            if (selectedDateTime != null)
              Text(
                'Selected: ${selectedDateTime.toString()}',
                style: TextStyle(fontSize: 12),
              ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (titleController.text.isNotEmpty && selectedDateTime != null) {
                final newTodo = Todo(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  title: titleController.text,
                  dateTime: selectedDateTime!,
                );
                setState(() {
                  todos.add(newTodo);
                });
                notificationService.scheduleNotification(
                    id: int.parse(newTodo.id),
                    title: 'TODO Reminder',
                    body: newTodo.title,
                    scheduledDate: newTodo.dateTime);
                Navigator.pop(context);
              }
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }

  Future<DateTime?> showDateTimePicker(BuildContext context) async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );

    if (date != null) {
      final TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (time != null) {
        return DateTime(
          date.year,
          date.month,
          date.day,
          time.hour,
          time.minute,
        );
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final filteredTodos = getFilteredTodos();

    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Search Todos',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: ['All', 'Today', 'Upcoming'].map((filter) {
              return ChoiceChip(
                label: Text(filter),
                selected: selectedFilter == filter,
                onSelected: (selected) {
                  setState(() {
                    selectedFilter = filter;
                  });
                },
              );
            }).toList(),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredTodos.length,
              itemBuilder: (context, index) {
                final todo = filteredTodos[index];
                return ListTile(
                  title: Text(todo.title),
                  subtitle: Text(todo.dateTime.toString()),
                  trailing: IconButton(
                    icon: Icon(Icons.check_circle_outline),
                    onPressed: () {
                      setState(() {
                        todo.isCompleted = true;
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addTodo,
        child: Icon(Icons.add),
      ),
    );
  }
}
