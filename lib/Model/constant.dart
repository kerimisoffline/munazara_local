import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:munazara_app/Controller/authentication_services.dart';

const kPrimaryColor = Color(0xFF189AB4);
const kPrimaryDarkColor = Color(0xFF05445E);
const kPrimaryLightColor = Color(0xFF75E6DA);

CollectionReference groupscollection = FirebaseFirestore.instance.collection('kesfetgroups');
CollectionReference usercollection = FirebaseFirestore.instance.collection('users');
CollectionReference munazaracollection = FirebaseFirestore.instance.collection('munazaralar');
//CollectionReference groupDetailCollection = FirebaseFirestore.instance.collection('kesfetgroups');
//CollectionReference groupsByidCollection = FirebaseFirestore.instance.collection('kesfetgroups').doc().collection('group_members').where('id', isEqualTo: getUid());

mystyle(double size, [Color color, FontWeight fw]) {
  return GoogleFonts.montserrat(fontSize: size, fontWeight: fw, color: color);
}