import 'dart:async';
import 'package:flutter_project/feature/todo/data/model/item_model.dart';
import 'package:flutter_project/service/local_notificaion_service.dart';
import 'package:intl/intl.dart';
class NotificationManager {
  Timer? _timer;

  void startSendingNotifications(List<Item> tasklist) {
    _timer = Timer.periodic(Duration(minutes: 1), (Timer timer) {
      checkForDueTasks(tasklist);
    });
  }

  void stopSendingNotifications() {
    _timer?.cancel();
  }

  void checkForDueTasks(List<Item> taskList) {
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    for (final task in taskList) {
      if (task.date == today) {
        NotificationService().showNotification(
          title: 'Task Due',
          body: 'You have a task due today: ${task.title}',
        );
      }
    }
  }
}