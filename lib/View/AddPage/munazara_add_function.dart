import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:munazara_app/Model/constant.dart';
import 'package:munazara_app/Model/group_list.dart';

class MunazaraAdd extends StatefulWidget {
  @override
  _MunazaraAddState createState() => _MunazaraAddState();
}

class _MunazaraAddState extends State<MunazaraAdd> {
  String valueChoose;
  String selectedValue;
  
  List listItem = [
    'Felsefe',
    'Psikoloji',
    'Siyaset',
    'Bilim',
    'Gündem',
    'Magazin',
    'Sinema/Dizi',
    'Müzik',
    'Eğitim',
    'Kariyer',
    'Teknik',
    'Genel',
    'Diğer'
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Container(padding: EdgeInsets.all(10), child: Text('Konu:')),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: menu('Seçiniz'),
              )
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Detayları giriniz...',
                //labelText: 'Tartışma',
                labelStyle: TextStyle(fontSize: 24, color: Colors.black),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
              obscureText: false,
              maxLength: 140,
              maxLines: 4,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StreamBuilder<QuerySnapshot>(
                    stream: groupscollection.snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      List<DropdownMenuItem> groupItems = [];
                      for (int i = 0; i < snapshot.data.docs.length; i++) {
                        DocumentSnapshot snap = snapshot.data.docs[i];
                        groupItems.add(DropdownMenuItem(
                          child: Text(
                            snap.data()['groups'],
                            style: GoogleFonts.comfortaa(fontSize: 16),
                          ),
                          value: '${snap.data()['groups']}',
                        ));
                      }
                      return Container(
                        child: DropdownButton(
                          items: groupItems,
                          hint: Text('Gruplarımda paylaş'),
                          onChanged: (newValue) {
                            final snackbar = SnackBar(
                              content: Text(
                                  'Tartışma $newValue grubunda paylaşılacaktır'),
                            );
                            Scaffold.of(context).showSnackBar(snackbar);
                            setState(() {
                              selectedValue = newValue;
                            });
                          },
                          value: selectedValue,
                        ),
                      );
                    }),
                    Container(
                      width: size.width*0.3,
                      height: size.height*0.08,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                      gradient: LinearGradient(
                        colors: [kPrimaryColor, Colors.pink,Colors.red],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        stops: [0.1,0.5,0.9],
                      ),
                    ),
                      alignment: Alignment.center,
                      child: FlatButton(
                        color:Colors.transparent,
                        onPressed: (){},
                        child: Text('Paylaş',textAlign: TextAlign.center,style: TextStyle(color:Colors.white),)),
                    ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget menu(String text) {
    return DropdownButton(
        underline: SizedBox(),
        hint: Text('$text'),
        icon: Icon(Icons.arrow_drop_down_circle),
        value: valueChoose,
        items: listItem.map((valueItem) {
          return DropdownMenuItem(
            value: valueItem,
            child: Text(valueItem),
          );
        }).toList(),
        onChanged: (newValue) {
          setState(() {
            valueChoose = newValue;
          });
        });
  }
}
