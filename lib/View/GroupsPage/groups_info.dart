import 'package:flutter/material.dart';
import 'package:munazara_app/Model/constant.dart';

class GroupInfoView extends StatelessWidget {
  final String name;
  const GroupInfoView({Key key,@required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
          child: Container(
        width: size.width * 0.7,
        height: size.height * 0.5,
        color: Colors.white,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("$name"),
              ), Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("1250 Üye"),
              )],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RaisedButton(
                  onPressed: (){},
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  child: Row(children: [Icon(Icons.add_box), Text("Katılma isteği gönder")]),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
