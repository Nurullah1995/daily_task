import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_project/feature/todo/data/model/item_model.dart';
import 'package:flutter_project/service/local_notificaion_service.dart';
import 'package:meta/meta.dart';

part 'add_todo_event.dart';
part 'add_todo_state.dart';


class AddTodoBloc extends Bloc<AddTodoEvent, AddTodoState> {
  AddTodoBloc() : super(AddTodoState(itemTitle:'' ,status: Status.initial,isOnCompleteTask: false,taskList: [],isOnClickDatePicker: false,isOnClickNotification: false,isShowCheckRightButton: false,date: '')) {

    on<AddNoteTitle>(_addNoteTitle);
    on<ToggleCheckBox>(_toggleCheckBox);
    on<OnClickNotificationEvent>(_onClickNotificationEvent);
    on<AddItemEvent>(_addItemEvent);
    on<RemoveItemEvent>(_removeItemEvent);
    on<OnTapForShowRightButtonEvent>(_onTapForShowRightButtonEvent);
    on<SetDataEvent>(_setDataEvent);
  }

  FutureOr<void> _addNoteTitle(AddNoteTitle event, Emitter<AddTodoState> emit) {
    emit(state.copyWith(itemTitle: event.listOfItem,status: Status.success));
  }

  FutureOr<void> _toggleCheckBox(ToggleCheckBox event, Emitter<AddTodoState> emit) {
    emit(state.copyWith(isOnCompleteTask: !state.isOnCompleteTask));
  }

  FutureOr<void> _onClickNotificationEvent(OnClickNotificationEvent event, Emitter<AddTodoState> emit) {
    emit(state.copyWith(isOnClickNotification: !state.isOnClickNotification));
  }

  FutureOr<void> _addItemEvent(AddItemEvent event, Emitter<AddTodoState> emit) {
    bool itemExists = state.taskList.any((item) => item.title == event.item.title);
    if(!itemExists){
      int? lastId = state.taskList.isNotEmpty
          ? state.taskList.map((item) => item.id).reduce((a, b) => a! > b! ? a : b)
          : 0;
      int newId = lastId! + 1;
      final newItem=Item(id:newId,title: event.item.title,count: state.taskList.length,isOnTaskComplete: state.isOnCompleteTask,isOnClickNotification: state.isOnClickNotification,date: state.date);
      emit(state.copyWith(taskList:[...state.taskList,newItem]));
      emit(state.copyWith(isShowCheckRightButton: false,isOnClickNotification: false,isOnCompleteTask: false,isOnClickDatePicker: false,date: ''));
      NotificationService().showNotification(
        title: 'New Task added',
        body: 'You have tasks added Successfully today!',
      );
    }
  }

  FutureOr<void> _removeItemEvent(RemoveItemEvent event, Emitter<AddTodoState> emit) {
    final updatedTaskList = state.taskList.where((item) => item.id != event.item.id).toList();

    // Emit the new state with the updated task list
    emit(state.copyWith(taskList: updatedTaskList,status: Status.success));

    NotificationService().showNotification(
      title: 'Your Task Deleted',
      body: 'You have tasks Deleted Successfully today!',
    );
  }

  FutureOr<void> _onTapForShowRightButtonEvent(OnTapForShowRightButtonEvent event, Emitter<AddTodoState> emit) {
    emit(state.copyWith(isShowCheckRightButton: true));
  }

  FutureOr<void> _setDataEvent(SetDataEvent event, Emitter<AddTodoState> emit) {
    emit(state.copyWith(isOnClickDatePicker: true,date: event.date));
  }
}
