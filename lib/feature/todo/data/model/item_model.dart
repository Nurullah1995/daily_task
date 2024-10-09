class Item{
    final int? id;
    final String title;
    final int? count;
    final String? note;
    final String? date;
    final bool? isOnTaskComplete;
    final bool? isShowRightCheckButton;
    final bool? isOnClickNotification;

    const Item({
     this.id,
    required this.title,
      this.count,
      this.note,
      this.date,
      this.isOnTaskComplete,
      this.isShowRightCheckButton,
      this.isOnClickNotification,
  });
}