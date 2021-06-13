import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logo_quiz/db/DatabaseProvider.dart';
import 'package:logo_quiz/provider/LogoProvider.dart';
import 'package:logo_quiz/utils/Audio.dart';
import 'package:logo_quiz/utils/SizeConfig.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logo_quiz/screens/SettingScreen.dart';
import 'package:logo_quiz/screens/PurchaseScreen.dart';
import 'package:provider/provider.dart';
import 'package:logo_quiz/screens/GameHome.dart';
import 'package:logo_quiz/screens/HowToPlayScreen.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool loading;

  checkSetting() async {
    loading = true;
    setState(() {});
    print('fetching');
    await Provider.of<LogoProvider>(context, listen: false).fetchGameSetting();
    await Provider.of<LogoProvider>(context, listen: false).fetchData();
    print('done fetching');
    loading = false;
    setState(() {});
  }

  @override
  void initState() {
    checkSetting();
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('America/Detroit'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final logoData = Provider.of<LogoProvider>(context, listen: false);
    SizeConfig().init(context);
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
                    // TODO: loi
                    enableFeedback: loading ? true : logoData.isSound,
                    padding: EdgeInsets.zero,
                    icon: SvgPicture.asset(
                      'assets/icons/setting.svg',
                      height: SizeConfig.blockSizeVertical * 6,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SettingScreen()));
                    }),
                Container(
                  child: Row(
                    children: [
                      AbsorbPointer(
                        absorbing: true,
                        child: IconButton(
                            icon: SvgPicture.asset(
                              'assets/icons/money.svg',
                              width: SizeConfig.blockSizeVertical * 4,
                            ),
                            onPressed: () {}),
                      ),
                      FutureBuilder<int>(
                          future: DatabaseProvider.dbProvider.fetchCoin(),
                          builder: (BuildContext context,
                              AsyncSnapshot<int> snapshot) {
                            if (snapshot.hasData) {
                              logoData.totalCoin = snapshot.data;
                              return Text(
                                logoData.totalCoin.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: SizeConfig.blockSizeVertical * 3,
                                ),
                              );
                            } else {
                              return CircularProgressIndicator();
                            }
                          }),
                      // IconButton(
                      //     // TODO: loi
                      //     enableFeedback: loading ? true : logoData.isSound,
                      //     icon: SvgPicture.asset(
                      //       'assets/icons/addMoney.svg',
                      //       width: SizeConfig.blockSizeVertical * 4,
                      //     ),
                      //     onPressed: () {
                      //       Navigator.push(
                      //           context,
                      //           MaterialPageRoute(
                      //               builder: (context) => PurchaseScreen()));
                      //     }),
                    ],
                  ),
                ),
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
                  Spacer(),
                  Container(
                    height: SizeConfig.blockSizeVertical * 15,
                    width: SizeConfig.screenWidth,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SvgPicture.asset(
                          "assets/images/logoQuiz.svg",
                          width: SizeConfig.blockSizeHorizontal * 80,
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Container(
                    width: SizeConfig.blockSizeHorizontal * 60,
                    height: SizeConfig.blockSizeVertical * 8,
                    child: ElevatedButton(
                      onPressed: () {
                        if (logoData.soundCheck == 1) {
                          Audio().playNormalClick();
                        }
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GameHome()));
                      },
                      child: Text(
                        'Start',
                        style: TextStyle(
                          color: Color(0xFFCBD5E1),
                          fontWeight: FontWeight.w600,
                          fontSize: SizeConfig.blockSizeVertical * 3,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          enableFeedback: logoData.isSound,
                          primary: Color(0xFF1A1742),
                          elevation: SizeConfig.blockSizeVertical * 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.horizontal(
                                  left: Radius.circular(60),
                                  right: Radius.circular(60)))),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 5,
                  ),
                  Container(
                    width: SizeConfig.blockSizeHorizontal * 60,
                    height: SizeConfig.blockSizeVertical * 8,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HowToPlayScreen()));
                      },
                      child: Text(
                        'How to play',
                        style: TextStyle(
                          color: Color(0xFFCBD5E1),
                          fontWeight: FontWeight.w600,
                          fontSize: SizeConfig.blockSizeVertical * 3,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          enableFeedback: logoData.isSound,
                          primary: Color(0xFF1A1742),
                          elevation: SizeConfig.blockSizeVertical * 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.horizontal(
                                  left: Radius.circular(60),
                                  right: Radius.circular(60)))),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 5,
                  ),
                  Container(
                    width: SizeConfig.blockSizeHorizontal * 60,
                    height: SizeConfig.blockSizeVertical * 8,
                    child: ElevatedButton(
                      onPressed: () {
                        Future.delayed(const Duration(milliseconds: 1000), () {
                          SystemChannels.platform
                              .invokeMethod('SystemNavigator.pop');
                        });
                      },
                      child: Text(
                        'Quit',
                        style: TextStyle(
                          color: Color(0xFFCBD5E1),
                          fontWeight: FontWeight.w600,
                          fontSize: SizeConfig.blockSizeVertical * 3,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          enableFeedback: logoData.isSound,
                          primary: Color(0xFF1A1742),
                          elevation: SizeConfig.blockSizeVertical * 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.horizontal(
                                  left: Radius.circular(60),
                                  right: Radius.circular(60)))),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 5,
                  ),
                  Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
