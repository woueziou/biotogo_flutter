import 'package:flutter/material.dart';
import 'package:ecom/utils/appTheme.dart';
import 'package:ecom/utils/consts.dart';
import 'package:ecom/utils/languages_local.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => new _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  static final String path =
      "lib/src/pages/onboarding/smart_wallet_onboarding.dart";
  final slides = [
    Slide(
      title: APPNAME,
      styleTitle: TextStyle(
          color: themeTextColor,
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'RobotoMono'),
      description: """
        Bienvenue sur Bio TOGO Market! le carrefour des produits locaux, Bio & Naturel 100% TOGOLAIS. Commandez vite et soyez livrer dans les meilleurs délais.
        """,
      styleDescription: TextStyle(
          color: themeTextColor,
          fontSize: 15.0,
          fontStyle: FontStyle.italic,
          fontFamily: 'Raleway'),
      pathImage: "assets/splashone.png",
      backgroundColor: themeBG,
    ),
    Slide(
      title: APPNAME,
      styleTitle: TextStyle(
          color: themeTextColor,
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'RobotoMono'),
      description:
          """Ensemble consommons local, consommons Bio sur www.biotogo.tg
Biotogo, le carrefour des produits locaux. © 2021 Bio TOGO. BeWell Concept""",
      styleDescription: TextStyle(
          color: themeTextColor,
          fontSize: 15.0,
          fontStyle: FontStyle.italic,
          fontFamily: 'Raleway'),
      pathImage: "assets/splashtwo.png",
      backgroundColor: themeBG,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeBG,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            IntroSlider(
              slides: this.slides,
              onDonePress: this.onDonePress,
              onSkipPress: this.onSkipPress,
              colorSkipBtn: themeAppBarItems,
              highlightColorSkipBtn: themeAppBarItems,

              // Next, Done button
              colorDoneBtn: themeAppBarItems,
              highlightColorDoneBtn: themeAppBarItems,
              // Dot indicator
              colorDot: themeAppBarItems,
              colorActiveDot: Colors.indigo,
              sizeDot: 13.0,
            )
          ],
        ),
      ),
    );
  }

  void onDonePress() {
    Navigator.pushReplacementNamed(context, "/home");
  }

  void onSkipPress() {
    Navigator.pushReplacementNamed(context, "/home");
  }
}
