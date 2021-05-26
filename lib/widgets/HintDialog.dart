import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logo_quiz/utils/SizeConfig.dart';

class HintDialog extends StatefulWidget {
  @override
  _HintDialogState createState() => _HintDialogState();
}

class _HintDialogState extends State<HintDialog> {
  int choice;
  @override
  Widget build(BuildContext context) {
    return FadeIn(
      duration: Duration(seconds: 1),
      child: Material(
        type: MaterialType.transparency,
        child: Center(
          child: Container(
            width: SizeConfig.screenWidth * 0.9,
            height: SizeConfig.screenHeight * 0.65,
            padding: EdgeInsets.all(SizeConfig.blockSizeVertical * 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(45)),
              image: DecorationImage(
                image: AssetImage("assets/images/homescreen.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                Spacer(),
                Text(
                  'Hint',
                  style: TextStyle(
                      fontSize: SizeConfig.blockSizeVertical * 4.5,
                      color: Color(0xFFF9C94D),
                      fontWeight: FontWeight.w600),
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      choice = 1;
                      Navigator.pop(context, choice);
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        // horizontal: SizeConfig.blockSizeHorizontal * 2,
                        vertical: SizeConfig.blockSizeVertical * 2.5),
                    child: Row(
                      children: [
                        Spacer(),
                        SvgPicture.asset(
                          'assets/icons/idea.svg',
                          width: SizeConfig.blockSizeVertical * 5,
                        ),
                        SizedBox(
                          width: SizeConfig.blockSizeHorizontal * 3,
                        ),
                        Text(
                          'Hint (Watch video)',
                          style: TextStyle(
                            color: Color(0xFFCBD5E1),
                            fontWeight: FontWeight.w600,
                            fontSize: SizeConfig.blockSizeVertical * 2,
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Color(0xFF1A1742),
                      elevation: SizeConfig.blockSizeVertical * 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(60),
                              right: Radius.circular(60)))),
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      choice = 2;
                      Navigator.pop(context, choice);
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        // horizontal: SizeConfig.blockSizeHorizontal * 2,
                        vertical: SizeConfig.blockSizeVertical * 2.5),
                    child: Row(
                      children: [
                        Spacer(),
                        SvgPicture.asset(
                          'assets/icons/question.svg',
                          width: SizeConfig.blockSizeVertical * 5,
                        ),
                        SizedBox(
                          width: SizeConfig.blockSizeHorizontal * 3,
                        ),
                        Text(
                          'Random Letter (50)',
                          style: TextStyle(
                            color: Color(0xFFCBD5E1),
                            fontWeight: FontWeight.w600,
                            fontSize: SizeConfig.blockSizeVertical * 2,
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Color(0xFF1A1742),
                      elevation: SizeConfig.blockSizeVertical * 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(60),
                              right: Radius.circular(60)))),
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      choice = 3;
                      Navigator.pop(context, choice);
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        // horizontal: SizeConfig.blockSizeHorizontal * 6,
                        vertical: SizeConfig.blockSizeVertical * 2.5),
                    child: Row(
                      children: [
                        Spacer(),
                        SvgPicture.asset(
                          'assets/icons/star.svg',
                          width: SizeConfig.blockSizeVertical * 5,
                        ),
                        SizedBox(
                          width: SizeConfig.blockSizeHorizontal * 3,
                        ),
                        Text(
                          'Show Answer (400)',
                          style: TextStyle(
                            color: Color(0xFFCBD5E1),
                            fontWeight: FontWeight.w600,
                            fontSize: SizeConfig.blockSizeVertical * 2,
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Color(0xFF1A1742),
                      elevation: SizeConfig.blockSizeVertical * 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(60),
                              right: Radius.circular(60)))),
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        // horizontal: SizeConfig.blockSizeHorizontal * 6,
                        vertical: SizeConfig.blockSizeVertical),
                    child: Text(
                      'Close',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: SizeConfig.blockSizeVertical * 2,
                      ),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.blueGrey,
                      elevation: SizeConfig.blockSizeVertical,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(30),
                              right: Radius.circular(30)))),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
