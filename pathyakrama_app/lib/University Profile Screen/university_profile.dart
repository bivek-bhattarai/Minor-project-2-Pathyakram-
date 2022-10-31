import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

import '../Course Profile/course_profile.dart';

class UniversityProfile extends StatefulWidget {
  const UniversityProfile({
    Key? key,
    required this.universityName,
    required this.universityID,
    required this.universityImage,
  }) : super(key: key);
  final String universityName;
  final String universityID;
  final String universityImage;
  static String id = 'UniversityProfile';

  @override
  State<UniversityProfile> createState() => _UniversityProfileState();
}

class _UniversityProfileState extends State<UniversityProfile> {
  late List courses;
  bool isLoading = true;

  // String subscribeButtonText = 'Subscribe';
  // Color subsBtnTextColor = Colors.white;
  // Color subscribeButtonColor = const Color(0xff0D81B2);

  // void subscribeBtnFunc() {
  //   if (subscribeButtonText == 'Subscribe') {
  //     setState(() {
  //       subscribeButtonText = 'Subscribed';
  //       subscribeButtonColor = const Color(0xffBAE9F9);
  //       subsBtnTextColor = Colors.black;
  //     });
  //   } else {
  //     setState(() {
  //       subscribeButtonText = 'Subscribe';
  //       subscribeButtonColor = const Color(0xff0D81B2);
  //       subsBtnTextColor = Colors.white;
  //     });
  //   }
  // }

  @override
  void initState() {
    getCourses();
    super.initState();
  }

  void getCourses() async {
    String courseUrl =
        'http://10.0.2.2:3001/api/university-course/${widget.universityID}';
    List dataAsIsIt = [];
    try {
      await http.get(Uri.parse(courseUrl)).then((value) => {
            dataAsIsIt = jsonDecode(value.body),
            setState(() {
              courses = dataAsIsIt;
              isLoading = false;
            }),
          });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.8),
          elevation: 6.0,
          behavior: SnackBarBehavior.floating,
          content: const Text(
              'Ops something went wrong, please check your internet connection.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 15.0),
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 15.0),
              width: width,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 1.5,
                    color: Colors.grey,
                  ),
                ),
              ),
              child: Column(
                children: [
                  Hero(
                    tag: widget.universityID,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.contain,
                          image: NetworkImage(
                            widget.universityImage,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    widget.universityName,
                    style: Theme.of(context).textTheme.headline2?.copyWith(color: Colors.black, fontSize: 17),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  // SizedBox(
                  //   height: height * 0.055,
                  //   width: width * 0.300,
                  //   child: ElevatedButton(
                  //     style: ButtonStyle(
                  //       elevation: MaterialStateProperty.all(6.0),
                  //       backgroundColor: MaterialStateProperty.all<Color>(
                  //           subscribeButtonColor),
                  //     ),
                  //     onPressed: () {
                  //       subscribeBtnFunc();
                  //     },
                  //     child: Text(subscribeButtonText,
                  //         style: Theme.of(context)
                  //             .textTheme
                  //             .headline2
                  //             ?.copyWith(color: subsBtnTextColor)),
                  //   ),
                  // ),
                ],
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 3.0),
              decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                  color: Color(0xff0D81B2),
                  width: 1.5,
                )),
              ),
              child: Text(
                'Courses',
                style: Theme.of(context).textTheme.headline1?.copyWith(color: Colors.black),
              ),
            ),
            isLoading == false
                ? Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(top: 10.0),
                      itemCount: courses.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CourseProfile(
                                  universityID: widget.universityID,
                                  courseID: courses[index]['_id'],
                                  courseName: courses[index]['course'],
                                  universityName: widget.universityName,
                                ),
                              ),
                            );
                          },
                          contentPadding: const EdgeInsets.only(left: 0.0),
                          leading: IconButton(
                            onPressed: () {},
                            splashRadius: 20.0,
                            icon: const Icon(
                              Icons.notifications_rounded,
                              size: 27,
                            ),
                          ),
                          title: Text(
                            courses[index]['course'],
                            style: Theme.of(context)
                                .textTheme
                                .headline2
                                ?.copyWith(color: Colors.black),
                          ),
                        );
                      },
                    ),
                  )
                : Center(
                    child: SpinKitFadingCircle(
                      size: 60.0,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
