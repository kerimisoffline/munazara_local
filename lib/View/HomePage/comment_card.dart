import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommentCard extends StatefulWidget {
  
  @override
  _CommentCardState createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            child: Stack(
              children: [
                Card(
                  child: Container(
                    height: size.height * 0.3,
                  ),
                ),
                FractionalTranslation(
                  translation: Offset(0.0, 0),
                  child: Align(
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.lime,
                      backgroundImage: AssetImage('assest/images/pp3.jpg'),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                        ),
                        margin: EdgeInsets.symmetric(vertical: 5),
                        padding: EdgeInsets.all(5),
                        child: Text('kerim'),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(Icons.star_rate_sharp),
                          Text(
                            '17',
                            style: GoogleFonts.comfortaa(),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    height: size.height * 0.10,
                    width: size.width * 0.75,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 2),
                    padding: EdgeInsets.all(5),
                    child: Text(
                      'Burada yapılan yorum',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
