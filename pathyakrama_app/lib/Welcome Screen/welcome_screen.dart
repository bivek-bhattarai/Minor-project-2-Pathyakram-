import 'package:flutter/material.dart';
import '../Login Sign-up Screen/Login Welcome/login_signup.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  static String id = 'WelcomeScreen';

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late PageController _pageController;
  int _pageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: const Color(0xffF8FAFB),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Hero(
                  tag: 'logo',
                  child: Image.asset(
                    'images/logo.png',
                    height: 350.0,
                  ),
                ),
                Expanded(
                  child: PageView.builder(
                    onPageChanged: (index) {
                      setState(() {
                        _pageIndex = index;
                      });
                    },
                    itemCount: onBoardData.length,
                    controller: _pageController,
                    itemBuilder: (context, index) => OnBoardContent(
                      title: onBoardData[index].title,
                      description: onBoardData[index].description,
                    ),
                  ),
                ),
                Row(
                  children: [
                    ...List.generate(
                      onBoardData.length,
                      (index) => Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: DotIndicator(isActive: index == _pageIndex),
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              PageRouteBuilder(
                                transitionDuration:
                                const Duration(seconds: 2),
                                pageBuilder: (_, __, ___) =>
                                const LoginSignPage(),
                              ));
                        },
                        child: const Text(
                          'Skip',
                          style: TextStyle(color: Color(0xff858484), fontSize: 17.0,),
                        ),
                    ),
                    const Spacer(),
                    SizedBox(
                      height: 60.0,
                      width: 60.0,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).primaryColor,
                          shape: const CircleBorder(),
                        ),
                        onPressed: () {
                          if (_pageIndex + 1 == onBoardData.length) {
                            Navigator.push(
                                context,
                                PageRouteBuilder(
                                  transitionDuration:
                                      const Duration(seconds: 2),
                                  pageBuilder: (_, __, ___) =>
                                      const LoginSignPage(),
                                ));
                          } else {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                          }
                        },
                        child: const Icon(
                          Icons.arrow_forward_ios,
                          size: 25.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    Key? key,
    required this.isActive,
  }) : super(key: key);

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      height: isActive ? 12.0 : 4.0,
      width: 4.0,
      decoration: BoxDecoration(
        color: isActive
            ? Theme.of(context).primaryColor
            : Theme.of(context).primaryColor.withOpacity(0.4),
        borderRadius: const BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
    );
  }
}

class OnBoard {
  OnBoard({required this.title, required this.description});
  final String title, description;
}

final List<OnBoard> onBoardData = [
  OnBoard(
      title: 'Welcome',
      description: 'An app where you can find study materials for your exam.'),
  OnBoard(
      title: 'Find your institution',
      description: 'Select your university or college and its courses.'),
  OnBoard(
      title: 'Find courses',
      description: 'Find courses that your university provides.'),
  OnBoard(
      title: 'Find your syllabus',
      description:
          'Find notes, question, and many more of you course syllabus.'),
];

class OnBoardContent extends StatelessWidget {
  const OnBoardContent({
    required this.title,
    required this.description,
    Key? key,
  }) : super(key: key);

  final String title, description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Spacer(),
        Text(
          title,
          style: const TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            color: Color(0xff0D81B2),
            fontFamily: 'artifica',
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 15.0,
        ),
        Text(
          description,
          style: const TextStyle(
            color: Color(0xff858484),
            fontSize: 17.0,
            fontFamily: 'artifica',
          ),
          textAlign: TextAlign.center,
        ),
        const Spacer(),
      ],
    );
  }
}
