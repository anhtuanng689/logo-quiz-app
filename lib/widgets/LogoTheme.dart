import 'dart:math';
import 'package:logo_quiz/utils/Audio.dart';
import 'package:flutter/material.dart';
import 'package:logo_quiz/db/DatabaseProvider.dart';
import 'package:logo_quiz/models/Categories.dart';
import 'package:logo_quiz/provider/LogoProvider.dart';
import 'package:logo_quiz/utils/SizeConfig.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:logo_quiz/screens/LogoGridScreen.dart';
import 'package:provider/provider.dart';

class LogoTheme extends StatelessWidget {
  final String themeName;
  final int themeLevel;
  final int themeColor;
  final String themeIconURL;
  final double progressPercent;
  final int themeId;

  LogoTheme({
    this.themeName,
    this.themeLevel,
    this.themeIconURL,
    this.progressPercent,
    this.themeColor,
    this.themeId,
  });

  joinLogoName(String name) {
    return name.split(" ").join("");
  }

  Color randomColor() {
    return Colors.primaries[_random.nextInt(Colors.accents.length)];
  }

  Random _random = Random();

  @override
  Widget build(BuildContext context) {
    Color _color = randomColor();
    final logoData = Provider.of<LogoProvider>(context, listen: false);
    return Container(
        padding: EdgeInsets.symmetric(
          vertical: SizeConfig.blockSizeVertical * 3,
        ),
        height: SizeConfig.blockSizeVertical * 30,
        width: SizeConfig.screenWidth * 0.9,
        decoration: BoxDecoration(
          color: Color(0xFF22214B),
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/drawable/icon_${joinLogoName(themeIconURL)}.png',
                  width: SizeConfig.blockSizeHorizontal * 12,
                  color: _color,
                  // scale: 1.5,
                ),
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 3,
                ),
                Column(
                  children: [
                    Text(
                      themeName,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        // color: Color(themeColor),
                        color: _color,
                        fontWeight: FontWeight.w600,
                        fontSize: SizeConfig.blockSizeVertical * 2.6,
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical,
                    ),
                    Text(
                      'Level $themeLevel',
                      style: TextStyle(
                        color: Color(0xFF94A3B8),
                        fontSize: SizeConfig.blockSizeVertical * 2.5,
                      ),
                    ),
                  ],
                )
              ],
            ),
            FutureBuilder(
              future: DatabaseProvider.dbProvider.fetchCategory(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  List<Categories> list = snapshot.data;
                  return Expanded(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              right: SizeConfig.blockSizeHorizontal * 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                '${list[themeLevel - 1].count}/${list[themeLevel - 1].all}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: SizeConfig.blockSizeVertical * 2.9,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 2,
                        ),
                        LinearPercentIndicator(
                          alignment: MainAxisAlignment.center,
                          width: SizeConfig.screenWidth * 0.75,
                          lineHeight: SizeConfig.blockSizeVertical * 2,
                          // percent: 0.20,
                          percent: list[themeLevel - 1].count /
                              list[themeLevel - 1].all,
                          backgroundColor: Color(0xFF3B3A72),
                          progressColor: Color(0xFFEE0056),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (logoData.soundCheck == 1) {
                  Audio.playNormalClick();
                }
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LogoGridScreen(
                              themeId: themeId,
                            )));
              },
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.blockSizeHorizontal * 12,
                    vertical: SizeConfig.blockSizeVertical * 1.5),
                child: Text(
                  'Start',
                  style: TextStyle(
                    color: Color(0xFFCBD5E1),
                    fontWeight: FontWeight.w600,
                    fontSize: SizeConfig.blockSizeVertical * 3,
                  ),
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
          ],
        ));
  }
}
