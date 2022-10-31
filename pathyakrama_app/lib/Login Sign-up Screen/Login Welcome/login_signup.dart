import 'package:flutter/material.dart';
import '../Login Screen/helper.dart';
import '../Login Screen/login.dart';
import 'login_widgets.dart';

class LoginSignPage extends StatefulWidget {
  const LoginSignPage({Key? key}) : super(key: key);
  static String id = 'LoginSignPage';

  @override
  State<LoginSignPage> createState() => _LoginSignPageState();
}

class _LoginSignPageState extends State<LoginSignPage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    controller.forward();

    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: const Color(0xffF8FAFB),
          padding: const EdgeInsets.all(15.0),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
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
                  LoginInWidgets.materialButtons(
                    buttonText: 'Login Now',
                    onPressed: () {
                      Navigator.pushNamed(context, Login.id);
                    },
                    btnColor: Theme.of(context)
                        .primaryColor
                        .withOpacity(controller.value),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  LoginInWidgets.materialButtons(
                    buttonText: 'Create Account',
                    onPressed: () {},
                    btnColor:
                        const Color(0xffF8FAFB).withOpacity(controller.value),
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
