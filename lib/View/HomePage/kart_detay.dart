import 'package:flutter/material.dart';
import 'package:munazara_app/main.dart';

class KartDetayController extends StatelessWidget {
  final String id;
  const KartDetayController({Key key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(context,1,true,""),
      body: KartDetay(ide: id),
    );
  }
}

class KartDetay extends StatefulWidget {
  final String ide;
  KartDetay({Key key, this.ide}) : super(key: key);

  @override
  _KartDetayState createState() => _KartDetayState();
}

class _KartDetayState extends State<KartDetay> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text(widget.ide.toString()));
  }
}