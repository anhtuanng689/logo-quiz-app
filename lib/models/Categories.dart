class Categories {
  final int id;
  int count;
  final int all;
  final int expected;

  Categories({this.id, this.count, this.all, this.expected});

  factory Categories.fromMap(Map<String, dynamic> json) => new Categories(
        id: json["id"],
        count: json["count"],
        all: json["all"],
        expected: json["expected"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "count": count,
        "all": all,
        "expected": expected,
      };
}
