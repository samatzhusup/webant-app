import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webant/generated/l10n.dart';
import 'package:webant/presentation/resources/app_colors.dart';
import 'package:webant/presentation/resources/app_strings.dart';
import 'package:webant/presentation/resources/app_styles.dart';
import 'package:webant/presentation/ui/scenes/login/sign_in_page.dart';
import 'package:webant/presentation/ui/scenes/login/sign_up_page.dart';

enum typeTextField { USERNAME, BIRTHDAY, EMAIL }
enum typePasswordField { OLD_PASSWORD, NEW_PASSWORD, CONFIRM_PASSWORD }

class EnterPage extends StatefulWidget {
  const EnterPage({Key key}) : super(key: key);

  @override
  _EnterPageState createState() => _EnterPageState();
}

class _EnterPageState extends State<EnterPage> {
  final double _heightButton = 36;
  List<String> locales = ['en', 'ru'];

  void setLocale(String value) {
    setState(() {
      S.load(Locale.fromSubtags(languageCode: '$value'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorWhite,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.colorWhite,
        elevation: 0,
        actions: <Widget>[
          PopupMenuButton(
            icon: Icon(Icons.language, color: AppColors.mainColorAccent),
            onSelected: setLocale,
            padding: EdgeInsets.zero,
            itemBuilder: (BuildContext context) {
              return locales.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Image.asset(AppStrings.imageAnt),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Text(
                  S.of(context).welcomeTitle,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    color: AppColors.mainColor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
                child: buttons(
                    AppStyles.styleButtonCreateAccount,
                    Text(
                      //buttonCreateAccount
                      S.of(context).buttonCreateAccount,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14),
                    ),
                    SignUpPage()),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 20),
                child: buttons(
                    AppStyles.styleButtonAlreadyHaveAccount,
                    Text(
                      S.of(context).buttonAlreadyHaveAccount,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                    SignInPage()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buttons(ButtonStyle styleButton, Text text, page) {
    double widthButton = MediaQuery.of(context).size.width;
    return SizedBox(
      width: widthButton,
      height: _heightButton,
      child: ElevatedButton(
        style: styleButton,
        child: text,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context) => page),
          );
        },
      ),
    );
  }
}
