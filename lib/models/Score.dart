class Score {
  int score;

  Score({this.score});

  factory Score.fromMap(Map<String, dynamic> json) => new Score(
        score: json["score_coin"],
      );

  Map<String, dynamic> toMap() => {
        "score_coin": score,
      };
}
