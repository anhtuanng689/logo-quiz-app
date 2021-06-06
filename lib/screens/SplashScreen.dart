import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:logo_quiz/utils/SizeConfig.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("assets/images/splash.png"),
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            SvgPicture.asset(
              "assets/images/logoQuiz.svg",
              width: MediaQuery.of(context).size.width * 0.8,
            ),
            SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 60),
              child: Wrap(alignment: WrapAlignment.center, children: [
                Text(
                  'With a variety of quizzes, you may dive into the fantastic world of logos.',
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.0275,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
              ]),
            ),
            Spacer(),
            Center(
              child: DefaultTextStyle(
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.05,
                    color: Colors.orangeAccent,
                    fontWeight: FontWeight.w600),
                child: AnimatedTextKit(
                  animatedTexts: [
                    WavyAnimatedText('Loading...'),
                  ],
                  isRepeatingAnimation: true,
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
