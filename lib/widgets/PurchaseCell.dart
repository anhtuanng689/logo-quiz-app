import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logo_quiz/utils/SizeConfig.dart';

class PurchaseCell extends StatelessWidget {
  final String purchaseIconURL;
  final String percentSave;
  final int coin;
  final String purchaseMoney;

  PurchaseCell({
    this.purchaseIconURL,
    this.percentSave,
    this.coin,
    this.purchaseMoney,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.blockSizeHorizontal * 2,
      ),
      height: SizeConfig.screenHeight * 0.08,
      width: SizeConfig.screenWidth * 0.9,
      decoration: BoxDecoration(
        color: Color(0xFF22214B),
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
      ),
      child: Row(
        children: [
          Container(
            width: SizeConfig.screenWidth * 0.075,
            height: SizeConfig.screenHeight * 0.055,
            child: SvgPicture.asset(
              'assets/icons/$purchaseIconURL.svg',
            ),
          ),
          Spacer(),
          percentSave == "Free"
              ? Container(
                  width: SizeConfig.screenWidth * 0.235,
                  height: SizeConfig.screenHeight * 0.055,
                  decoration: BoxDecoration(
                    color: Color(0xFF287446),
                    border: Border.all(width: 3.0, color: Colors.transparent),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0)),
                  ),
                  child: Center(
                    child: Text(
                      percentSave,
                      style: TextStyle(
                        fontSize: SizeConfig.blockSizeVertical * 1.8,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              : percentSave == "0"
                  ? Container(
                      width: SizeConfig.screenWidth * 0.235,
                      height: SizeConfig.screenHeight * 0.055,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border:
                            Border.all(width: 3.0, color: Colors.transparent),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0)),
                      ),
                    )
                  : Container(
                      width: SizeConfig.screenWidth * 0.235,
                      height: SizeConfig.screenHeight * 0.055,
                      decoration: BoxDecoration(
                        color: Color(0xFF183bb1),
                        border:
                            Border.all(width: 3.0, color: Colors.transparent),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0)),
                      ),
                      child: Center(
                        child: Text(
                          percentSave,
                          style: TextStyle(
                            fontSize: SizeConfig.blockSizeVertical * 1.8,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
          Spacer(),
          Container(
            // color: Colors.lightGreen,
            width: SizeConfig.screenWidth * 0.075,
            height: SizeConfig.screenHeight * 0.055,
            child: SvgPicture.asset(
              'assets/icons/money.svg',
            ),
          ),
          SizedBox(
            width: SizeConfig.safeBlockHorizontal,
          ),
          Container(
            // color: Colors.lightBlueAccent,
            width: SizeConfig.screenWidth * 0.12,
            height: SizeConfig.screenHeight * 0.055,
            child: Center(
              child: Text(
                coin.toString(),
                style: TextStyle(
                  fontSize: SizeConfig.blockSizeVertical * 1.8,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Spacer(),
          Container(
            width: SizeConfig.screenWidth * 0.28,
            height: SizeConfig.screenHeight * 0.055,
            child: purchaseMoney == "Watch Video"
                ? Center(
                    child: Wrap(alignment: WrapAlignment.center, children: [
                      Text(
                        purchaseMoney,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF00C2FF),
                          fontWeight: FontWeight.bold,
                          fontSize: SizeConfig.blockSizeVertical * 1.9,
                        ),
                      )
                    ]),
                  )
                : Center(
                    child: Text(
                      purchaseMoney,
                      style: TextStyle(
                        color: Color(0xFF00C2FF),
                        fontWeight: FontWeight.bold,
                        fontSize: SizeConfig.blockSizeVertical * 1.9,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
