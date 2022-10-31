import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class SubjectProfile extends StatefulWidget {
  const SubjectProfile(
      {Key? key,
      required this.universityID,
      required this.courseID,
      required this.semesterID,
      required this.subjectID,
      required this.subjectText,
      required this.semesterText})
      : super(key: key);
  final String universityID;
  final String courseID;
  final String semesterID;
  final String subjectID;
  final String subjectText;
  final String semesterText;

  @override
  State<SubjectProfile> createState() => _SubjectProfileState();
}

class _SubjectProfileState extends State<SubjectProfile> {
  bool isLoading = true;
  late PageController _pageController;
  int _pageIndex = 0;
  late List subjectItem;
  List queryKeywords = ['syllabus', 'note', 'quesation'];
  late String listTileTitle;
  Color favouriteIconColor = Colors.grey;

  // Future addFavouriteItems(String itemUrl) async {
  //   final CollectionReference ref =
  //   FirebaseFirestore.instance.collection('userFavourite');
  //   // List allNotifications = [];
  //   await ref.add({'email': FirebaseAuth.instance.currentUser?.email, 'favourite': itemUrl});
  // }

  @override
  void initState() {
    getSubjectItems(queryKeywords[0]);
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future getSubjectItems(String apiQuery) async {
    isLoading = true;
    String courseUrl =
        'http://10.0.2.2:3001/api/subject-$apiQuery/${widget.universityID}/${widget.courseID}/${widget.semesterID}/${widget.subjectID}';
    List dataAsIsIt = [];
    try {
      await http.get(Uri.parse(courseUrl)).then((value) => {
            dataAsIsIt = jsonDecode(value.body),
            setState(() {
              subjectItem = dataAsIsIt;
              isLoading = false;
              listTileTitle = apiQuery;
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subject Materials'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 17.0,
        elevation: 6.0,
        backgroundColor: Colors.white,
        currentIndex: _pageIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.toc_rounded),
            label: 'Syllabus',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.description_rounded),
            label: 'Notes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books_rounded),
            label: 'Questions',
          ),
        ],
        onTap: (index) {
          getSubjectItems(queryKeywords[index]);
          setState(() {
            _pageIndex = index;
            listTileTitle = queryKeywords[index];
          });
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (_pageController.hasClients) {
              _pageController.animateToPage(_pageIndex,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease);
            }
          });
          // _pageController.animateToPage(_pageIndex,
          //     duration: const Duration(milliseconds: 500), curve: Curves.ease);
        },
      ),
      body: isLoading == false
          ? (subjectItem.isEmpty
              ? Center(
                  child: Text(
                    'No $listTileTitle added in this subject.',
                    style: Theme.of(context)
                        .textTheme
                        .headline2
                        ?.copyWith(color: Colors.grey),
                  ),
                )
              : Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: PageView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: _pageController,
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return ListView.builder(
                          itemCount: listTileTitle == queryKeywords[2]
                              ? subjectItem[0][listTileTitle].length
                              : subjectItem.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () async {
                                String fileName = listTileTitle == queryKeywords[2]
                                    ? subjectItem[0][listTileTitle][index]
                                    : subjectItem[index][listTileTitle];
                                String url = 'http://10.0.2.2:3001/images/$fileName';
                                print(url);
                                if(await canLaunchUrl(Uri.parse(url))){
                                  await launchUrl(
                                    Uri.parse(url),
                                    mode: LaunchMode.externalApplication,
                                  );
                                }else {
                                  throw 'Could not launch $url';
                                }
                              },
                              leading: const Icon(Icons.picture_as_pdf_rounded),
                              trailing: GestureDetector(
                                onTap: () {
                                  favouriteIconColor == Colors.grey ?
                                  setState(() {
                                    favouriteIconColor = Theme.of(context).primaryColor;
                                  }) : setState(() {
                                    favouriteIconColor = Colors.grey;
                                  });
                                },
                                child: Icon(Icons.favorite, color: favouriteIconColor,),
                              ),
                              title: Text(
                                  listTileTitle == queryKeywords[2]
                                      ? subjectItem[0][listTileTitle][index]
                                      : subjectItem[index][listTileTitle],
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline2
                                      ?.copyWith(color: Colors.black)),
                            );
                          },
                        );
                      }),
                ))
          : SpinKitFadingCircle(
              size: 60.0,
              color: Theme.of(context).primaryColor,
            ),
    );
  }
}
