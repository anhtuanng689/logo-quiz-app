import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logo_quiz/db/DatabaseProvider.dart';
import 'package:logo_quiz/models/Logo.dart';
import 'package:logo_quiz/provider/LogoProvider.dart';
import 'package:logo_quiz/utils/SizeConfig.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logo_quiz/widgets/LogoCell.dart';
import 'package:provider/provider.dart';

import 'GameHome.dart';
import 'PurchaseScreen.dart';

class LogoGridScreen extends StatefulWidget {
  final int themeId;

  const LogoGridScreen({Key key, this.themeId}) : super(key: key);
  @override
  _LogoGridScreenState createState() => _LogoGridScreenState();
}

class _LogoGridScreenState extends State<LogoGridScreen> {
  bool isFilter = false;
  // List<Logo> listLogo = [];

  // fetchListLogo() async {
  //   listLogo =
  //       await DatabaseProvider.dbProvider.getLogoGridPerTheme(widget.themeId);
  // }

  @override
  void initState() {
    super.initState();
    // fetchListLogo();
  }

  void moveToLastScreen() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => GameHome()));
  }

  @override
  Widget build(BuildContext context) {
    // print("abc: $listLogo");
    final logoData = Provider.of<LogoProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(SizeConfig.screenHeight * 0.15),
          child: WillPopScope(
            onWillPop: () async {
              moveToLastScreen();
              return true;
            },
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
                                builder: (context) => GameHome()));
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
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.blockSizeHorizontal * 4),
                  height: SizeConfig.blockSizeVertical * 10,
                  width: SizeConfig.screenWidth,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: SizeConfig.blockSizeVertical * 1.5,
                            horizontal: SizeConfig.blockSizeHorizontal * 3),
                        decoration: BoxDecoration(
                          color: Color(0xFF14143a),
                          borderRadius: BorderRadius.all(Radius.circular(60.0)),
                        ),
                        child: Text(
                          '${logoData.categoryList[widget.themeId - 1].count}/${logoData.categoryList[widget.themeId - 1].all}',
                          style: TextStyle(
                              color: Color(0xFFCBD5E1),
                              fontWeight: FontWeight.bold,
                              fontSize: SizeConfig.blockSizeVertical * 3),
                        ),
                      ),
                      Spacer(),
                      isFilter
                          ? Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: SizeConfig.blockSizeVertical * 0.25,
                                  horizontal:
                                      SizeConfig.blockSizeHorizontal * 0.75),
                              decoration: BoxDecoration(
                                color: Color(0xFF1c1a49),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                              ),
                              child: IconButton(
                                  enableFeedback: logoData.isSound,
                                  icon: SvgPicture.asset(
                                    'assets/images/onFilter.svg',
                                    color: Color(0xFF154e81),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isFilter = !isFilter;
                                    });
                                  }),
                            )
                          : Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: SizeConfig.blockSizeVertical * 0.25,
                                  horizontal:
                                      SizeConfig.blockSizeHorizontal * 0.75),
                              decoration: BoxDecoration(
                                color: Color(0xFF1F1D4A),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                              ),
                              child: IconButton(
                                  enableFeedback: logoData.isSound,
                                  icon: SvgPicture.asset(
                                    'assets/images/onFilter.svg',
                                    color: Color(0xFF00c2FF),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isFilter = !isFilter;
                                    });
                                  }),
                            ),
                      // Spacer(),
                      // SizedBox(
                      //   width: SizeConfig.blockSizeHorizontal * 11,
                      // ),
                    ],
                  ),
                ),
                isFilter
                    ? Expanded(
                        child: FutureBuilder<List<Logo>>(
                          future: DatabaseProvider.dbProvider
                              .getLogoGridPerThemeWithFilter(widget.themeId),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<Logo>> snapshot) {
                            // print(themeId);
                            // print(snapshot.connectionState);
                            print(snapshot.data);
                            if (snapshot.hasData) {
                              // print(listLogo);
                              return GridView.count(
                                scrollDirection: Axis.vertical,
                                crossAxisCount: 3,
                                padding: EdgeInsets.all(20),
                                mainAxisSpacing:
                                    SizeConfig.blockSizeHorizontal * 5,
                                crossAxisSpacing:
                                    SizeConfig.blockSizeVertical * 3,
                                children: List.generate(snapshot.data.length,
                                    (index) {
                                  Logo logo = snapshot.data[index];
                                  return LogoCell(
                                    id: logo.id,
                                    themeId: logo.catId,
                                    imgURL: "assets/drawable/${logo.img}.webp",
                                    isWin: logo.isWin,
                                    answer: logo.answer,
                                    sequence: logo.sequence,
                                    logo: logo,
                                    listLogo: snapshot.data,
                                  );
                                }),
                              );
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        ),
                      )
                    : Expanded(
                        child: FutureBuilder<List<Logo>>(
                          future: DatabaseProvider.dbProvider
                              .getLogoGridPerTheme(widget.themeId),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<Logo>> snapshot) {
                            // print(themeId);
                            // print(snapshot.connectionState);
                            // print(snapshot.data);
                            if (snapshot.hasData) {
                              return GridView.count(
                                scrollDirection: Axis.vertical,
                                crossAxisCount: 3,
                                padding: EdgeInsets.all(20),
                                mainAxisSpacing:
                                    SizeConfig.blockSizeHorizontal * 5,
                                crossAxisSpacing:
                                    SizeConfig.blockSizeVertical * 3,
                                children: List.generate(snapshot.data.length,
                                    (index) {
                                  Logo logo = snapshot.data[index];
                                  return LogoCell(
                                    id: logo.id,
                                    themeId: logo.catId,
                                    imgURL: "assets/drawable/${logo.img}.webp",
                                    isWin: logo.isWin,
                                    answer: logo.answer,
                                    sequence: logo.sequence,
                                    logo: logo,
                                    listLogo: snapshot.data,
                                  );
                                }),
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
            ),
          ],
        ),
      ),
    );
  }
}
