import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:munazara_app/Model/constant.dart';
import 'package:munazara_app/View/HomePage/card.dart';
import 'package:munazara_app/main.dart';

class CardOne extends StatefulWidget {
  @override
  _CardOneState createState() => _CardOneState();
}

class _CardOneState extends State<CardOne> {
  String myUid = '';
  var _munData;

  bool _isAppbar = true;

  ScrollController _scrollController = new ScrollController();
  @override
  void initState() {
    super.initState();
    getcurrentuseruid();
    getCollectionList();
    
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        appBarStatus(false);
      }
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        appBarStatus(true);
      }
    });
    
  }

  void appBarStatus(bool status) {
    setState(() {
      _isAppbar = status;
    });
  }

  getcurrentuseruid() {
    var firebaseuser = FirebaseAuth.instance.currentUser;
    setState(() {
      myUid = firebaseuser.uid;
    });
  }

  getCollectionList() async {
    Stream<QuerySnapshot> _munDataSnapshot = munazaracollection.snapshots();
    setState(() {
      _munData = _munDataSnapshot;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(context, 1, _isAppbar,""),
      body: StreamBuilder(
      stream: _munData,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          controller: _scrollController,
          shrinkWrap: true,
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot munazaraData = snapshot.data.docs[index];
            return InSide(
                    myUid: myUid,
                    munOwnerUid: munazaraData.data()['mun_owner_id'],
                    munText: munazaraData.data()['mun_text'],
                    munYesVote: munazaraData.data()['mun_yes_vote'],
                    munNoVote: munazaraData.data()['mun_no_vote'],
                    munFavs: munazaraData.data()['mun_favs'],
                    munComments: munazaraData.data()['mun_comments'],
                    munShares: munazaraData.data()['mun_shares'],
                    munPostedTime: munazaraData.data()['mun_share_time'],
                    munId: munazaraData.data()['id'],
            );
          },
        );
      },),
    );
  }
}
