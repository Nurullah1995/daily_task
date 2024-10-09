part of 'add_todo_bloc.dart';

@immutable
sealed class AddTodoEvent {}

class AddNoteTitle extends AddTodoEvent{
     final String listOfItem;
     AddNoteTitle({required this.listOfItem});
}

class ToggleCheckBox extends AddTodoEvent{}
class OnClickNotificationEvent extends AddTodoEvent{}
class OnTapForShowRightButtonEvent extends AddTodoEvent{
     final bool showRightButton;
     OnTapForShowRightButtonEvent({required this.showRightButton});
}
class AddItemEvent extends AddTodoEvent{
     final Item item;
     AddItemEvent({required this.item});
}

class RemoveItemEvent extends AddTodoEvent{
     final Item item;
     RemoveItemEvent({required this.item});
}

class SetDataEvent extends AddTodoEvent{
     final String date;
     SetDataEvent({required this.date});
}