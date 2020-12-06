import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:munazara_app/Controller/authentication_services.dart';
import 'package:munazara_app/Model/constant.dart';
import 'package:munazara_app/Model/group_list.dart';
import 'package:munazara_app/View/HomePage/card.dart';
import 'package:munazara_app/main.dart';

class GroupCard extends StatefulWidget {
  final String groupName;
  GroupCard({Key key, this.groupName});

  @override
  _GroupCardState createState() => _GroupCardState();
}

class _GroupCardState extends State<GroupCard> {
  bool _isAppbar = true;
  String myUid = '';
  ScrollController _scrollController = new ScrollController();
  @override
  void initState() {
    super.initState();
    getcurrentuseruid();
    getgroupname();
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

  getgroupname() {
    setState(() {
      GroupList(name: widget.groupName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(context, 2, _isAppbar, widget.groupName),
      body: StreamBuilder(
        stream: munazaracollection.snapshots(),
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
                munText: munazaraData.data()['mun_text'],
                myUid: myUid,
                munOwnerUid: munazaraData.data()['mun_owner_id'],
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
        },
      ),
    );
  }
}

class GroupMembers extends StatefulWidget {
  final String groupList;
  const GroupMembers({Key key, this.groupList}) : super(key: key);

  @override
  _GroupMembersState createState() => _GroupMembersState();
}

//başka state başka hayal
class _GroupMembersState extends State<GroupMembers> {
  var _data;
  bool isMember;
  List list = [];

  Future<QuerySnapshot>getMemberList() async {
    
   QuerySnapshot qn = await groupscollection
        .where('groups', isEqualTo: widget.groupList).get();
        String docID = qn.docs.single.id;
    QuerySnapshot qnb = await groupscollection.doc(docID).collection('group_members').get();
    //then((value) => value.docs.forEach((result) {groupscollection.doc(result.id).collection('group_members');}));
    return qnb;
  }

  @override
  void initState() {
    super.initState();
    _getData();
    adminControl();
  }

  _getData() {
    setState(() {
      _data = getMemberList();
    });
  }

  void adminControl()async{
    QuerySnapshot qn = await groupscollection
        .where('groups', isEqualTo: widget.groupList).get();
        String docID = qn.docs.single.id;
    var qnb = groupscollection.doc(docID).collection('group_members').where('id',isEqualTo: getUid()).where('member_type',isEqualTo: 1).toString();
    if  (qnb!=""){
      setState(() {
        isMember = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(context, 2, true, widget.groupList),
      body: FutureBuilder<QuerySnapshot>(
        future: getMemberList(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot groupMembers = snapshot.data.docs[index];
                return GetMemberData(
                  userid: groupMembers.data()['id'],
                  adminStatus: groupMembers.data()['member_type'],
                );
              });
        },
      ),
    );
  }
}

class GetMemberData extends StatefulWidget {
  final String userid;
  final int adminStatus;
  final String currentid=getUid();
  GetMemberData({Key key, this.userid, this.adminStatus}) : super(key: key);

  @override
  _GetMemberDataState createState() => _GetMemberDataState();
}

class _GetMemberDataState extends State<GetMemberData> {
  String username = "";
  initState() {
    super.initState();
    _getData(widget.userid);
  }

  _getData(String userid) async {
    DocumentSnapshot userdoc = await usercollection.doc('$userid').get();
    setState(() {
      username = userdoc.data()['username'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("$username", style: GoogleFonts.comfortaa(fontSize: 16)),
      trailing: _getAdmin(widget.adminStatus,widget.userid),
    );
  }

  _getAdmin(int adminStatus,String userId) {
    if (adminStatus == 1) {
      return Icon(Icons.star_border_rounded);
    }
    if (userId==widget.currentid) {
        return IconButton(icon: Icon(Icons.exit_to_app), onPressed: (){});
    }
    return null;
  }
}

//iç içe sorgu
/*
_onPressed() async*{
await groupscollection.get().then((querySnapshot) {
  querySnapshot.docs.forEach((result) {
    groupscollection
        .doc('Dwemzv6ALKs27vybd3ne')
        .collection("group_members").doc('admins')
        .get()
        .then((value)  {
            return value.data()['member_id'];
    });
  });
});
}
*/
