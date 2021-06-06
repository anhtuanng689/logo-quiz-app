import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logo_quiz/provider/LogoProvider.dart';
import 'package:logo_quiz/utils/SizeConfig.dart';
import 'package:provider/provider.dart';

class HomeAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final logoData = Provider.of<LogoProvider>(context, listen: false);

    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.blockSizeHorizontal * 4,
          vertical: SizeConfig.blockSizeVertical),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              enableFeedback: logoData.isSound,
              padding: EdgeInsets.zero,
              icon: SvgPicture.asset(
                'assets/icons/setting.svg',
                height: SizeConfig.blockSizeVertical * 6,
              ),
              onPressed: () {}),
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
                  '150',
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
                    onPressed: () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
