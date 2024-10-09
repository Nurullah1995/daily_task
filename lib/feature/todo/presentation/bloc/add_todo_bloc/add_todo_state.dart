part of 'add_todo_bloc.dart';
enum Status{initial,Loading,success}
class AddTodoState {
    final String  itemTitle;
   final  Status status;
   final List<Item> taskList;
   final bool isOnCompleteTask;
   final bool isOnClickNotification;
   final bool isShowCheckRightButton;
   final bool isOnClickDatePicker;
   final String date;

    const AddTodoState({
    required this.itemTitle,
    required this.status,
    required this.taskList,
    required this.isOnCompleteTask,
    required this.isOnClickNotification,
    required this.isShowCheckRightButton,
    required this.isOnClickDatePicker,
    required this.date,
  });

    AddTodoState copyWith({
    String? itemTitle,
    Status? status,
    List<Item>? taskList,
    bool? isOnCompleteTask,
    bool? isOnClickNotification,
    bool? isShowCheckRightButton,
    bool? isOnClickDatePicker,
    String? date,
  }) {
    return AddTodoState(
      itemTitle: itemTitle ?? this.itemTitle,
      status: status ?? this.status,
      taskList: taskList ?? this.taskList,
      isOnCompleteTask: isOnCompleteTask ?? this.isOnCompleteTask,
      isOnClickNotification:
          isOnClickNotification ?? this.isOnClickNotification,
      isShowCheckRightButton:
          isShowCheckRightButton ?? this.isShowCheckRightButton,
      isOnClickDatePicker: isOnClickDatePicker ?? this.isOnClickDatePicker,
      date: date ?? this.date,
    );
  }
}
