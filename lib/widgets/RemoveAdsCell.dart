import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logo_quiz/utils/SizeConfig.dart';

class RemoveAdsCell extends StatelessWidget {
  final String purchaseMoney;

  RemoveAdsCell({
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
              'assets/icons/adblock.svg',
            ),
          ),
          Spacer(),
          Container(
            // color: Colors.lightBlueAccent,
            // width: SizeConfig.screenWidth * 0.1,
            height: SizeConfig.screenHeight * 0.055,
            child: Center(
              child: Text(
                'Remove ads',
                style: TextStyle(
                  fontSize: SizeConfig.blockSizeVertical * 2.3,
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
                ? Wrap(alignment: WrapAlignment.center, children: [
                    Text(
                      purchaseMoney,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF00C2FF),
                        fontWeight: FontWeight.bold,
                        fontSize: SizeConfig.blockSizeVertical * 2.5,
                      ),
                    )
                  ])
                : Center(
                    child: Text(
                      purchaseMoney,
                      style: TextStyle(
                        color: Color(0xFF00C2FF),
                        fontWeight: FontWeight.bold,
                        fontSize: SizeConfig.blockSizeVertical * 3,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
