import 'package:flutter/material.dart';
import 'package:flutter_project/feature/todo/presentation/bloc/add_todo_bloc/add_todo_bloc.dart';
import 'package:flutter_project/feature/todo/presentation/pages/add_todo_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/utils/Colors.dart';
import 'package:flutter_project/utils/shedule_notification.dart';

class TodoProfileScreen extends StatefulWidget {
  const TodoProfileScreen({super.key});

  @override
  State<TodoProfileScreen> createState() => _TodoProfileScreenState();
}

class _TodoProfileScreenState extends State<TodoProfileScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddTodoBloc, AddTodoState>(
  listener: (context, state) {
    NotificationManager().startSendingNotifications(state.taskList);
  },
  child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            // Profile Image
            CircleAvatar(
              radius: 24,
              backgroundImage: NetworkImage(
                'https://static.vecteezy.com/system/resources/thumbnails/006/487/917/small_2x/man-avatar-icon-free-vector.jpg',
              ),
            ),
             SizedBox(width: 10),
             Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Md.Nurullah',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                BlocBuilder<AddTodoBloc, AddTodoState>(
                  builder: (context, state) {
                    int incompleteTasks = state.taskList.where((item) => !item.isOnTaskComplete!).length;
                    int completedTasks = state.taskList.where((item) => item.isOnTaskComplete!).length;

                    return Text(
                      '$incompleteTasks incomplete, $completedTasks completed',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ],
            ),
            const Spacer(),
            // Search Icon
            IconButton(
              icon: const Icon(Icons.search, color: Colors.black),
              onPressed: () {
                // Implement search functionality here
              },
            )
          ],
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<AddTodoBloc, AddTodoState>(
            builder: (context, state) {
              if (state.status == Status.success) {
                return ListTile(
                  leading: const Icon(Icons.list_alt, color: Colors.teal),
                  title: Text(
                    state.itemTitle,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: Text(state.taskList.length.toString(),
                      style: TextStyle(fontSize: 16)),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddTodoScreen()),
                    );
                  },
                );
              }
              return SizedBox.shrink();
            },
          )
      ),
      // Floating Action Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTodoScreen()),
          );
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add),
      ),
    ),
);
  }
}
