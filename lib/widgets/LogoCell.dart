import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:logo_quiz/models/Logo.dart';
import 'package:logo_quiz/screens/GameDoneScreen.dart';
import 'package:logo_quiz/screens/GameScreen.dart';
import 'package:logo_quiz/utils/SizeConfig.dart';

class LogoCell extends StatelessWidget {
  final String imgURL;
  final int id;
  final int themeId;
  final int isWin;
  final int sequence;
  final String answer;
  final Logo logo;
  final List<Logo> listLogo;

  const LogoCell(
      {Key key,
      @required this.imgURL,
      this.id,
      this.themeId,
      this.isWin,
      this.sequence,
      this.answer,
      this.logo,
      this.listLogo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElasticIn(
      duration: Duration(seconds: 3),
      child: GestureDetector(
        onTap: () {
          this.isWin == 1
              ? Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GameDoneScreen(
                            id: this.id,
                            answer: this.answer,
                            themeId: this.themeId,
                          )))
              : Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GameScreen(
                            id: this.id,
                            themeId: this.themeId,
                            sequence: this.sequence,
                            logo: this.logo,
                            listLogo: this.listLogo,
                          )));
        },
        child: Stack(
          children: [
            Container(
              width: SizeConfig.blockSizeHorizontal * 25,
              height: SizeConfig.blockSizeVertical * 13,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child: Hero(
                tag: "$id",
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  child: Image.asset(
                    imgURL,
                    scale: 1.8,
                  ),
                ),
              ),
            ),
            isWin == 1
                ? Padding(
                    padding: EdgeInsets.only(
                        top: SizeConfig.blockSizeVertical * 0.5,
                        right: SizeConfig.blockSizeHorizontal * 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          child: Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
