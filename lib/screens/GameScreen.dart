import 'dart:math';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logo_quiz/db/DatabaseProvider.dart';
import 'package:logo_quiz/models/Logo.dart';
import 'package:logo_quiz/provider/LogoProvider.dart';
import 'package:logo_quiz/screens/LogoGridScreen.dart';
import 'package:logo_quiz/utils/SizeConfig.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logo_quiz/widgets/TextCell.dart';
import 'package:logo_quiz/widgets/QuestionCell.dart';
import 'package:logo_quiz/screens/ResultScreen.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';
import 'package:logo_quiz/models/Categories.dart';
import 'package:logo_quiz/utils/Audio.dart';
import 'package:logo_quiz/widgets/HintDialog.dart';
import 'package:logo_quiz/widgets/CoinError.dart';
import 'package:logo_quiz/widgets/GameAlertDialog.dart';
import 'package:logo_quiz/widgets/RemoveError.dart';
import '../widgets/GameAlertDialog.dart';
import 'PurchaseScreen.dart';
import 'package:logo_quiz/widgets/RemoveDialog.dart';

class GameScreen extends StatefulWidget {
  // id de truyen vao anh
  final int id;
  final int themeId;
  final int sequence;
  final Logo logo;
  final List<Logo> listLogo;

  const GameScreen(
      {Key key, this.id, this.themeId, this.sequence, this.logo, this.listLogo})
      : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<String> listRandom = [];

  // chi dung de chuan hoa String
  List<String> listAnswer = [];

  // list o duoi, luon luon dung
  List<String> listQuestion = [];

  // chi dung de chuan hoa String
  List<String> listInput = [];

  // list dung de an hien phan tu
  List<bool> listVisible = [
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
  ];

  List<String> tempListAnswer = [];

  List<bool> hintedListAnswer = [];
  List<bool> checkDuplicateAnswer = [];

  Categories category = Categories();
  List<Logo> logoListEachTheme = [];

  static const chars = "abcdefghijklmnopqrstuvwxyz";
  int temp;
  int choice = 0;
  int removeChoice = 0;
  bool shouldPop = false;
  int exit = 0;
  int leftBack = 0;
  int rightBack = 0;
  int loadingQuestion = 0;
  bool loadingAnswer = true;
  bool isWin = false;
  bool isHintMode = false;
  bool isUsingHint = false;
  bool isUsingRemove = false;

  bool isRandom = false;

  Function equal = const ListEquality().equals;

  String generateRandomString(int len) {
    var r = Random();
    return List.generate(len, (index) => chars[r.nextInt(chars.length)]).join();
  }

  void splitString(String answer, List<String> list) {
    for (var element in answer.split("")) {
      list.add(element.toUpperCase());
    }
  }

  void removeAllRandomLetter(String answer, List<String> list) {
    if (isUsingHint) {
      showDialog(
          context: context,
          builder: (context) {
            return RemoveError();
          });
    } else if (Provider.of<LogoProvider>(context, listen: false).totalCoin <
        300) {
      showDialog(
          context: context,
          builder: (context) {
            return CoinError();
          });
    } else {
      if (!isUsingRemove) {
        isUsingRemove = true;
        list.clear();
        listAnswer.clear();
        listInput.clear();
        listVisible.clear();
        for (var element in answer.split("")) {
          list.add(element.toUpperCase());
          listAnswer.add(element.toUpperCase());
          listInput.add("_");
          listVisible.add(true);
        }
        list.shuffle();
        Provider.of<LogoProvider>(context, listen: false).minusRemoveLetter();
      }
    }
  }

  void randomString(int len) {
    if (!isRandom) {
      Provider.of<LogoProvider>(context, listen: false).refreshListRandom();
      var temp = generateRandomString(len);
      print(temp.split(""));
      for (var element in temp.split("")) {
        Provider.of<LogoProvider>(context, listen: false)
            .listRandom
            .add(element.toUpperCase());
      }

      listQuestion
          .addAll(Provider.of<LogoProvider>(context, listen: false).listRandom);
      listQuestion.shuffle();
      isRandom = true;
    }
  }

  fetchLogoData(int themeId) async {
    logoListEachTheme =
        await DatabaseProvider.dbProvider.getLogoGridPerTheme(themeId);
  }

  void fetchCateGory(int id) async {
    category = await DatabaseProvider.dbProvider.getCategory(id);
  }

  Future<bool> willPop(BuildContext context) async {
    exit = await showDialog(
        context: context,
        builder: (context) {
          return GameAlertDialog();
        });

    if (exit == 1) {
      shouldPop = true;
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => LogoGridScreen(
                    themeId: widget.themeId,
                  )));
    }
    return shouldPop;
  }

  Future<int> showLeftBackDialog(BuildContext context) async {
    leftBack = await showDialog(
        context: context,
        builder: (context) {
          return GameAlertDialog();
        });
    return leftBack;
  }

  void showRemoveDialog(BuildContext context) async {
    removeChoice = await showDialog(
        context: context,
        builder: (context) {
          return RemoveDialog();
        });

    // print(removeChoice);

    if (removeChoice == 1) {
      removeAllRandomLetter(widget.logo.answer, listQuestion);
      setState(() {});
    }

    if (removeChoice == 2) {}
  }

  void showHintDialog(BuildContext context) async {
    choice = await showDialog(
        context: context,
        builder: (context) {
          return HintDialog();
        });

    // print(choice);

    if (choice == 1) {
      hintLetter();
    }

    if (choice == 2) {
      randomLetter(widget.logo);
    }

    if (choice == 3) {
      showAnswer(widget.logo);
    }
  }

  void hintLetter() {
    if (Provider.of<LogoProvider>(context, listen: false).totalCoin < 100) {
      showDialog(
          context: context,
          builder: (context) {
            return CoinError();
          });
    } else {
      isHintMode = true;
      isUsingHint = true;
      // print(isHintMode);
      Provider.of<LogoProvider>(context, listen: false).minusShowLetter();
      setState(() {});
    }
  }

  void randomLetter(Logo logo) {
    if (Provider.of<LogoProvider>(context, listen: false).totalCoin < 50) {
      showDialog(
          context: context,
          builder: (context) {
            return CoinError();
          });
    } else {
      List<int> listTemp = [];
      if (listInput.contains("_")) {
        for (int i = 0; i < tempListAnswer.length; i++) {
          if (listInput[i] == "_") {
            listTemp.add(i);
          }
        }
        // print("listTemp: $listTemp");
        Random random = Random();
        int rand = random.nextInt(listTemp.length);
        // print("rand: $rand");
        listAnswer[listTemp[rand]] = tempListAnswer[listTemp[rand]];
        // print(
        //     "tempListAnswer[listTemp[rand]]: ${tempListAnswer[listTemp[rand]]}");
        listInput[listTemp[rand]] = tempListAnswer[listTemp[rand]];
        hintedListAnswer[listTemp[rand]] = true;
        // for (int i = 0; i < listVisible.length; i++) {
        //   if (listVisible[i] &&
        //       i == listQuestion.indexOf(tempListAnswer[listTemp[rand]])) {
        //     listVisible[i] = false;
        //     break;
        //   }
        // }

        for (int i = 0; i < listVisible.length; i++) {
          if (listVisible[i] &&
              listQuestion[i] == tempListAnswer[listTemp[rand]]) {
            listVisible[i] = false;
            break;
          }
        }
        // print("listVisible[listTemp[rand]]: ${listVisible[listTemp[rand]]}");
        Provider.of<LogoProvider>(context, listen: false).minusRandomLetter();
        isUsingHint = true;
        setState(() {
          if (equal(listAnswer, listInput)) {
            isWin = true;
            if (Provider.of<LogoProvider>(context, listen: false).soundCheck ==
                1) {
              Audio().playCorrect();
            }

            Provider.of<LogoProvider>(context, listen: false).getRewards();

            Provider.of<LogoProvider>(context, listen: false)
                .updateWinningStatus(logo, category, logo.id, logo.catId);

            waitTimeForResult();
          }
        });
      }

      // for (int i = 0; i < tempListAnswer.length; i++) {
      //   if (listInput[i] == "_") {
      //     listAnswer[i] = tempListAnswer[i];
      //     listInput[i] = tempListAnswer[i];
      //     hintedListAnswer[i] = true;
      //     Provider.of<LogoProvider>(context, listen: false).minusRandomLetter();
      //     break;
      //   }
      // }
      // setState(() {
      //   if (equal(listAnswer, listInput)) {
      //     isWin = true;
      //
      //     Provider.of<LogoProvider>(context, listen: false).getRewards();
      //
      //     Provider.of<LogoProvider>(context, listen: false)
      //         .updateWinningStatus(logo, category, logo.id, logo.catId);
      //
      //     waitTimeForResult();
      //   }
      // });

    }
  }

  void showAnswer(Logo logo) {
    if (Provider.of<LogoProvider>(context, listen: false).totalCoin < 400) {
      showDialog(
          context: context,
          builder: (context) {
            return CoinError();
          });
    } else {
      for (int i = 0; i < listAnswer.length; i++) {
        listAnswer[i] = tempListAnswer[i];
        listInput[i] = tempListAnswer[i];
      }

      for (int i = 0; i < listVisible.length; i++) {
        listVisible[i] = false;
      }

      isWin = true;
      if (Provider.of<LogoProvider>(context, listen: false).soundCheck == 1) {
        Audio().playCorrect();
      }
      Provider.of<LogoProvider>(context, listen: false).minusShowAnswer();
      Provider.of<LogoProvider>(context, listen: false).getRewards();
      Provider.of<LogoProvider>(context, listen: false)
          .updateWinningStatus(logo, category, widget.id, widget.themeId);
      setState(() {
        waitTimeForResult();
      });
    }
  }

  Widget buildWidget(logoData, i) {
    bool eq = equal(listAnswer, listInput);
    bool contain = listInput.contains('_');
    if (!eq && !contain) {
      if (hintedListAnswer[i]) {
        return IgnorePointer(
          ignoring: true,
          child: QuestionCell(
            colorHexBackground: 0xFF4caf50,
            colorHexText: 0xFFffffff,
            character: listInput[i],
          ),
        );
      } else {
        if (isHintMode)
          return QuestionCell(
            colorHexBackground: 0xFFd5bb4d,
            colorHexText: 0xFFffffff,
            character: listInput[i],
          );
        return QuestionCell(
          colorHexBackground: 0xFFf44336,
          colorHexText: 0xFF191919,
          character: listInput[i],
        );
      }
    } else if (eq) {
      return QuestionCell(
        colorHexBackground: 0xFF4caf50,
        colorHexText: 0xFFffffff,
        character: listInput[i],
      );
    } else {
      if (hintedListAnswer[i]) {
        return IgnorePointer(
          ignoring: true,
          child: QuestionCell(
            colorHexBackground: 0xFF4caf50,
            colorHexText: 0xFFffffff,
            character: listInput[i],
          ),
        );
      } else if (isHintMode) {
        return QuestionCell(
          colorHexBackground: 0xFFd5bb4d,
          colorHexText: 0xFFffffff,
          character: listInput[i],
        );
      } else {
        return QuestionCell(
          colorHexBackground: 0xFF1A1742,
          colorHexText: 0xFFffffff,
          character: listInput[i],
        );
      }
    }
  }

  Future<void> waitTimeForResult() {
    // print('timing');
    return Future.delayed(
      Duration(seconds: 4),
      () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => ResultScreen(
                    id: widget.id,
                    listAnswer: listAnswer,
                    themeId: widget.themeId,
                    sequence: widget.sequence,
                  ))),
    );
  }

  @override
  void initState() {
    super.initState();
    fetchCateGory(widget.themeId);
    fetchLogoData(widget.themeId);
  }

  @override
  Widget build(BuildContext context) {
    final logoData = Provider.of<LogoProvider>(context, listen: false);
    // print("_____________________");
    // print('id ${widget.id}');
    // print('sq ${widget.sequence}');
    // print('catid ${widget.themeId}');
    // print('answer ${widget.logo.answer}');
    return AbsorbPointer(
      absorbing: isWin,
      child: SafeArea(
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
                  Row(
                    children: [
                      IconButton(
                          enableFeedback: logoData.isSound,
                          padding: EdgeInsets.zero,
                          icon: SvgPicture.asset(
                            'assets/icons/back.svg',
                            height: SizeConfig.blockSizeVertical * 6,
                          ),
                          onPressed: () {
                            willPop(context);
                          }),
                      // SizedBox(
                      //   width: SizeConfig.blockSizeHorizontal * 5,
                      // ),
                      // Container(
                      //   child: Row(
                      //     children: [
                      //       SvgPicture.asset(
                      //         'assets/icons/alarm.svg',
                      //         width: SizeConfig.blockSizeVertical * 4,
                      //       ),
                      //       SizedBox(
                      //         width: SizeConfig.blockSizeHorizontal,
                      //       ),
                      //       Text(
                      //         '03:28',
                      //         style: TextStyle(
                      //           color: Colors.white,
                      //           fontSize: SizeConfig.blockSizeVertical * 3,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // )
                    ],
                  ),
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
                        isWin
                            ? Pulse(
                                duration: Duration(seconds: 1),
                                child: Text(
                                  logoData.totalCoin.toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: SizeConfig.blockSizeVertical * 3,
                                  ),
                                ),
                              )
                            : Text(
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
          body: WillPopScope(
            onWillPop: () async => willPop(context),
            child: Container(
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight * 1.6,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/homescreen.png"),
                ),
              ),
              child: Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        height: SizeConfig.blockSizeVertical * 33,
                        width: SizeConfig.screenWidth,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                int foo = await showLeftBackDialog(context);
                                if (foo == 1) {
                                  setState(() {
                                    int tmp;
                                    Logo logoTemp = Logo();
                                    bool isOK = false;
                                    // print(widget.sequence);
                                    for (tmp = widget.sequence - 1;
                                        tmp > 0;
                                        tmp--) {
                                      if (logoListEachTheme[tmp - 1].isWin ==
                                          0) {
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
                                }
                              },
                              child: Icon(
                                Icons.keyboard_arrow_left_outlined,
                                color: Colors.white,
                                size: SizeConfig.blockSizeHorizontal * 10,
                              ),
                            ),
                            FutureBuilder<Logo>(
                              future: DatabaseProvider.dbProvider
                                  .getImage(widget.id),
                              builder: (BuildContext context,
                                  AsyncSnapshot<Logo> snapshot) {
                                Logo logo = snapshot.data;
                                if (snapshot.hasData) {
                                  return Container(
                                    height: SizeConfig.screenHeight * 0.3,
                                    width: SizeConfig.screenWidth * 0.6,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(30)),
                                    ),
                                    child: Hero(
                                      tag: "${widget.id}",
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30)),
                                        child: Image.asset(
                                          "assets/drawable/${logo.img}.webp",
                                          scale: 0.75,
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                            ),
                            GestureDetector(
                              onTap: () async {
                                int foo = await showLeftBackDialog(context);
                                if (foo == 1) {
                                  setState(() {
                                    int tmp;
                                    Logo logoTemp = Logo();
                                    bool isOK = false;
                                    // print(widget.sequence);
                                    for (tmp = widget.sequence + 1;
                                        tmp <= logoListEachTheme.length;
                                        tmp++) {
                                      if (logoListEachTheme[tmp - 1].isWin ==
                                          0) {
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
                                }
                              },
                              child: Icon(
                                Icons.keyboard_arrow_right_outlined,
                                color: Colors.white,
                                size: SizeConfig.blockSizeHorizontal * 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 2,
                      ),
                      AbsorbPointer(
                        absorbing: isHintMode,
                        child: Container(
                          height: SizeConfig.blockSizeVertical * 6.5,
                          width: SizeConfig.screenWidth,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showHintDialog(context);
                                },
                                child: Container(
                                  height: SizeConfig.blockSizeVertical * 13,
                                  width: SizeConfig.blockSizeHorizontal * 12,
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
                              ),
                              SizedBox(
                                width: SizeConfig.blockSizeHorizontal * 10,
                              ),
                              Visibility(
                                visible: !isUsingRemove,
                                maintainSize: true,
                                maintainAnimation: true,
                                maintainState: true,
                                child: GestureDetector(
                                  onTap: () {
                                    showRemoveDialog(context);
                                  },
                                  child: Container(
                                    height: SizeConfig.blockSizeVertical * 15,
                                    width: SizeConfig.blockSizeHorizontal * 12,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF1A1742),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                    ),
                                    child: ClipRRect(
                                      child: SvgPicture.asset(
                                        "assets/icons/trash.svg",
                                        width:
                                            SizeConfig.blockSizeVertical * 4.5,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      FutureBuilder<Logo>(
                        future: DatabaseProvider.dbProvider.getImage(widget.id),
                        builder: (BuildContext context,
                            AsyncSnapshot<Logo> snapshot) {
                          // print("game id = ${widget.id}");
                          // print(snapshot.connectionState);
                          // print(snapshot.data);
                          Logo logo = snapshot.data;
                          if (snapshot.hasData) {
                            if (loadingAnswer) {
                              splitString(logo.answer, listAnswer);
                              splitString(logo.answer, tempListAnswer);
                              print(tempListAnswer);
                              for (int i = 0; i < logo.answer.length; i++) {
                                listInput.add('_');
                                hintedListAnswer.add(false);
                                checkDuplicateAnswer.add(false);
                              }
                              loadingAnswer = false;
                            }
                            // print('$listInput and ${listInput.length}');
                            return Container(
                              height: SizeConfig.screenHeight * 0.18,
                              width: SizeConfig.screenWidth,
                              child: Center(
                                child: Wrap(
                                    alignment: WrapAlignment.center,
                                    children: [
                                      for (int i = 0;
                                          i < logo.answer.length;
                                          i++)
                                        GestureDetector(
                                            onTap: () {
                                              print(
                                                  "tempListAnswer: $tempListAnswer");
                                              if (isHintMode) {
                                                if (listInput[i] ==
                                                    listAnswer[i]) {
                                                  listInput[i] =
                                                      tempListAnswer[i];
                                                  // listAnswer[i] =
                                                  //     tempListAnswer[i];
                                                  hintedListAnswer[i] = true;
                                                } else {
                                                  if (listInput[i] != "_") {
                                                    print("if opt");
                                                    for (int j = 0;
                                                        j < listInput.length;
                                                        j++) {
                                                      if (j == i) continue;
                                                      if (!checkDuplicateAnswer[
                                                              j] &&
                                                          !hintedListAnswer[
                                                              j] &&
                                                          listInput[j] ==
                                                              listAnswer[i]) {
                                                        print("if if if");
                                                        // listAnswer[j] = "_";
                                                        checkDuplicateAnswer[
                                                            j] = true;
                                                        listVisible[listQuestion
                                                            .indexOf(listInput[
                                                                i])] = true;
                                                        // for (int k = 0;
                                                        //     k <
                                                        //         listVisible
                                                        //             .length;
                                                        //     k++) {
                                                        //   listVisible[listQuestion
                                                        //           .indexOf(
                                                        //               listAnswer[
                                                        //                   i])] =
                                                        //       false;
                                                        //   break;
                                                        // }

                                                        listInput[j] = "_";

                                                        break;
                                                      } else if (!hintedListAnswer[
                                                              j] &&
                                                          listInput[j] ==
                                                              listAnswer[i]) {
                                                        print("else if");
                                                        print(listInput[j]);
                                                        print(listInput[i]);
                                                        listInput[j] =
                                                            listInput[i];
                                                        print(listInput[j]);
                                                        print(listInput[i]);
                                                        break;
                                                      } else {
                                                        print("else if opt");
                                                        listVisible[listQuestion
                                                            .indexOf(listInput[
                                                                i])] = true;
                                                        break;
                                                      }
                                                    }
                                                  } else {
                                                    print("else opt");
                                                    for (int z = 0;
                                                        z < listVisible.length;
                                                        z++) {
                                                      if (listAnswer[i] ==
                                                              listQuestion[z] &&
                                                          !listVisible[z]) {
                                                        print(listAnswer);
                                                        print(listQuestion);
                                                        print(listVisible);
                                                        listVisible[z] = false;
                                                        print(listVisible);

                                                        print("OK");
                                                        break;
                                                      }
                                                    }
                                                  }
                                                  // print("Oke $i");
                                                  listInput[i] =
                                                      tempListAnswer[i];
                                                  // listAnswer[i] =
                                                  //     tempListAnswer[i];
                                                  hintedListAnswer[i] = true;
                                                  String temp =
                                                      tempListAnswer[i];
                                                  for (int i = 0;
                                                      i < listVisible.length;
                                                      i++) {
                                                    if (listVisible[i] &&
                                                        listQuestion[i] ==
                                                            temp) {
                                                      listVisible[i] = false;
                                                      break;
                                                    }
                                                  }
                                                }
                                                print(listVisible);

                                                print("Oke $listInput");
                                                print("Oke $listAnswer");
                                                isHintMode = false;
                                                setState(() {});
                                                if (equal(
                                                    listAnswer, listInput)) {
                                                  isWin = true;
                                                  if (Provider.of<LogoProvider>(
                                                              context,
                                                              listen: false)
                                                          .soundCheck ==
                                                      1) {
                                                    Audio().playCorrect();
                                                  }
                                                  logoData.getRewards();

                                                  logoData.updateWinningStatus(
                                                      logo,
                                                      category,
                                                      logo.id,
                                                      logo.catId);

                                                  waitTimeForResult();
                                                }
                                              } else {
                                                setState(() {
                                                  // print('listInput: ${listInput[i]}');
                                                  for (int j = 0;
                                                      j < listVisible.length;
                                                      j++) {
                                                    if (listQuestion[j] ==
                                                            listInput[i] &&
                                                        !listVisible[j]) {
                                                      listVisible[j] = true;
                                                    }
                                                  }
                                                  listInput[i] = '_';

                                                  // print(listInput);
                                                });
                                              }
                                            },
                                            child: buildWidget(logoData, i)

                                            //                         if(!equal(listAnswer, listInput)) {QuestionCell(
                                            //                                         colorHexBackground:
                                            //                                         0xFFf44336,
                                            //                                         colorHexText: 0xFF191919,
                                            //                                         character: listInput[i],
                                            //                                       )} else { QuestionCell(
                                            // colorHexBackground:
                                            // 0xFF4caf50,
                                            // colorHexText: 0xFFffffff,
                                            // character: listInput[i],)}

                                            //     if (!equal(listAnswer, listInput) &&
                                            // !listInput.contains('_'))
                                            //     {
                                            //   // if (logoData.soundCheck == 1)
                                            //   //   {Audio.playWrong()},
                                            //   QuestionCell(
                                            //     colorHexBackground:
                                            //     0xFFf44336,
                                            //     colorHexText: 0xFF191919,
                                            //     character: listInput[i],
                                            //   ),
                                            // }
                                            //    else if(equal(listAnswer, listInput))
                                            //     { QuestionCell(
                                            //   colorHexBackground:
                                            //   0xFF4caf50,
                                            //   colorHexText: 0xFFffffff,
                                            //   character: listInput[i],
                                            // ), }
                                            //     else { QuestionCell(
                                            //   colorHexBackground:
                                            //   0xFF1A1742,
                                            //   colorHexText: 0xFFffffff,
                                            //   character: listInput[i],
                                            // ),})
                                            // !equal(listAnswer, listInput) &
                                            //         !listInput.contains('_')
                                            //     ? {
                                            //         if (logoData.soundCheck == 1)
                                            //           {Audio.playWrong()},
                                            //         QuestionCell(
                                            //           colorHexBackground:
                                            //               0xFFf44336,
                                            //           colorHexText: 0xFF191919,
                                            //           character: listInput[i],
                                            //         )
                                            //       }
                                            //     : (equal(listAnswer, listInput)
                                            //         ? QuestionCell(
                                            //             colorHexBackground:
                                            //                 0xFF4caf50,
                                            //             colorHexText: 0xFFffffff,
                                            //             character: listInput[i],
                                            //           )
                                            //         : QuestionCell(
                                            //             colorHexBackground:
                                            //                 0xFF1A1742,
                                            //             colorHexText: 0xFFffffff,
                                            //             character: listInput[i],
                                            //           )),
                                            ),
                                    ]),
                              ),
                            );
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                      AbsorbPointer(
                        absorbing: isHintMode,
                        child: Container(
                          height: SizeConfig.screenHeight * 0.25,
                          width: SizeConfig.screenWidth,
                          child: FutureBuilder<Logo>(
                            future:
                                DatabaseProvider.dbProvider.getImage(widget.id),
                            builder: (BuildContext context,
                                AsyncSnapshot<Logo> snapshot) {
                              Logo logo = snapshot.data;
                              if (snapshot.hasData) {
                                if (loadingQuestion == 0) {
                                  loadingQuestion = 1;
                                  // print("random");
                                  splitString(logo.answer, listQuestion);
                                  temp = this.listQuestion.length;
                                  randomString(12 - temp);
                                }
                                // print('$listQuestion and ${listQuestion.length}');
                                // print('$listVisible and ${listVisible.length}');
                                return Container(
                                  height: SizeConfig.screenHeight * 0.18,
                                  width: SizeConfig.screenWidth,
                                  child: Center(
                                    child: Wrap(
                                      alignment: WrapAlignment.center,
                                      children: [
                                        for (int i = 0;
                                            i < listQuestion.length;
                                            i++)
                                          GestureDetector(
                                            onTap: () {
                                              // print("${category.count}");
                                              setState(() {
                                                for (int j = 0;
                                                    j < listInput.length;
                                                    j++) {
                                                  if (listInput[j] == '_') {
                                                    listInput[j] =
                                                        listQuestion[i];
                                                    listVisible[i] = false;
                                                    break;
                                                  }
                                                }
                                                if (equal(
                                                    listAnswer, listInput)) {
                                                  isWin = true;
                                                  if (logoData.soundCheck ==
                                                      1) {
                                                    Audio().playCorrect();
                                                  }
                                                  logoData.getRewards();
                                                  // print(logo);
                                                  // print(category);
                                                  // print(logo.id);

                                                  logoData.updateWinningStatus(
                                                      logo,
                                                      category,
                                                      logo.id,
                                                      logo.catId);

                                                  waitTimeForResult();
                                                }
                                              });
                                            },
                                            // onTap: () {
                                            //   setState(() {
                                            //     if (listChoose.length <
                                            //         listAnswer.length) {
                                            //       listChoose.add(listQuestion[i]);
                                            //       listVisible[i] = false;
                                            //       for (int j = 0;
                                            //           j < listInput.length;
                                            //           j++) {
                                            //         if (listInput[j] == '_') {
                                            //           listInput[j] = listQuestion[i];
                                            //           break;
                                            //         }
                                            //       }
                                            //       if (eq(listAnswer, listChoose)) {
                                            //         print('Win');
                                            //       } else {
                                            //         print('Ganbatte');
                                            //       }
                                            //       print('listAnswer: $listAnswer');
                                            //       print('listChoose: $listChoose');
                                            //       print(
                                            //           'listQuestion: $listQuestion');
                                            //     }
                                            //     print(listVisible);
                                            //   });
                                            // },
                                            child: Visibility(
                                              visible: listVisible[i],
                                              child: TextCell(
                                                character: listQuestion[i],
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                );
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
