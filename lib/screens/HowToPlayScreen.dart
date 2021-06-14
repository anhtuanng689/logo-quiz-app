import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logo_quiz/db/DatabaseProvider.dart';
import 'package:logo_quiz/provider/LogoProvider.dart';
import 'package:logo_quiz/utils/SizeConfig.dart';
import 'package:provider/provider.dart';

class HowToPlayScreen extends StatefulWidget {
  const HowToPlayScreen({Key key}) : super(key: key);

  @override
  _HowToPlayScreenState createState() => _HowToPlayScreenState();
}

class _HowToPlayScreenState extends State<HowToPlayScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final logoData = Provider.of<LogoProvider>(context, listen: false);
    print('${logoData.totalCoin} at first');
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
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.blockSizeHorizontal * 5,
                  vertical: SizeConfig.blockSizeVertical),
              child: Column(
                children: [
                  Container(
                    height: SizeConfig.blockSizeVertical * 7,
                    width: SizeConfig.screenWidth,
                    child: Center(
                      child: Text(
                        "How to play",
                        style: TextStyle(
                          fontSize: SizeConfig.blockSizeVertical * 3,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: SizeConfig.blockSizeVertical * 8,
                    width: SizeConfig.screenWidth,
                    child: Text(
                      "Find out the names of brands based on logos that are missing or hidden keywords",
                      style: TextStyle(
                        fontSize: SizeConfig.blockSizeVertical * 2.2,
                        color: Colors.white60,
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 2,
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical,
                  ),
                  Container(
                    width: SizeConfig.screenWidth,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: SizeConfig.blockSizeVertical * 7,
                              width: SizeConfig.blockSizeHorizontal * 13,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Color(0xFF1A1742),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                              child: ClipRRect(
                                child: SvgPicture.asset(
                                  "assets/icons/hint.svg",
                                  width: SizeConfig.blockSizeVertical * 4.5,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Hint",
                              style: TextStyle(
                                fontSize: SizeConfig.blockSizeVertical * 3,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFFF006d),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical,
                        ),
                        Container(
                          height: SizeConfig.blockSizeVertical * 4,
                          child: Row(
                            children: [
                              Icon(
                                Icons.arrow_right,
                                size: 25,
                                color: Colors.white60,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Text(
                                  'Helps you win the game easily',
                                  style: TextStyle(
                                    fontSize:
                                        SizeConfig.blockSizeVertical * 2.2,
                                    color: Colors.white60,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: SizeConfig.blockSizeVertical * 10,
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/question.svg',
                                width: SizeConfig.blockSizeVertical * 5,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: 'Random Letter',
                                        style: TextStyle(
                                          fontSize:
                                              SizeConfig.blockSizeVertical *
                                                  2.6,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            ' - Open random letter in the answer box',
                                        style: TextStyle(
                                          fontSize:
                                              SizeConfig.blockSizeVertical *
                                                  2.2,
                                          color: Colors.white60,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: SizeConfig.blockSizeVertical * 10,
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/idea.svg',
                                width: SizeConfig.blockSizeVertical * 5,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: 'Show Letter',
                                        style: TextStyle(
                                          fontSize:
                                              SizeConfig.blockSizeVertical *
                                                  2.6,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            ' - Choose any letter to open in the answer box',
                                        style: TextStyle(
                                          fontSize:
                                              SizeConfig.blockSizeVertical *
                                                  2.2,
                                          color: Colors.white60,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: SizeConfig.blockSizeVertical * 10,
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/star.svg',
                                width: SizeConfig.blockSizeVertical * 5,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: 'Show Answer',
                                        style: TextStyle(
                                          fontSize:
                                              SizeConfig.blockSizeVertical *
                                                  2.6,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' - Show the answer to logo quiz',
                                        style: TextStyle(
                                          fontSize:
                                              SizeConfig.blockSizeVertical *
                                                  2.2,
                                          color: Colors.white60,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: SizeConfig.blockSizeVertical,
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.grey,
                          thickness: 2,
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: SizeConfig.blockSizeVertical * 7,
                              width: SizeConfig.blockSizeHorizontal * 13,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Color(0xFF1A1742),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                              child: ClipRRect(
                                child: SvgPicture.asset(
                                  "assets/icons/trash.svg",
                                  width: SizeConfig.blockSizeVertical * 4.5,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Remove",
                              style: TextStyle(
                                fontSize: SizeConfig.blockSizeVertical * 3,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFFF006d),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical,
                        ),
                        Container(
                          height: SizeConfig.blockSizeVertical * 4,
                          child: Row(
                            children: [
                              Icon(
                                Icons.arrow_right,
                                size: 25,
                                color: Colors.white60,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Text(
                                  'Removes all extra letters',
                                  style: TextStyle(
                                    fontSize:
                                        SizeConfig.blockSizeVertical * 2.2,
                                    color: Colors.white60,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
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
