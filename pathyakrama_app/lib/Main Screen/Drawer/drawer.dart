import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pathyakrama_app/Main%20Screen/main_screen.dart';
import '../../Login Sign-up Screen/Login Screen/fb_login_check.dart';
import '../../Login Sign-up Screen/Login Screen/login.dart';
import '../../Universities Screen/universities.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';

class DrawerItems extends StatefulWidget {
  const DrawerItems({Key? key, required this.pageName}) : super(key: key);
  final String pageName;

  @override
  State<DrawerItems> createState() => _DrawerItemsState();
}

class _DrawerItemsState extends State<DrawerItems> {
  final googleSignIn = GoogleSignIn();
  Future logOut() async {
    googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }

  bool isActive = false;

  static List items = [
    {'title': 'Home', 'icon': Icons.home},
    {'title': 'Universities', 'icon': Icons.school_rounded},
    {'title': 'My Files', 'icon': Icons.folder},
    {'title': 'Shared with me', 'icon': Icons.star},
    {'title': 'Recent', 'icon': Icons.schedule},
    {'title': 'Sign out', 'icon': Icons.account_circle}
  ];

  @override
  void initState() {
    getFBImage();
    super.initState();
  }

  late String imageA = '';
  bool isLoginFromFB = false;

  getFBImage() async {
    var ins = FirebaseAuth.instance;
    var loginProvider = ins.currentUser!.providerData;
    if (loginProvider[0].providerId == FBLoginCheck.loginProvider) {
      FBLoginCheck.isLoginFromFB = true;
    }

    final fb = FacebookLogin();
    var image = await fb.getProfileImageUrl(width: 100);
    setState(() {
      imageA = image!;
      isLoginFromFB = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20.0), bottomRight: Radius.circular(20.0)),
      child: Drawer(
        backgroundColor: Theme.of(context).backgroundColor,
        width: MediaQuery.of(context).size.width * 0.820,
        elevation: 6.0,
        child: Column(
          children: <Widget>[
            DrawerHeader(
              padding: const EdgeInsets.only(
                left: 30.0,
                top: 20.0,
              ),
              decoration: BoxDecoration(
                border: const Border(
                  bottom: BorderSide(
                    width: 1.5,
                    color: Color(0xffE3E3E3),
                  ),
                ),
                color: Theme.of(context).backgroundColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      FBLoginCheck.isLoginFromFB == false
                          ? CircleAvatar(
                              radius: 25.0,
                              backgroundImage: NetworkImage(
                                  FirebaseAuth.instance.currentUser!.photoURL!),
                            )
                          : (isLoginFromFB == false
                              ? CircleAvatar(
                                  radius: 25.0,
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                )
                              : CircleAvatar(
                                  radius: 25.0,
                                  backgroundImage: NetworkImage(imageA),
                                )),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_rounded,
                          size: 30.0,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    FirebaseAuth.instance.currentUser!.displayName!,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  Text(
                    FirebaseAuth.instance.currentUser!.email!,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  scrollDirection: Axis.vertical,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    items[index]['title'] == widget.pageName
                        ? isActive = true
                        : isActive = false;
                    return ListTile(
                      tileColor: isActive
                          ? const Color(0xffBAE9F9)
                          : Theme.of(context).backgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      horizontalTitleGap: 50.0,
                      leading: Icon(
                        items[index]['icon'],
                        size: 26.0,
                        color: isActive
                            ? Theme.of(context).primaryColor
                            : Colors.grey,
                      ),
                      title: Text(
                        items[index]['title'],
                        style: isActive
                            ? Theme.of(context).textTheme.headline2
                            : Theme.of(context)
                                .textTheme
                                .headline2
                                ?.copyWith(color: Colors.grey),
                      ),
                      onTap: () {
                        if (items[index]['title'] == 'Sign out') {
                          logOut().then((value) => {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Login())),
                            FBLoginCheck.isLoginFromFB = false,
                          });
                        } else if (items[index]['title'] == 'Universities') {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Universities()));
                        } else if (items[index]['title'] == 'Home') {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MainScreen(),
                            ),
                          );
                        }
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
