import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logo_quiz/db/DatabaseProvider.dart';
import 'package:logo_quiz/models/Setting.dart';
import 'package:logo_quiz/provider/LogoProvider.dart';
import 'package:logo_quiz/provider/Notification.dart';
import 'package:logo_quiz/screens/HomeScreen.dart';
import 'package:logo_quiz/utils/SizeConfig.dart';
import 'package:provider/provider.dart';
import 'package:xlive_switch/xlive_switch.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isSound;
  bool isNotification;

  bool loading;

  void updateSetting(Setting setting) async {
    await DatabaseProvider.dbProvider.updateSetting(setting);
  }

  void fetchSetting() async {
    loading = true;
    setState(() {});

    int sound = Provider.of<LogoProvider>(context, listen: false).soundCheck;
    if (sound == 1) {
      isSound = true;
    } else {
      isSound = false;
    }

    int notification =
        Provider.of<LogoProvider>(context, listen: false).notificationCheck;
    if (notification == 1) {
      isNotification = true;
    } else {
      isNotification = false;
    }
    print(notification);

    loading = false;
    int done = Provider.of<LogoProvider>(context, listen: false).isDone;
    print('done $done');
    if (done == 0) {
      Provider.of<NotificationService>(context, listen: false)
          .dailyIntervalNotification(context);
      Provider.of<LogoProvider>(context, listen: false).getDoneChoice(1);
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchSetting();
    Provider.of<NotificationService>(context, listen: false).initilize();
  }

  @override
  Widget build(BuildContext context) {
    final logoData = Provider.of<LogoProvider>(context, listen: false);
    final notifiData = Provider.of<NotificationService>(context, listen: false);
    print(loading);
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
                    enableFeedback: logoData.isSound,
                    padding: EdgeInsets.zero,
                    icon: SvgPicture.asset(
                      'assets/icons/back.svg',
                      height: SizeConfig.blockSizeVertical * 6,
                    ),
                    onPressed: () {
                      updateSetting(logoData.gameSetting);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()));
                    }),
              ],
            ),
          ),
        ),
        body: WillPopScope(
          onWillPop: () async {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
            return true;
          },
          child: Stack(
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
              loading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.blockSizeHorizontal * 5,
                          vertical: SizeConfig.blockSizeVertical),
                      child: Column(
                        children: [
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
                            height: SizeConfig.blockSizeVertical * 16,
                            width: SizeConfig.screenWidth,
                            child: Column(
                              children: [
                                Spacer(),
                                Row(
                                  children: [
                                    Text(
                                      "Sound",
                                      style: TextStyle(
                                        fontSize:
                                            SizeConfig.blockSizeVertical * 2.5,
                                        color: Color(0xFF94a2b7),
                                      ),
                                    ),
                                    Spacer(),
                                    XlivSwitch(
                                      value: isSound,
                                      onChanged: (bool value) {
                                        setState(() {
                                          isSound = !isSound;
                                          if (isSound) {
                                            logoData.getSoundChoice(1);
                                          } else {
                                            logoData.getSoundChoice(0);
                                          }
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Row(
                                  children: [
                                    Text(
                                      "Notification",
                                      style: TextStyle(
                                        fontSize:
                                            SizeConfig.blockSizeVertical * 2.5,
                                        color: Color(0xFF94a2b7),
                                      ),
                                    ),
                                    Spacer(),
                                    XlivSwitch(
                                      value: isNotification,
                                      onChanged: (bool value) {
                                        setState(() {
                                          isNotification = !isNotification;
                                          print(isNotification);

                                          if (isNotification) {
                                            logoData.getNotificationChoice(1);
                                            notifiData
                                                .dailyIntervalNotification(
                                                    context);
                                          } else {
                                            logoData.getNotificationChoice(0);
                                            notifiData.deleteAllNotification();
                                          }
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
                                        fontSize:
                                            SizeConfig.blockSizeVertical * 2.5,
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
                                        fontSize:
                                            SizeConfig.blockSizeVertical * 2.5,
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
                                        fontSize:
                                            SizeConfig.blockSizeVertical * 2.5,
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
                                        fontSize:
                                            SizeConfig.blockSizeVertical * 2.5,
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
      ),
    );
  }
}
