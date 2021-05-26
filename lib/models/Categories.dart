class Categories {
  final int id;
  int count;
  final int all;

  Categories({this.id, this.count, this.all});

  factory Categories.fromMap(Map<String, dynamic> json) => new Categories(
        id: json["id"],
        count: json["count"],
        all: json["all"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "count": count,
        "all": all,
      };
}
