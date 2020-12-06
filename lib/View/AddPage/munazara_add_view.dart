import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:munazara_app/Controller/authentication_services.dart';
import 'package:munazara_app/Model/constant.dart';
import 'package:munazara_app/View/AddPage/munazara_add_function.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> with SingleTickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        flexibleSpace: SafeArea(child: getTabBar()),
      ),
      body: getTabBarPages(),
    );
  }

  Widget getTabBar() {
    return TabBar(
        indicatorColor: Colors.white,
        controller: _tabController,
        tabs: [
          Tab(
            text: "Tartışma Başlat",
            icon: Icon(Icons.question_answer_rounded),
          ),
          Tab(text: "Grup Ekle", icon: Icon(Icons.group_add)),
        ]);
  }

  Widget getTabBarPages() {
    return TabBarView(controller: _tabController, children: <Widget>[
      MunazaraAdd(),
      GroupAdd(),
    ]);
  }
}

class GroupAdd extends StatefulWidget {
  @override
  _GroupAddState createState() => _GroupAddState();
}

class _GroupAddState extends State<GroupAdd> {
  TextEditingController addController = TextEditingController();
  final database = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    uploadData(String name) async {
      List<String> splitList = name.split(' ');
      List<String> indexList = [];
      for (int i = 0; i < splitList.length; i++) {
        for (int j = 0; j < splitList[i].length + i; j++) {
          indexList.add(splitList[i].substring(0, j).toLowerCase());
        }
        if (indexList.length == addController.text.length) {
          database
              .collection('kesfetgroups')
              .add({'groups': name, 'searchIndex': indexList}).then((value) =>
                  database
                      .collection('kesfetgroups')
                      .doc(value.id)
                      .collection('group_members')
                      .add({'id': getUid(), 'member_type': 1}));
        }
      }
    }

    String text;
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            TextField(
              controller: addController,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    addController.clear();
                  },
                ),
                hintText: 'Yeni grup oluştur',
                hintStyle: GoogleFonts.comfortaa(),
              ),
            ),
            MaterialButton(
                color: kPrimaryLightColor,
                child: Text('Oluştur'),
                onPressed: () async {
                  text = addController.text.toString();
                  final isExist = await database
                      .collection('kesfetgroups')
                      .where('groups', isEqualTo: '$text')
                      .get();
                  if (isExist.docs.length == 0) {
                    uploadData(addController.text);
                    _dialogExist(1);
                  } else {
                    _dialogExist(0);
                  }
                }),
          ],
        ),
      ),
    );
  }

  _dialogExist(int id) {
    String message;
    if (id == 1) {
      message = "Grup Oluşturuldu";
    } else {
      message = "Böyle bir grup mevcut";
    }
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 0,
            backgroundColor: kPrimaryLightColor,
            title: Text(message,
                style: GoogleFonts.comfortaa(color: Colors.white)),
            actions: <Widget>[
              FlatButton(
                color: kPrimaryDarkColor,
                child: Text("Tamam",
                    style: GoogleFonts.comfortaa(color: Colors.white)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}

