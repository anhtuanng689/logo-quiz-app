class Setting {
  int id;
  int sound;
  int notification;
  int isDone;

  Setting({this.id, this.sound, this.notification, this.isDone});

  factory Setting.fromMap(Map<String, dynamic> json) => new Setting(
        id: json["id"],
        sound: json["sound"],
        notification: json["notification"],
        isDone: json["isDone"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "sound": sound,
        "notification": notification,
        "isDone": isDone,
      };
}
