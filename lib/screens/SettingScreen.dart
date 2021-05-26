import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logo_quiz/db/DatabaseProvider.dart';
import 'package:logo_quiz/provider/LogoProvider.dart';
import 'package:logo_quiz/utils/SizeConfig.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:xlive_switch/xlive_switch.dart';
import 'package:logo_quiz/models/Setting.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key key}) : super(key: key);
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isSound;
  Setting setting = Setting();

  void updateSound(bool check) async {
    if (check) {
      setting.sound = 1;
    } else {
      setting.sound = 0;
    }
    await DatabaseProvider.dbProvider.updateSetting(setting);
  }

  void fetchSoundData() {
    int temp = Provider.of<LogoProvider>(context, listen: false).soundCheck;
    if (temp == 1) {
      isSound = true;
    } else {
      isSound = false;
    }
  }

  @override
  void initState() {
    super.initState();
    fetchSoundData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(SizeConfig.screenHeight * 0.15),
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.blockSizeHorizontal * 4,
                vertical: SizeConfig.blockSizeVertical),
            color: Color(0xFF070723),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    padding: EdgeInsets.zero,
                    icon: SvgPicture.asset(
                      'assets/icons/back.svg',
                      height: SizeConfig.blockSizeVertical * 6,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ],
            ),
          ),
        ),
        body: Stack(
          children: [
            Container(
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/homescreen.png"),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.blockSizeHorizontal * 5,
                  vertical: SizeConfig.blockSizeVertical),
              child: Column(
                children: [
                  Container(
                    height: SizeConfig.blockSizeVertical * 15,
                    width: SizeConfig.screenWidth,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SvgPicture.asset(
                          "assets/images/logoQuiz.svg",
                          width: SizeConfig.blockSizeHorizontal * 75,
                          // scale: 0.6,
                        ),
                      ],
                    ),
                  ),
                  Container(
                      height: SizeConfig.blockSizeVertical * 10,
                      width: SizeConfig.screenWidth,
                      child: Center(
                        child: Text(
                          "Setting",
                          style: TextStyle(
                            fontSize: SizeConfig.blockSizeVertical * 3,
                            color: Colors.white,
                          ),
                        ),
                      )),
                  Container(
                    height: SizeConfig.blockSizeVertical * 7,
                    width: SizeConfig.screenWidth,
                    child: Column(
                      children: [
                        Spacer(),
                        Row(
                          children: [
                            Text(
                              "Sound",
                              style: TextStyle(
                                fontSize: SizeConfig.blockSizeVertical * 2.5,
                                color: Color(0xFF94a2b7),
                              ),
                            ),
                            Spacer(),
                            XlivSwitch(
                              value: isSound,
                              onChanged: (bool value) {
                                setState(() {
                                  isSound = !isSound;
                                  updateSound(isSound);
                                });
                              },
                            ),
                          ],
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 2,
                  ),
                  Container(
                    height: SizeConfig.blockSizeVertical * 30,
                    width: SizeConfig.screenWidth,
                    child: Column(
                      children: [
                        Spacer(),
                        Row(
                          children: [
                            Text(
                              "More",
                              style: TextStyle(
                                fontSize: SizeConfig.blockSizeVertical * 2.5,
                                color: Color(0xFFFF006d),
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Row(
                          children: [
                            Text(
                              "About us",
                              style: TextStyle(
                                fontSize: SizeConfig.blockSizeVertical * 2.5,
                                color: Color(0xFF94a2b7),
                              ),
                            ),
                            Spacer(),
                            IconButton(
                                icon: Icon(
                                  Icons.keyboard_arrow_right,
                                  color: Colors.grey,
                                ),
                                onPressed: () {}),
                          ],
                        ),
                        Spacer(),
                        Row(
                          children: [
                            Text(
                              "Privacy policy",
                              style: TextStyle(
                                fontSize: SizeConfig.blockSizeVertical * 2.5,
                                color: Color(0xFF94a2b7),
                              ),
                            ),
                            Spacer(),
                            IconButton(
                                icon: Icon(
                                  Icons.keyboard_arrow_right,
                                  color: Colors.grey,
                                ),
                                onPressed: () {}),
                          ],
                        ),
                        Spacer(),
                        Row(
                          children: [
                            Text(
                              "Terms and conditions",
                              style: TextStyle(
                                fontSize: SizeConfig.blockSizeVertical * 2.5,
                                color: Color(0xFF94a2b7),
                              ),
                            ),
                            Spacer(),
                            IconButton(
                                icon: Icon(
                                  Icons.keyboard_arrow_right,
                                  color: Colors.grey,
                                ),
                                onPressed: () {}),
                          ],
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
