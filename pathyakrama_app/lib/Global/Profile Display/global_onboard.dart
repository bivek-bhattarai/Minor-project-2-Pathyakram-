import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

import '../../Subject Profile/subject_profile.dart';

class GlobalOnboard extends StatefulWidget {
  const GlobalOnboard({Key? key, required this.courseName, required this.universityName, required this.universityID, required this.courseID, required this.semesters}) : super(key: key);
  final String courseName;
  final String universityName;
  final String universityID;
  final String courseID;
  final List semesters;

  @override
  State<GlobalOnboard> createState() => _GlobalOnboardState();
}

class _GlobalOnboardState extends State<GlobalOnboard> {
  int _pageIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget semesterScroll() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      scrollDirection: Axis.horizontal,
      itemCount: widget.semesters.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            _pageController.animateToPage(index,
                duration: const Duration(milliseconds: 500),
                curve: Curves.ease);
            setState(() {
              _pageIndex = index;
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
            margin: const EdgeInsets.only(right: 10.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: index == _pageIndex
                  ? Theme.of(context).primaryColor
                  : Colors.transparent,
            ),
            child: Text(
              widget.semesters[index]['semester'],
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: index == _pageIndex ? Colors.white : Colors.grey,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          SizedBox(
            height: 45.0,
            child: semesterScroll(),
          ),
          Expanded(
            child: PageView.builder(
                physics: const NeverScrollableScrollPhysics(),
                controller: _pageController,
                itemCount: widget.semesters.length,
                itemBuilder: (context, index) {
                  return SemesterOnboard(
                    universityID: widget.universityID,
                    courseID: widget.courseID,
                    semesterID: widget.semesters[index]['_id'],
                  );
                }),
          )
        ],
      ),
    );
  }
}

class SemesterOnboard extends StatefulWidget {
  const SemesterOnboard({
    Key? key,
    required this.universityID,
    required this.courseID,
    required this.semesterID,
  }) : super(key: key);
  final String universityID;
  final String courseID;
  final String semesterID;

  @override
  State<SemesterOnboard> createState() => _SemesterOnboardState();
}

class _SemesterOnboardState extends State<SemesterOnboard> {
  bool isLoading = true;
  late List subjects;

  @override
  void initState() {
    getSubjects();
    super.initState();
  }

  Future getSubjects() async {
    String courseUrl =
        'http://10.0.2.2:3001/api/semester-subject/${widget.universityID}/${widget.courseID}/${widget.semesterID}';
    List dataAsIsIt = [];
    await http.get(Uri.parse(courseUrl)).then((value) => {
      dataAsIsIt = jsonDecode(value.body),
      setState(() {
        subjects = dataAsIsIt;
        isLoading = false;
      }),
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading == false
        ? (subjects.isEmpty
        ? Center(
      child: Text(
        'No subjects added in this semester',
        style: Theme.of(context)
            .textTheme
            .headline2
            ?.copyWith(color: Colors.grey),
      ),
    )
        : ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        itemCount: subjects.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SubjectProfile(
                semesterText: subjects[index]['semester'][0],
                subjectText: subjects[index]['subject'][0],
                universityID: widget.universityID,
                courseID: widget.courseID,
                semesterID: widget.semesterID,
                subjectID: subjects[index]['_id'],
              )));
            },
            horizontalTitleGap: 40.0,
            leading: const Icon(Icons.subject_rounded),
            title: Text(
              subjects[index]['subject'],
              style: Theme.of(context)
                  .textTheme
                  .headline2
                  ?.copyWith(color: Colors.black),
            ),
          );
        }))
        : SpinKitFadingCircle(
      size: 60.0,
      color: Theme.of(context).primaryColor,
    );
  }
}
