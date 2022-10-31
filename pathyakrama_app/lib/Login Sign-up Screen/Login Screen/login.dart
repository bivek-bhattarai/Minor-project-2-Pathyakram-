import 'package:flutter/material.dart';
import 'package:pathyakrama_app/Login%20Sign-up%20Screen/Login%20Screen/fb_login_check.dart';
import '../../Main Screen/main_screen.dart';
import '../Login Screen/helper.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  static String id = 'Login';

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Map _userObj = {};

  MaterialButton buttonGenerator({
    required String text,
    image,
    required Function() onPressed,
  }) {
    return MaterialButton(
      onPressed: onPressed,
      minWidth: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      height: 50.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 6.0,
      color: Colors.white,
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 15.0,
            child: Image.asset(
              image,
              height: 25,
            ),
          ),
          const Spacer(),
          Text(text, style: Theme.of(context).textTheme.headline1),
          const Spacer(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: const Color(0xffF8FAFB),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 35.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Hero(
                tag: 'logo',
                child: Image.asset(
                  'images/logo.png',
                  height: 350.0,
                ),
              ),
              Column(
                children: [
                  buttonGenerator(
                      text: 'Login with Google',
                      image: 'images/google.png',
                      onPressed: () async {
                        await LoginHelper().signInWithGoogle().then((value) {
                          if (value != null) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MainScreen(),
                              ),
                            );
                          }
                        });
                      }),
                  const SizedBox(
                    height: 20.0,
                  ),
                  buttonGenerator(
                    text: 'Login with Facebook',
                    image: 'images/facebook.png',
                    onPressed: () async {
                      await LoginHelper().signInWithFacebook().then(
                            (value) => {
                              FBLoginCheck.isLoginFromFB = true,
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MainScreen(),
                                ),
                              ),
                            },
                          );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
