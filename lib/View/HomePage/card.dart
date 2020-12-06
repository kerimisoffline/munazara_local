import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:munazara_app/Model/constant.dart';
import 'package:munazara_app/View/HomePage/kart_detay.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class InSide extends StatefulWidget {
  final String munId;
  final String myUid;
  final String munOwnerUid;
  final String munText;
  final List munYesVote;
  final List munNoVote;
  final List munFavs;
  final List munComments;
  final List munShares;
  final Timestamp munPostedTime;

  InSide({
    Key key,
    this.myUid,
    this.munOwnerUid,
    this.munText,
    this.munYesVote,
    this.munNoVote,
    this.munFavs,
    this.munComments,
    this.munShares,
    this.munPostedTime,
    this.munId,
  }) : super(key: key);
  @override
  _InSideState createState() => _InSideState();
}

class _InSideState extends State<InSide> {
  String username = '';
  String userpic = '';
  Icon starChanged = Icon(Icons.star_border);
  int voteStatus = 0;
  double voteRate = 0.5;
  String dokunus = 'noo tenks';

  initState() {
    super.initState();
    getRate();
    if (username == '') {
      getMunOwnerData();
      getStateValue();
    }
  }

  getMunOwnerData() async {
    DocumentSnapshot userdoc =
        await usercollection.doc(widget.munOwnerUid).get();

    setState(() {
      username = userdoc.data()['username'];
      userpic = userdoc.data()['user_pic'];
    });
  }

  getStateValue() {
    if (widget.munYesVote.contains(widget.myUid)) {
      setState(() {
        voteStatus = 1;
      });
    }
    if (widget.munNoVote.contains(widget.myUid)) {
      setState(() {
        voteStatus = 2;
      });
    }
  }

  getRate() {
    int countYes = widget.munYesVote.length;
    int countNo = widget.munNoVote.length;
    if (countYes > 0 && countNo > 0) {
      setState(() {
        voteRate =
            ((countYes * 100 / (countNo + countYes)).roundToDouble() / 100)
                .toDouble();
      });
    } else if (countYes > 0) {
      setState(() {
        voteRate = 1;
      });
    } else {
      setState(() {
        voteRate = 0;
      });
    }
  }

  onTapInkwell(id) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => KartDetayController(id: id)));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () => onTapInkwell(widget.munId),
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            child: Stack(
              children: [
                Card(
                  child: Container(
                    height: size.height * 0.2,
                  ),
                ),
                FractionalTranslation(
                  translation: Offset(0.0, 0),
                  child: Align(
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.lime,
                      backgroundImage: NetworkImage(userpic),
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
                        child: Text(username),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: () {
                                starChanged = Icon(Icons.star);
                              },
                              icon: starChanged),
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
                      'oy durumu : ' + dokunus,
                      //  ' / yes oranı : ' +
                      // widget.munYesVote.toString() +
                      //' / yes sayısı : ' +
                      //  widget.munRateVoteYes.toString(),
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Container(
                    child: getVoteTemplate(
                        size, voteStatus, voteRate, widget.munId, widget.myUid),
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

Widget getVoteTemplate(size, voteStatus, voteRate, munId, myUid) {
  switch (voteStatus) {
    case 1:
      return yesTemplate(size, voteRate);
      break;

    case 2:
      return noTemplate(size, voteRate);
      break;

    default:
      return defaultVoteTemplate(size, munId, myUid);
      break;
  }
}

Widget yesTemplate(size, voteRate) {
  return Padding(
      padding: EdgeInsets.all(3),
      child: new LinearPercentIndicator(
        width: size.width * 0.52,
        backgroundColor: Colors.red,
        animation: false,
        lineHeight: size.height * 0.05,
        leading: new Text(
          'EVET',
          style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: new Text("HAYIR"),
        percent: voteRate,
        center: Text((voteRate * 100).toString() +
            "%                     " +
            (100 - voteRate * 100).toString() +
            '%'),
        linearStrokeCap: LinearStrokeCap.butt,
        progressColor: Colors.green[300],
      ));
}

Widget noTemplate(size, voteRate) {
  return Padding(
      padding: EdgeInsets.all(3),
      child: new LinearPercentIndicator(
        width: size.width * 0.52,
        animation: false,
        backgroundColor: Colors.red,
        lineHeight: size.height * 0.05,
        leading: new Text('EVET'),
        trailing: new Text("HAYIR",
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            )),
        percent: voteRate,
        center: Text((voteRate * 100).toString() +
            "%                     " +
            (100 - voteRate * 100).toString() +
            '%'),
        linearStrokeCap: LinearStrokeCap.butt,
        progressColor: Colors.green[300],
      ));
}

Widget defaultVoteTemplate(size, munId, myUid) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      InkWell(
        onTap: () => yesButtonFunc(munId, myUid),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: size.width * 0.28,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'EVET',
                  style: TextStyle(
                      color: Colors.green[300],
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
            ),
          ),
        ),
      ),
      // yorumlar kısmı
      Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(child: Icon(Icons.poll)),
        ),
      ),
      InkWell(
        onTap: () => noButtonFunc(munId, myUid),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: size.width * 0.28,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'HAYIR',
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

yesButtonFunc(String documentid, myUid) async {
  munazaracollection.doc(documentid).update({
    'mun_yes_vote': FieldValue.arrayUnion([myUid])
  });
}

noButtonFunc(String documentid, myUid) async {
  munazaracollection.doc(documentid).update({
    'mun_no_vote': FieldValue.arrayUnion([myUid])
  });
}
