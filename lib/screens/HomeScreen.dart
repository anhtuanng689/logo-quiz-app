import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logo_quiz/db/DatabaseProvider.dart';
import 'package:logo_quiz/models/Logo.dart';
import 'package:logo_quiz/provider/LogoProvider.dart';
import 'package:logo_quiz/utils/SizeConfig.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logo_quiz/widgets/LogoTheme.dart';
import 'package:logo_quiz/screens/SettingScreen.dart';
import 'package:logo_quiz/screens/PurchaseScreen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void fetchData() async {
    print('checking');
    await Provider.of<LogoProvider>(context, listen: false).fetchAllCategory();
    setState(() {});
    print('done');
  }

  checkSound() async {
    await Provider.of<LogoProvider>(context, listen: false).fetchGameSound();
  }

  @override
  void initState() {
    super.initState();
    fetchData();
    checkSound();
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
                      IconButton(
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
                      IconButton(
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
                  height: SizeConfig.blockSizeVertical * 25,
                  width: SizeConfig.screenWidth,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SvgPicture.asset(
                        "assets/images/logoQuiz.svg",
                        width: SizeConfig.blockSizeHorizontal * 75,
                        // scale: 0.6,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: SizeConfig.blockSizeVertical * 1.5,
                            horizontal: SizeConfig.blockSizeHorizontal * 8),
                        decoration: BoxDecoration(
                          color: Color(0xFF14143a),
                          borderRadius: BorderRadius.all(Radius.circular(60.0)),
                        ),
                        child: logoData.totalWinningLogo == null
                            ? CircularProgressIndicator()
                            : Text(
                                '${logoData.totalWinningLogo}/2090',
                                // '0/2090',
                                style: TextStyle(
                                    color: Color(0xFFCBD5E1),
                                    fontWeight: FontWeight.bold,
                                    fontSize: SizeConfig.blockSizeVertical * 3),
                              ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: FutureBuilder<List<Logo>>(
                    future: DatabaseProvider.dbProvider.getCategories(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Logo>> snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            Logo logo = snapshot.data[index];
                            return Column(
                              children: [
                                FadeInLeft(
                                  duration: Duration(seconds: 1),
                                  child: LogoTheme(
                                    themeName: logo.categories,
                                    themeColor: 0xFF00C2FF,
                                    themeIconURL: logo.categories,
                                    themeLevel: logo.catId,
                                    progressPercent: 0,
                                    themeId: logo.catId,
                                  ),
                                ),
                                SizedBox(
                                  height: SizeConfig.blockSizeVertical * 3,
                                )
                              ],
                            );
                          },
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
