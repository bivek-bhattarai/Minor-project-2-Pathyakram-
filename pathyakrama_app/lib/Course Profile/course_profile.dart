import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

import '../Global/Profile Display/global_onboard.dart';
import '../Global/Profile Display/profile_details.dart';
import '../Subject Profile/subject_profile.dart';

class CourseProfile extends StatefulWidget {
  const CourseProfile(
      {Key? key,
      required this.courseName,
      required this.universityName,
      required this.universityID,
      required this.courseID})
      : super(key: key);
  final String courseName;
  final String universityName;
  final String universityID;
  final String courseID;

  @override
  State<CourseProfile> createState() => _CourseProfileState();
}

class _CourseProfileState extends State<CourseProfile> {
  bool isLoading = true;
  late List semesters;
  int _pageIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    getSemesters();
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  Future getSemesters() async {
    String courseUrl =
        'http://10.0.2.2:3001/api/course-semester/${widget.universityID}/${widget.courseID}';
    List dataAsIsIt = [];
    try {
      await http.get(Uri.parse(courseUrl)).then((value) => {
            dataAsIsIt = jsonDecode(value.body),
            setState(() {
              semesters = dataAsIsIt;
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
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Semesters'),
      ),
      body: Column(
        children: [
          ProfileDetails(
            profileMessage: 'Choose a semester of ${widget.courseName} course to view its subjects.',
            firstTileIcon: const Icon(Icons.school_rounded),
            secondTileIcon: const Icon(Icons.book_rounded),
            courseName: widget.courseName,
            universityName: widget.universityName,
          ),
          isLoading == false
              ? GlobalOnboard(
            courseName: widget.courseName,
            universityName: widget.universityName,
            universityID: widget.universityID,
            courseID: widget.courseID,
            semesters: semesters,
          )
              : SizedBox(
                  height: MediaQuery.of(context).size.height * 0.550,
                  child: SpinKitFadingCircle(
                    size: 60.0,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
        ],
      ),
    );
  }
}