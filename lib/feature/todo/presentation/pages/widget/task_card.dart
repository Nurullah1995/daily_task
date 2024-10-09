import 'package:flutter/material.dart';
import 'package:flutter_project/feature/todo/data/model/item_model.dart';
import 'package:flutter_project/feature/todo/presentation/bloc/add_todo_bloc/add_todo_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class TaskCard extends StatelessWidget {
  final Item task;
  final VoidCallback onClickTask;

  TaskCard({required this.task, required this.onClickTask});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClickTask,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Row(
            children: [
              BlocBuilder<AddTodoBloc, AddTodoState>(
                builder: (context, state) {
                  return Checkbox(
                    value: task.isOnTaskComplete,
                    onChanged: (bool? value) {

                    },
                  );
                },
              ),
              const SizedBox(width: 12.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4.0),
                  Row(
                    children: [
                      Icon(
                          Icons.calendar_today, size: 16.0, color: Colors.grey),
                      const SizedBox(width: 4.0),
                      Text(
                        task.date ?? '',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              Spacer(),
              Icon(Icons.star_border, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
