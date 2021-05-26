class Setting {
  int sound;

  Setting({this.sound});

  factory Setting.fromMap(Map<String, dynamic> json) => new Setting(
        sound: json["sound"],
      );

  Map<String, dynamic> toMap() => {
        "sound": sound,
      };
}
