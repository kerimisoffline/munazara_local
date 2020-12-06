import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:munazara_app/Controller/authentication_services.dart';
import 'package:munazara_app/Model/constant.dart';
import 'package:munazara_app/View/ProfilePage/edit_profile_page.dart';
import 'package:munazara_app/main.dart';
import 'package:provider/provider.dart';

class ProfilPage extends StatefulWidget {
  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
    String myUid = '';
    String username = '';
    String userpic = '';
    final firebaseuser = FirebaseAuth.instance.currentUser;
    
@override
  void initState() {
    super.initState();
    getcurrentuser();
  }

  getcurrentuser() async {
    myUid = firebaseuser.uid;
    DocumentSnapshot userdoc = await usercollection.doc(myUid).get();
    setState(() {
      username = userdoc.data()['username'];
      userpic = userdoc.data()['user_pic'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: getCustomAppBar(context, 1, true,""),
        body: Center(
          child: Column(
            children: [
              Flexible(
                flex: 2,
                child: Container(
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment(1, 1),
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.black54,
                          child: IconButton(
                            icon: Icon(
                              Icons.exit_to_app,
                              color: Colors.white,
                              size: 15,
                            ),
                            onPressed: () async {
                              _showdialog();
                            },
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          image: DecorationImage(
                            image: NetworkImage('$userpic'),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment(-1, 1),
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.black54,
                          child: IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 15,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditProfilePage(),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "(21) $username",
                    style: GoogleFonts.comfortaa(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Flexible(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: GridListView(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _showdialog() {

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Çıkmak istediğinize emin misiniz?"),
            actions: [
              MaterialButton(
                child: Text("Evet"),
                onPressed: () async {
                  await context.read<AuthenticationService>().signOut();
                  Fluttertoast.showToast(
                    msg: "SignOut",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                  );
                },
              ),
              MaterialButton(
                child: Text("Hayır"),
                onPressed: (){
                  Navigator.of(context).pop();
                })
            ],
          );
        });
  }
}

class GridListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Expanded(child: GridDetail(1)),
                Expanded(child: GridDetail(2)),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Expanded(child: GridDetail(3)),
                Expanded(child: GridDetail(4)),
              ],
            ),
          )
        ],
      ),
    );
  }
}

// ignore: non_constant_identifier_names
Widget GridDetail(int gridNumber) {
  String pathvalue;
  String pathname;
  switch (gridNumber) {
    case 1:
      {
        pathvalue = "21";
        pathname = "Tartışma";
      }
      break;
    case 2:
      {
        pathvalue = "125";
        pathname = "Favori";
      }
      break;
    case 3:
      {
        pathvalue = "17";
        pathname = "Gruplar";
      }
      break;
    case 4:
      {
        pathvalue = "8";
        pathname = "Başarım";
      }
      break;
    default:
      {}
  }
  return InkWell(
    onTap: () {},
    child: Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: kPrimaryColor, width: 2),
          borderRadius: BorderRadius.circular(50),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "$pathvalue",
              style: TextStyle(color: Colors.amber[400], fontSize: 30),
            ),
            Text(
              "$pathname",
              style: GoogleFonts.comfortaa(
                  fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    ),
  );
}
