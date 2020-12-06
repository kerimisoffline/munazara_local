import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


// Card konteynırının içini dolduracak olan widget.

class PostDetail extends StatefulWidget {
  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      child: Container(
        child: Row(
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
                        backgroundImage: AssetImage('assest/images/pp1.jpg'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                  margin: EdgeInsets.symmetric(vertical: 5),
                  padding: EdgeInsets.all(5),
                  child: Text('(8) TARAFSIZ JAPON'),
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
                    'İnsanoğlu hiçbir zaman Ay^a ayak basmamıştır.',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
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
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
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
                    Padding(
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
                  ],
                ), // Evet-Yüzde-Hayır
                Yorumlar(),
                // Yorumlar kısmı burada yani sistem en başından 2Yan-4Alt şeklinde
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Yorumlar extends StatefulWidget {
  Yorumlar({Key key}) : super(key: key);

  @override
  _YorumlarState createState() => _YorumlarState();
}

class _YorumlarState extends State<Yorumlar> {
  String cerenYorum =
      'Sallanan bayrak teorisi gibi \n bu da birçok şeyi kanıtlar \n niteliktedir.';
  String hakanYorum =
      'Apollo 9 görevleri dahil bir çok\n görevde insanlık yasa \nboğulup acısıyla mutludur.';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Row(
        children: [
          // EVET yorumları
          yorumlarEvetHayir(21, 'HAKAN', hakanYorum, 'assest/images/pp1.jpg',
              '13 ve daha fazla yorum', context),
          SizedBox(
            width: size.width * 0.01,
          ),
          // HAYIR yorumları
          yorumlarEvetHayir(3, 'CEREN', cerenYorum, 'assest/images/pp2.jpg',
              '25 ve daha fazla yorum', context),
        ],
      ),
    );
  }
}

Widget yorumlarEvetHayir(
    int yorumcuRutbe,
    String yorumcuId,
    String yorumAyrinti,
    String avatarLokasyon,
    String dahaFazlaYorum,
    BuildContext context) {
  Size size = MediaQuery.of(context).size;
  return Row(
    children: [
      Stack(
        children: [
          Card(
            child: Container(
              height: size.height * 0.07,
            ),
          ),
          FractionalTranslation(
            translation: Offset(0.0, 0),
            child: Align(
              child: CircleAvatar(
                radius: 12,
                backgroundColor: Colors.lime,
                backgroundImage:
                    AssetImage('$avatarLokasyon'), // assest/images/pp2.jpg
              ),
            ),
          ),
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            height: size.height * 0.030,
            width: size.width * 0.15,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  Text(
                    '($yorumcuRutbe)',
                    style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '$yorumcuId',
                    style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ), // rütbe ve isim
          Container(
            margin: EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                '$yorumAyrinti',
                style: TextStyle(fontSize: 8),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(
                  Icons.sms,
                  size: 10,
                ),
                Container(
                  child: Text(
                    '$dahaFazlaYorum',
                    style: TextStyle(fontSize: 7),
                  ),
                )
              ],
            ),
          ),
          // yorum
        ],
      ),
    ],
  );
}

// Container(
//                         width: MediaQuery.of(context).size.width * 0.4,
//                         height: MediaQuery.of(context).size.height * 0.1,
//                         child: Material(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           child: TextField(
//                             style: GoogleFonts.openSans(fontSize: 12),
//                             cursorColor: kPrimaryDarkColor,
//                             decoration: InputDecoration(
//                               hintStyle: GoogleFonts.openSans(fontSize: 10),
//                               hintText: 'Tarafını seç, Yorum Yap..',
//                               fillColor: Colors.white,
//                               border: OutlineInputBorder(
//                                 borderSide: BorderSide.none,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),