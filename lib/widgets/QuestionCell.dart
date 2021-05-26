import 'package:flutter/material.dart';
import 'package:logo_quiz/utils/SizeConfig.dart';

class QuestionCell extends StatelessWidget {
  final String character;
  final int colorHexBackground;
  final int colorHexText;
  const QuestionCell({
    Key key,
    this.character,
    this.colorHexBackground,
    this.colorHexText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.blockSizeHorizontal * 8,
      height: SizeConfig.blockSizeVertical * 6,
      child: Container(
        width: SizeConfig.blockSizeHorizontal * 10,
        height: SizeConfig.blockSizeVertical * 5,
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: Color(colorHexBackground),
          borderRadius: BorderRadius.all(Radius.circular(15)),
          shape: BoxShape.rectangle,
        ),
        child: Center(
            child: Text(
          character,
          style: TextStyle(
              fontSize: SizeConfig.blockSizeHorizontal * 4,
              color: Color(colorHexText)),
        )),
      ),
    );
  }
}
