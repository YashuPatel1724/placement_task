import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../modal/todo_modal.dart';
import '../provider/todo_provider.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  TodoScreenState createState() => TodoScreenState();
}

class TodoScreenState extends State<TodoScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodoProvider>(context);

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.1,
        title: const Text(
          'Todos',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(provider.isGrid ? Icons.list : Icons.grid_view),
            onPressed: provider.toggleView,
          ),
          IconButton(
            icon:
            Icon(provider.isDarkTheme ? Icons.dark_mode : Icons.light_mode),
            onPressed: provider.toggleTheme,
          ),
        ],
      ),
      body: Consumer<TodoProvider>(
        builder: (context, provider, child) {
          if (provider.todos.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: provider.isGrid
                ? GridView.builder(
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: provider.todos.length,
              itemBuilder: (context, index) {
                return _buildGridTodoCard(provider.todos[index]);
              },
            )
                : ListView.builder(
              itemCount: provider.todos.length,
              itemBuilder: (context, index) {
                return _buildListTodoTile(provider.todos[index]);
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildListTodoTile(Todo todo) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: todo.completed ? Colors.green.shade100 : Colors.red.shade100,
              child: Icon(
                todo.completed ? Icons.check_circle : Icons.pending_actions,
                color: todo.completed ? Colors.green : Colors.red,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    todo.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Provider.of<TodoProvider>(context).isDarkTheme
                          ? Colors.white
                          : Colors.black,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: todo.completed ? Colors.green.shade50 : Colors.red.shade50,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      todo.completed ? 'Completed' : 'Pending',
                      style: TextStyle(
                        color: todo.completed ? Colors.green : Colors.red,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridTodoCard(Todo todo) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: todo.completed ? Colors.green.shade50 : Colors.red.shade50,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              todo.completed ? Icons.check_circle : Icons.pending_actions,
              color: todo.completed ? Colors.green : Colors.red,
              size: 40,
            ),
            const SizedBox(height: 12),
            Text(
              todo.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
                color: Provider.of<TodoProvider>(context).isDarkTheme
                    ? Colors.white
                    : Colors.black,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: todo.completed
                    ? Colors.green.shade100
                    : Colors.red.shade100,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                todo.completed ? 'Completed' : 'Pending',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                  color: todo.completed
                      ? Colors.green.shade700
                      : Colors.red.shade700,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
