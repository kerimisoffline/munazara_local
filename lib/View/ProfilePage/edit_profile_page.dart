import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:munazara_app/Model/constant.dart';
import 'package:munazara_app/main.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  Widget textField({@required String hintText}) {
    return TextField(
      decoration: InputDecoration(
        hintStyle: GoogleFonts.openSans(),
        hintText: hintText,
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: getCustomAppBar(context,4,true,""),
        backgroundColor: kPrimaryLightColor,
        body: Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
              painter: HeadCurvedContainer(),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      textField(hintText: 'Kullanıcı Adı'),
                      textField(hintText: 'Email'),
                      textField(hintText: 'Şifre'),
                      textField(hintText: 'Tekrar Şifre'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly ,
                        children: [
                          Container(
                            height: 55,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  side: BorderSide.none),
                              onPressed: () {},
                              color: kPrimaryDarkColor,
                              child: Center(
                                  child: Text(
                                "Güncelle",
                                style: TextStyle(fontSize: 23, color: Colors.white),
                              ),),
                            ),
                          ),
                          Container(
                            height: 55,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  side: BorderSide.none),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              color: kPrimaryDarkColor,
                              child: Center(
                                  child: Text(
                                "Vazgeç",
                                style: TextStyle(fontSize: 23, color: Colors.white),
                              ),),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.05,
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  width: MediaQuery.of(context).size.width / 3,
                  height: MediaQuery.of(context).size.height / 3,
                  decoration: BoxDecoration(
                    border: Border.all(color: kPrimaryLightColor, width: 5),
                    shape: BoxShape.circle,
                    color: Colors.white,
                    image: DecorationImage(
                      image: AssetImage('assest/images/pp1.jpg'),
                    ),
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

class HeadCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = kPrimaryDarkColor;
    Path path = Path()
      ..relativeLineTo(0, 50)
      ..quadraticBezierTo(size.width / 2, 255, size.width, 50)
      ..relativeLineTo(0, -150)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
