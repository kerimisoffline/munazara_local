import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:munazara_app/Model/constant.dart';
import 'package:munazara_app/Model/roundedButton.dart';
import 'package:munazara_app/View/WelcomePage/background.dart';
import 'package:munazara_app/View/WelcomePage/sign_in.dart';
import 'package:munazara_app/main.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'MunazaraApp v1.0',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Image.asset('assest/images/giris_kapi.png',
                height: size.height * 0.5),
            Container(
              width: size.width * 0.65,
              child: RoundedButton(
                text: 'GİRİŞ',
                press: () {
                  if (firebaseUser != null) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Home()));
                  }
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignInPage()));
                },
              ),
            ),
            Container(
              width: size.width * 0.65,
              child: RoundedButton(
                text: 'KAYIT OL',
                color: kPrimaryLightColor,
                textColor: Colors.black,
                press: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
