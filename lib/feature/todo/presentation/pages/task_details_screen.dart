import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/feature/todo/data/model/item_model.dart';
import 'package:flutter_project/feature/todo/presentation/bloc/add_todo_bloc/add_todo_bloc.dart';
import 'package:flutter_project/utils/Colors.dart';

class TaskScreen extends StatelessWidget {
  final Item item;
  TaskScreen({required this.item});

  void _showDeleteBottomSheet(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        message: Text('"${item.title}" will be permanently deleted.'),
        actions: [
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              context.read<AddTodoBloc>().add(RemoveItemEvent(item: item));
            },
            child: Text('Delete Task'),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('checkId: ${item.isOnTaskComplete}');
    return BlocListener<AddTodoBloc, AddTodoState>(
      listener: (context, state) {
        debugPrint('Status: ${state.status}');
        if (state.status == Status.success) {
          Navigator.pop(context); // Close the CupertinoModalPopup
          Navigator.pop(context); // Close the TaskScreen
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(item.title),
          elevation: 0, // To remove shadow under AppBar
          backgroundColor: Colors.white, // AppBar background color
          foregroundColor: Colors.black, // Text and icon color
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: Icon(Icons.notifications_none,color:item.isOnTaskComplete!?AppColors.primary: Colors.grey),
                title: Text('Remind Me',),
              ),
              ListTile(
                leading:
                    Icon(Icons.calendar_today_outlined, color: AppColors.primary,),
                title: Text('Due ${item.date}',
                    style: TextStyle(color: AppColors.primary,)),
              ),
              ListTile(
                leading: Icon(Icons.note_add),
                title: Text('Add Note'),
              ),
              Spacer(),
              Center(
                child: TextButton.icon(
                  icon: Icon(Icons.delete, color: Colors.red),
                  label: Text('Delete', style: TextStyle(color: Colors.red)),
                  onPressed: () {
                    _showDeleteBottomSheet(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
