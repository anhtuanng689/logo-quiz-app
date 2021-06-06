import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logo_quiz/db/DatabaseProvider.dart';
import 'package:logo_quiz/models/Logo.dart';
import 'package:logo_quiz/provider/LogoProvider.dart';
import 'package:logo_quiz/screens/LogoGridScreen.dart';
import 'package:logo_quiz/utils/Audio.dart';
import 'package:logo_quiz/utils/SizeConfig.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logo_quiz/screens/GameScreen.dart';
import 'package:logo_quiz/widgets/QuestionCell.dart';
import 'package:provider/provider.dart';

import 'PurchaseScreen.dart';

class ResultScreen extends StatefulWidget {
  final int id;
  final int themeId;
  final List listAnswer;
  final int sequence;
  final List<Logo> listLogo;
  const ResultScreen(
      {Key key,
      this.id,
      this.listAnswer,
      this.themeId,
      this.sequence,
      this.listLogo})
      : super(key: key);
  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  List<Logo> logoListEachTheme = [];
  int temp;

  fetchLogoData(int themeId) async {
    // logoListEachTheme = await Provider.of<LogoProvider>(context, listen: false)
    //     .fetchLogoPerTheme(themeId);
    logoListEachTheme =
        await DatabaseProvider.dbProvider.getLogoGridPerTheme(themeId);
  }

  @override
  void initState() {
    super.initState();
    fetchLogoData(widget.themeId);
    if (Provider.of<LogoProvider>(context, listen: false).soundCheck == 1) {
      Audio().playWin();
    }
  }

  @override
  Widget build(BuildContext context) {
    final logoData = Provider.of<LogoProvider>(context, listen: false);
    print('${logoData.totalCoin} result');
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
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LogoGridScreen(
                                    themeId: widget.themeId,
                                  )));
                    }),
                Container(
                  child: Row(
                    children: [
                      IconButton(
                          enableFeedback: logoData.isSound,
                          icon: SvgPicture.asset(
                            'assets/icons/money.svg',
                            width: SizeConfig.blockSizeVertical * 4,
                          ),
                          onPressed: () {}),
                      Text(
                        logoData.totalCoin.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: SizeConfig.blockSizeVertical * 3,
                        ),
                      ),
                      IconButton(
                          enableFeedback: logoData.isSound,
                          icon: SvgPicture.asset(
                            'assets/icons/addMoney.svg',
                            width: SizeConfig.blockSizeVertical * 4,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PurchaseScreen()));
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: WillPopScope(
          onWillPop: () async {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => LogoGridScreen(
                          themeId: widget.themeId,
                        )));
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
              Column(
                children: [
                  Spacer(),
                  Container(
                    height: SizeConfig.blockSizeVertical * 5,
                    width: SizeConfig.screenWidth,
                    child: Center(
                      child: Text(
                        'Congratulation!',
                        style: TextStyle(
                            fontSize: SizeConfig.blockSizeVertical * 4,
                            color: Color(0xFFF9C94D),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Spacer(),
                  Container(
                    height: SizeConfig.screenHeight * 0.62,
                    width: SizeConfig.screenWidth,
                    child: FutureBuilder<Logo>(
                      future: DatabaseProvider.dbProvider.getImage(widget.id),
                      builder:
                          (BuildContext context, AsyncSnapshot<Logo> snapshot) {
                        Logo logo = snapshot.data;
                        if (snapshot.hasData) {
                          return Column(
                            children: [
                              Spacer(),
                              Center(
                                child: Container(
                                  width: SizeConfig.screenWidth * 0.4,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                  ),
                                  child: ClipRRect(
                                    // borderRadius:
                                    //     BorderRadius.all(Radius.circular(30)),
                                    child: Image.asset(
                                      "assets/drawable/ori_${logo.img}.webp",
                                      scale: 0.875,
                                    ),
                                  ),
                                ),
                              ),
                              Spacer(),
                              Center(
                                child: Container(
                                  width: SizeConfig.screenWidth,
                                  child: Wrap(
                                      alignment: WrapAlignment.center,
                                      children: [
                                        for (int i = 0;
                                            i < logo.answer.length;
                                            i++)
                                          QuestionCell(
                                            colorHexBackground: 0xFF1A1742,
                                            colorHexText: 0xFFffffff,
                                            character: widget.listAnswer[i],
                                          )
                                      ]),
                                ),
                              ),
                              Spacer(),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                width: SizeConfig.screenWidth,
                                child: Wrap(
                                    alignment: WrapAlignment.center,
                                    children: [
                                      Text(
                                        logo.wikipedia,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize:
                                              SizeConfig.blockSizeVertical *
                                                  2.25,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ]),
                              ),
                              Spacer(),
                            ],
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ),
                  Spacer(),
                  Container(
                    height: SizeConfig.blockSizeVertical * 5,
                    width: SizeConfig.screenWidth,
                    child: Center(
                      child: Text(
                        'Coin Gained ${logoData.randomScore}!',
                        style: TextStyle(
                            fontSize: SizeConfig.blockSizeVertical * 3,
                            color: Color(0xFFEE0056),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Spacer(),
                  Container(
                      height: SizeConfig.blockSizeVertical * 7,
                      width: SizeConfig.screenWidth,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                int tmp;
                                Logo logoTemp = Logo();
                                bool isOK = false;
                                // print(widget.sequence);
                                for (tmp = widget.sequence - 1;
                                    tmp > 0;
                                    tmp--) {
                                  if (logoListEachTheme[tmp - 1].isWin == 0) {
                                    logoTemp = logoListEachTheme[tmp - 1];
                                    temp = logoListEachTheme[tmp - 1].id;
                                    isOK = true;
                                    break;
                                  }
                                }
                                if (isOK) {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => GameScreen(
                                                logo: logoTemp,
                                                id: temp,
                                                themeId: widget.themeId,
                                                sequence: tmp,
                                                listLogo: widget.listLogo,
                                              )));
                                }
                              });
                            },
                            child: Icon(
                              Icons.keyboard_arrow_left_outlined,
                              color: Colors.white,
                              size: SizeConfig.blockSizeHorizontal * 7,
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                int tmp;
                                Logo logoTemp = Logo();
                                bool isOK = false;
                                // print(widget.sequence);
                                for (tmp = widget.sequence + 1;
                                    tmp <= logoListEachTheme.length;
                                    tmp++) {
                                  if (logoListEachTheme[tmp - 1].isWin == 0) {
                                    logoTemp = logoListEachTheme[tmp - 1];
                                    temp = logoListEachTheme[tmp - 1].id;
                                    isOK = true;
                                    break;
                                  }
                                }
                                if (isOK) {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => GameScreen(
                                                logo: logoTemp,
                                                id: temp,
                                                themeId: widget.themeId,
                                                sequence: tmp,
                                                listLogo: widget.listLogo,
                                              )));
                                }
                              });
                            },
                            child: Icon(
                              Icons.keyboard_arrow_right_outlined,
                              color: Colors.white,
                              size: SizeConfig.blockSizeHorizontal * 7,
                            ),
                          ),
                        ],
                      )),
                  Spacer(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
