import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

// Assuming these classes are defined elsewhere in your project
import 'package:flutter_project/feature/todo/data/model/item_model.dart';
import 'package:flutter_project/feature/todo/presentation/bloc/add_todo_bloc/add_todo_bloc.dart';
import 'package:flutter_project/utils/Colors.dart';

class BottomSheetContent extends StatefulWidget {
  @override
  _BottomSheetContentState createState() => _BottomSheetContentState();
}

class _BottomSheetContentState extends State<BottomSheetContent> {
  final TextEditingController _controller = TextEditingController();

  Future<DateTime?> _pickDate(BuildContext context) async {
    return await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              BlocBuilder<AddTodoBloc, AddTodoState>(
                builder: (context, state) {
                  return Checkbox(
                    value: state.isOnCompleteTask,
                    onChanged: (bool? value) {
                      context.read<AddTodoBloc>().add(ToggleCheckBox());
                    },
                  );
                },
              ),
              Expanded(
                child: BlocBuilder<AddTodoBloc, AddTodoState>(
                  builder: (context, state) {
                    return TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: 'Add a task',
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                      onTap: () {
                        context.read<AddTodoBloc>().add(
                            OnTapForShowRightButtonEvent(showRightButton: true));
                      },
                      onSubmitted: (str) {
                        context.read<AddTodoBloc>().add(AddItemEvent(
                          item: Item(
                            title: str,
                            isOnTaskComplete: state.isOnCompleteTask,
                            isOnClickNotification: state.isOnClickNotification,
                          ),
                        ));
                        Navigator.of(context).pop();
                      },
                    );
                  },
                ),
              ),
              BlocBuilder<AddTodoBloc, AddTodoState>(
                builder: (context, state) {
                  return IconButton(
                    icon: Icon(
                      Icons.check_circle,
                      color: state.isShowCheckRightButton
                          ? AppColors.primary
                          : Colors.grey,
                    ),
                    onPressed: () {
                      if (state.isShowCheckRightButton) {
                        context.read<AddTodoBloc>().add(AddItemEvent(
                          item: Item(
                            title: _controller.text.trim(),
                            isOnTaskComplete: state.isOnCompleteTask,
                            isOnClickNotification: state.isOnClickNotification,
                          ),
                        ));
                      }
                      Navigator.of(context).pop();
                    },
                  );
                },
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              BlocBuilder<AddTodoBloc, AddTodoState>(
                builder: (context, state) {
                  return IconButton(
                    icon: Icon(
                      Icons.notifications_none,
                      color: state.isOnClickNotification
                          ? AppColors.primary
                          : Colors.grey,
                    ),
                    onPressed: () {
                      context.read<AddTodoBloc>().add(OnClickNotificationEvent());
                    },
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.note_add, color: Colors.grey),
                onPressed: () {
                  // Handle note add action
                },
              ),
              BlocBuilder<AddTodoBloc, AddTodoState>(
                builder: (context, state) {
                  return IconButton(
                    icon: Icon(
                      Icons.calendar_today,
                      color: state.isOnClickDatePicker ? AppColors.primary : Colors.grey,
                    ),
                    onPressed: () async {
                      DateTime? picked = await _pickDate(context);
                      if (picked != null) {
                        String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
                        context.read<AddTodoBloc>().add(SetDataEvent(date: formattedDate));
                      }
                    },
                  );
                },
              ),
            ],
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // Clean up the controller when the widget is disposed
    super.dispose();
  }
}

// Example method to show the bottom sheet
void showBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isDismissible: true,
    builder: (context) => BottomSheetContent(),
  );
}
