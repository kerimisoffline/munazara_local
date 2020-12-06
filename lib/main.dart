import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:munazara_app/Controller/authentication_services.dart';
import 'package:munazara_app/View/AddPage/munazara_add_view.dart';
import 'package:munazara_app/View/GroupsPage/group_detail.dart';
import 'package:munazara_app/View/GroupsPage/groups.dart';
import 'package:munazara_app/View/HomePage/ana_sayfa.dart';
import 'package:munazara_app/View/ProfilePage/profile.dart';
import 'package:munazara_app/View/WelcomePage/sign_in.dart';
import 'package:provider/provider.dart';
import 'Model/constant.dart';
import 'package:munazara_app/View/GroupsPage/groups_info.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Login());
}

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        // Access authentication services
        StreamProvider(
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'ÖyleyseVarım Test 1.0',
          theme: ThemeData(
            primaryColor: kPrimaryColor,
            scaffoldBackgroundColor: kPrimaryLightColor,
          ),
          home: AuthenticationWrapper(),
        ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
      return Home();
    }
    return SignInPage();
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  int _currentIndex = 0;

  final tabs = [
    Container(
      child: CardOne(),
    ),
    Center(
      child: GroupInfoView(),
    ),
    Center(
      child: AddPage(),
    ),
    Center(
      child: GroupSelect(),
    ),
    Center(
      child: ProfilPage(),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: tabs[_currentIndex],
          bottomNavigationBar: CurvedNavigationBar(
            color: kPrimaryColor,
            backgroundColor: Colors.transparent,
            height: 50,
            items: [
              Icon(
                Icons.home,
                size: 20,
                color: kPrimaryDarkColor,
              ),
              Icon(
                Icons.explore,
                size: 20,
                color: kPrimaryDarkColor,
              ),
              Icon(
                Icons.add_circle_outline,
                size: 40,
                color: kPrimaryDarkColor,
              ),
              Icon(
                Icons.people,
                size: 20,
                color: kPrimaryDarkColor,
              ),
              Icon(
                Icons.person_outline,
                size: 20,
                color: kPrimaryDarkColor,
              ),
            ],
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}

getCustomAppBar(context, int id, bool _isAppbar, String groupName) {
  if (id==1) {
    return PreferredSize(
      preferredSize: Size.fromHeight(50),
      child: AnimatedContainer(
        height: _isAppbar ? 55 : 0,
        duration: Duration(milliseconds: 200),
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(color: kPrimaryColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.chevron_left),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Text(
              'Münazara Test 1.1',
              style: GoogleFonts.sourceSansPro(fontSize: 20),
            ),
            IconButton(icon: Icon(Icons.menu), onPressed: () {}),
          ],
        ),
      ),
    );
  }
  if (id==2) {
     return PreferredSize(
      preferredSize: Size.fromHeight(50),
      child: AnimatedContainer(
        height: _isAppbar ? 55 : 0,
        duration: Duration(milliseconds: 200),
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(color: kPrimaryColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.chevron_left),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Text(
              '$groupName',
              style: GoogleFonts.sourceSansPro(fontSize: 20),
            ),
            PopupOptionMenu(holdname: groupName),
          ],
        ),
      ),
    );
    
  }
  return null;
}

enum MenuOption {Settings, Members, Logout}

class PopupOptionMenu extends StatelessWidget {
  final String holdname;
  const PopupOptionMenu({Key key,this.holdname}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MenuOption>(
      onSelected: (val)=> onItemMenuPressed(val,context),
      itemBuilder: (BuildContext context) {
        return  <PopupMenuEntry<MenuOption>>[
          PopupMenuItem(child: Text('Ayarlar'),
          value: MenuOption.Settings,
          ),
          PopupMenuItem(child: Text('Üyeler'),
          value: MenuOption.Members,
          ),
          PopupMenuItem(child: Text('Gruptan Çık'),
          value: MenuOption.Logout,
          )
        ];
      },
    );
  }
  void onItemMenuPressed(MenuOption val,BuildContext context){
    if (val==MenuOption.Members) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => GroupMembers(groupList: holdname)));
    }
    if (val==MenuOption.Settings){
      Navigator.push(context, MaterialPageRoute(builder: (context)=> GroupMembers()));
    }
  }
}