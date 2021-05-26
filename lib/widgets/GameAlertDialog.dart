import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:logo_quiz/utils/SizeConfig.dart';

class GameAlertDialog extends StatefulWidget {
  @override
  _GameAlertDialogState createState() => _GameAlertDialogState();
}

class _GameAlertDialogState extends State<GameAlertDialog> {
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
            height: SizeConfig.screenHeight * 0.3,
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
                  'Are you sure?',
                  style: TextStyle(
                      fontSize: SizeConfig.blockSizeVertical * 4.5,
                      color: Color(0xFFEE0056),
                      fontWeight: FontWeight.w600),
                ),
                Spacer(),
                Text(
                  'Your progress will not save!!!',
                  style: TextStyle(
                      fontSize: SizeConfig.blockSizeVertical * 2,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
                Spacer(),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          choice = 1;
                          Navigator.pop(context, choice);
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: SizeConfig.blockSizeVertical),
                        child: Text(
                          'Yes',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: SizeConfig.blockSizeVertical * 2,
                          ),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.redAccent,
                          elevation: SizeConfig.blockSizeVertical,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.horizontal(
                                  left: Radius.circular(30),
                                  right: Radius.circular(30)))),
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
                            vertical: SizeConfig.blockSizeVertical),
                        child: Text(
                          'No',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: SizeConfig.blockSizeVertical * 2,
                          ),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.greenAccent,
                          elevation: SizeConfig.blockSizeVertical,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.horizontal(
                                  left: Radius.circular(30),
                                  right: Radius.circular(30)))),
                    ),
                  ],
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
