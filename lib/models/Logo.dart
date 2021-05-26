class Logo {
  final int id;
  final int catId;
  final String categories;
  final String img;
  final String answer;
  final String wikipedia;
  final String oriImg;
  final int sequence;
  int isWin;

  Logo(
      {this.id,
      this.catId,
      this.categories,
      this.img,
      this.answer,
      this.wikipedia,
      this.oriImg,
      this.sequence,
      this.isWin});

  factory Logo.fromMap(Map<String, dynamic> json) => new Logo(
        id: json["id"],
        catId: json["cat_id"],
        categories: json["categories"],
        img: json["img_name"],
        answer: json["ans"],
        wikipedia: json["wikipedia"],
        oriImg: json["ori_img"],
        sequence: json["sequence"],
        isWin: json["isWin"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "cat_id": catId,
        "categories": categories,
        "img_name": img,
        "ans": answer,
        "wikipedia": wikipedia,
        "ori_img": oriImg,
        "sequence": sequence,
        "isWin": isWin,
      };
}
