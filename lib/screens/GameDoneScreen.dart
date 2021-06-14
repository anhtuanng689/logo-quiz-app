import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logo_quiz/db/DatabaseProvider.dart';
import 'package:logo_quiz/models/Logo.dart';
import 'package:logo_quiz/provider/LogoProvider.dart';
import 'package:logo_quiz/utils/SizeConfig.dart';
import 'package:logo_quiz/widgets/QuestionCell.dart';
import 'package:provider/provider.dart';

class GameDoneScreen extends StatefulWidget {
  final int id;
  final int themeId;
  final String answer;

  const GameDoneScreen({Key key, this.id, this.themeId, this.answer})
      : super(key: key);

  @override
  _GameDoneScreenState createState() => _GameDoneScreenState();
}

class _GameDoneScreenState extends State<GameDoneScreen> {
  List<String> listAnswer = [];

  // Random _random = Random();
  //
  // List<String> listCompliment = [
  //   'WELL DONE!',
  //   'YOU DID A GOOD JOB!',
  //   'FANTASTIC!',
  //   'YOU' 'RE DOING GREAT!',
  //   'NICE GOING!',
  //   'KEEP UP THE GOOD WORK!',
  //   'YOU ARE EXCELLENT!',
  //   'KEEP ON TRYING!',
  //   'GOOD THINKING!'
  // ];
  // String randomListCompliment(List list) {
  //   return list[_random.nextInt(list.length)];
  // }

  void splitString(String answer, List<String> list) {
    for (var element in answer.split("")) {
      list.add(element.toUpperCase());
    }
  }

  @override
  void initState() {
    super.initState();
    splitString(widget.answer, listAnswer);
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
                      Navigator.pop(context);
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
                      // IconButton(
                      //     enableFeedback: logoData.isSound,
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
            Column(
              children: [
                Container(
                  height: SizeConfig.screenHeight * 0.83,
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
                                child: Hero(
                                  tag: "${widget.id}",
                                  child: ClipRRect(
                                    // borderRadius:
                                    //     BorderRadius.all(Radius.circular(30)),
                                    child: Image.asset(
                                      "assets/drawable/ori_${logo.img}.webp",
                                      scale: 0.9,
                                    ),
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
                                          character: listAnswer[i],
                                        )
                                    ]),
                              ),
                            ),
                            Spacer(),
                            Container(
                              height: SizeConfig.blockSizeVertical * 7,
                              width: SizeConfig.screenWidth,
                              child: Center(
                                child: Text(
                                  'YOU ARE EXCELLENT!',
                                  style: TextStyle(
                                      fontSize:
                                          SizeConfig.blockSizeHorizontal * 6,
                                      color: Color(0xFFF9C94D),
                                      fontWeight: FontWeight.w600),
                                ),
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
                                            SizeConfig.blockSizeVertical * 2.45,
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
              ],
            )
          ],
        ),
      ),
    );
  }
}
