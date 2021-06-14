import 'package:flutter/material.dart';
import 'package:logo_quiz/utils/SizeConfig.dart';

class TextCell extends StatelessWidget {
  final String character;

  const TextCell({
    Key key,
    this.character,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: SizedBox(
        width: SizeConfig.blockSizeHorizontal * 13,
        height: SizeConfig.blockSizeVertical * 8,
        child: Container(
          width: SizeConfig.blockSizeHorizontal * 10,
          height: SizeConfig.blockSizeVertical * 5,
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: Color(0xFF1A1742),
            borderRadius: BorderRadius.all(Radius.circular(15)),
            shape: BoxShape.rectangle,
          ),
          child: Center(
              child: Text(
            character,
            style: TextStyle(
                fontSize: SizeConfig.blockSizeHorizontal * 5,
                color: Colors.white),
          )),
        ),
      ),
    );
  }
}
