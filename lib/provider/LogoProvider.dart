import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:logo_quiz/db/DatabaseProvider.dart';
import 'package:logo_quiz/models/Logo.dart';
import 'package:logo_quiz/models/Score.dart';
import 'package:logo_quiz/models/Categories.dart';

class LogoProvider with ChangeNotifier {
  Score gameScore = Score();
  int totalCoin;
  int totalWinningLogo;
  int soundCheck;
  int randomScore;

  // List<Logo> logoList = [];
  List<Categories> categoryList = [];

  fetchGameSound() async {
    soundCheck = await DatabaseProvider.dbProvider.fetchSound();
  }

  // fetchLogoPerTheme(int numberTheme) async {
  //   logoList =
  //       await DatabaseProvider.dbProvider.getLogoGridPerTheme(numberTheme);
  //   notifyListeners();
  // }

  fetchAllCategory() async {
    totalWinningLogo = await DatabaseProvider.dbProvider.fetchCount();
    print(totalWinningLogo);
    categoryList = await DatabaseProvider.dbProvider.fetchCategory();
    notifyListeners();
  }

  getRewards() async {
    Random random = Random();
    randomScore = random.nextInt(50) + 50; //+50
    totalCoin += randomScore;
    gameScore.score = totalCoin;
    await DatabaseProvider.dbProvider.updateScore(gameScore);
    notifyListeners();
  }

  minusRemoveLetter() async {
    totalCoin -= 300;
    gameScore.score = totalCoin;
    await DatabaseProvider.dbProvider.updateScore(gameScore);
    notifyListeners();
  }

  minusRandomLetter() async {
    totalCoin -= 50;
    gameScore.score = totalCoin;
    await DatabaseProvider.dbProvider.updateScore(gameScore);
    notifyListeners();
  }

  minusShowAnswer() async {
    totalCoin -= 400;
    gameScore.score = totalCoin;
    await DatabaseProvider.dbProvider.updateScore(gameScore);
    notifyListeners();
  }

  updateShowAnswerStatus(
      Logo logo, Categories category, int logoId, int categoryId) async {
    //update status
    logo.isWin = 1;
    //all in app
    if (totalWinningLogo < 2090) {
      totalWinningLogo++;
    }
    if (categoryList[categoryId - 1].count < categoryList[categoryId - 1].all) {
      //each in app
      categoryList[categoryId - 1].count =
          categoryList[categoryId - 1].count + 1;
      // print('${categoryList[id - 1].count}.');
      category.count = categoryList[categoryId - 1].count;
      // print('${category.count}..');
    }
    //update status in db
    await DatabaseProvider.dbProvider.updateLogoStatus(logo, logoId);
    await DatabaseProvider.dbProvider.updateWinningLogo(category, categoryId);
    notifyListeners();
  }

  updateWinningStatus(
      Logo logo, Categories category, int logoId, int categoryId) async {
    //update status
    logo.isWin = 1;
    //all in app
    if (totalWinningLogo < 2090) {
      totalWinningLogo++;
    }
    if (categoryList[categoryId - 1].count < categoryList[categoryId - 1].all) {
      //each in app
      categoryList[categoryId - 1].count =
          categoryList[categoryId - 1].count + 1;
      // print('${categoryList[id - 1].count}.');
      category.count = categoryList[categoryId - 1].count;
      // print('${category.count}..');
    }
    //update status in db
    await DatabaseProvider.dbProvider.updateLogoStatus(logo, logoId);
    await DatabaseProvider.dbProvider.updateWinningLogo(category, categoryId);
    notifyListeners();
  }

  // updateWinningStatus(Logo logo, Categories category, int id) async {
  //   //update status
  //   logo.isWin = 1;
  //   //all in app
  //   totalWinningLogo++;
  //   //each in app
  //   categoryList[id - 1].count++;
  //   // print('${categoryList[id - 1].count}.');
  //   category.count = categoryList[id - 1].count;
  //   // print('${category.count}..');
  //   //update status in db
  //   await DatabaseProvider.dbProvider.updateLogoStatus(logo, id);
  //   await DatabaseProvider.dbProvider.updateWinningLogo(category, id);
  //   notifyListeners();
  // }
}
