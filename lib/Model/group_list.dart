import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:munazara_app/Model/constant.dart';
import 'package:munazara_app/View/GroupsPage/group_detail.dart';
import 'package:page_transition/page_transition.dart';

class GroupList {
  String id;
  String name;
  String members;

  GroupList({this.id, this.name, this.members});
}

getMyGroupsList() {
  return Scaffold(
    body: StreamBuilder<QuerySnapshot>(
        stream: groupscollection.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot groupsData = snapshot.data.docs[index];
                return ListTile(
                  title: Text(groupsData.data()['groups'],
                      style: GoogleFonts.comfortaa(fontSize: 16)),
                  trailing: Icon(Icons.arrow_forward_ios_sharp),
                  onTap: () => Navigator.push(
                    context,
                    PageTransition(
                        child:
                            GroupCard(groupName: groupsData.data()['groups']),
                        type: PageTransitionType.rightToLeft),
                  ),
                );
              });
        }),
  );
}

