import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logo_quiz/utils/SizeConfig.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logo_quiz/widgets/PurchaseCell.dart';
import 'package:logo_quiz/widgets/RemoveAdsCell.dart';

class PurchaseScreen extends StatefulWidget {
  const PurchaseScreen({Key key}) : super(key: key);
  @override
  _PurchaseScreenState createState() => _PurchaseScreenState();
}

class _PurchaseScreenState extends State<PurchaseScreen> {
  @override
  Widget build(BuildContext context) {
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
                      height: SizeConfig.blockSizeVertical * 4,
                      width: SizeConfig.screenWidth,
                      child: Center(
                        child: Text(
                          "Buy Coin",
                          style: TextStyle(
                            fontSize: SizeConfig.blockSizeVertical * 3,
                            color: Colors.white,
                          ),
                        ),
                      )),
                  Container(
                    height: SizeConfig.screenHeight * 0.525,
                    width: SizeConfig.screenWidth,
                    child: Column(
                      children: [
                        Spacer(),
                        Row(
                          children: [
                            Text(
                              "Shop",
                              style: TextStyle(
                                fontSize: SizeConfig.blockSizeVertical * 2.5,
                                color: Color(0xFFFF006d),
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        PurchaseCell(
                          purchaseIconURL: 'moneybag',
                          percentSave: '70% Save',
                          coin: 1000,
                          purchaseMoney: '90.000d',
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical,
                        ),
                        PurchaseCell(
                          purchaseIconURL: 'moneybag',
                          percentSave: '60% Save',
                          coin: 700,
                          purchaseMoney: '84.000d',
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical,
                        ),
                        PurchaseCell(
                          purchaseIconURL: 'moneybag',
                          percentSave: '50% Save',
                          coin: 400,
                          purchaseMoney: '60.000d',
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical,
                        ),
                        PurchaseCell(
                          purchaseIconURL: 'moneybag',
                          percentSave: '0',
                          coin: 100,
                          purchaseMoney: '30.000d',
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical,
                        ),
                        PurchaseCell(
                          purchaseIconURL: 'group',
                          percentSave: 'Free',
                          coin: 50,
                          purchaseMoney: 'Watch Video',
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                  Container(
                    height: SizeConfig.screenHeight * 0.15,
                    width: SizeConfig.screenWidth,
                    child: Column(
                      children: [
                        Spacer(),
                        Row(
                          children: [
                            Text(
                              "Advertising",
                              style: TextStyle(
                                fontSize: SizeConfig.blockSizeVertical * 2.5,
                                color: Color(0xFFFF006d),
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        RemoveAdsCell(
                          purchaseMoney: '99.000d',
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
