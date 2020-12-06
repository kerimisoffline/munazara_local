
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:munazara_app/Controller/authentication_services.dart';
import 'package:munazara_app/Model/constant.dart';
import 'package:munazara_app/Model/group_list.dart';
import 'package:munazara_app/Model/share_model.dart';
import 'package:munazara_app/View/GroupsPage/group_detail.dart';
import 'package:page_transition/page_transition.dart';
import 'package:munazara_app/View/GroupsPage/groups_info.dart';

class GroupSelect extends StatefulWidget {
  @override
  _GroupSelectState createState() => _GroupSelectState();
}

class _GroupSelectState extends State<GroupSelect>
    with SingleTickerProviderStateMixin {
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
            text: "Gruplarım",
            icon: Icon(Icons.group_sharp),
          ),
          Tab(text: "Grup Ara", icon: Icon(Icons.search)),
        ]);
  }

  Widget getTabBarPages() {
    return TabBarView(controller: _tabController, children: <Widget>[
      GroupPage(),
      GroupSearch(),
    ]);
  }
}

class GroupPage extends StatefulWidget {
  @override
  _GroupPageState createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  @override
  Widget build(BuildContext context) {
    return getMyGroupsList();
  }
}

class GroupSearch extends StatefulWidget {
  @override
  _GroupSearchState createState() => _GroupSearchState();
}

class _GroupSearchState extends State<GroupSearch> {
  TextEditingController addController = TextEditingController();
  TextEditingController textEditingController = TextEditingController();
  final database = FirebaseFirestore.instance;
  String searchString = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  child: TextField(
                    onChanged: (val) {
                      setState(() {
                        searchString = val.toLowerCase();
                      });
                    },
                    controller: textEditingController,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          textEditingController.clear();
                        },
                      ),
                      hintText: 'Grup Ara',
                      hintStyle: GoogleFonts.comfortaa(
                          color: Colors.blueGrey, fontSize: 20),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: (searchString == null || searchString.trim() == '')
                      ? FirebaseFirestore.instance
                          .collection('kesfetgroups')
                          .snapshots()
                      : FirebaseFirestore.instance
                          .collection('kesfetgroups')
                          .where('searchIndex', arrayContains: searchString)
                          .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text("Hata var ${snapshot.error}");
                    }
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return SizedBox(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      case ConnectionState.none:
                        return Text("Grup Bulunamadı");
                      case ConnectionState.done:
                        return Text("Tamamlandı");
                      default:
                        return ListView(
                            children: snapshot.data.docs
                                .map((DocumentSnapshot document) {
                          if (searchString != '') {
                            return ListTile(
                              onTap: () {
                                _showdialog(document['groups'],document);
                              },
                              title: Text(document['groups']),
                            );
                          }
                        }).toList());
                    }
                  },
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }

  _showdialog(String name,DocumentSnapshot document) async{
    String uid = getUid();
    var dz = groupscollection.doc().collection('group_members').where('groups',isEqualTo:name).snapshots();
    
    final QuerySnapshot result = await groupscollection.doc(document.id).collection('group_members')
        .where('id', isEqualTo: uid)
        .get();

    final List<DocumentSnapshot> documents = result.docs;

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Center(child: Text(name)),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("125 üye"),
            ),
            actions: [
              MaterialButton(
                focusColor: kPrimaryColor,
                color: Colors.white,
                child: Text("Gruba Katıl"),
                onPressed: () async {
                  if (documents.length>0) {
                      print('zaten var');
                  }
                  else
                  {
                          groupscollection.where('groups', isEqualTo: name).get().then(
                      (value) => groupscollection
                          .doc(value.docs.single.id)
                          .collection('group_members')
                          .add({'id': uid, 'member_type': 1}));
                  }}
              ),
              MaterialButton(
                focusColor: kPrimaryColor,
                child: Text("Şikayet Et"),
                color: Colors.white,
                onPressed: () {},
              ),
              MaterialButton(
                  focusColor: kPrimaryColor,
                  child: Text("Geri Dön"),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.of(context).pop();
                  })
            ],
          );
        });
  }
}
