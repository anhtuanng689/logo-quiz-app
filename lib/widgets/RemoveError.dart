import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:logo_quiz/utils/SizeConfig.dart';

class RemoveError extends StatelessWidget {
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
                  'Error',
                  style: TextStyle(
                      fontSize: SizeConfig.blockSizeVertical * 4.5,
                      color: Color(0xFFEE0056),
                      fontWeight: FontWeight.w600),
                ),
                Spacer(),
                Text(
                  'You can' 't use it after using hint!!!',
                  style: TextStyle(
                      fontSize: SizeConfig.blockSizeVertical * 2,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
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
