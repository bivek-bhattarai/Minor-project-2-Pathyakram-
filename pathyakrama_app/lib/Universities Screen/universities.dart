import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../Main Screen/Drawer/drawer.dart';
import '../Main Screen/Notification Pop Up/notification_pop_up.dart';
import '../Main Screen/constants.dart';
import '../Main Screen/helper.dart';
import '../University Profile Screen/university_profile.dart';

class Universities extends StatefulWidget {
  const Universities({Key? key}) : super(key: key);
  static String id = 'Universities';

  @override
  State<Universities> createState() => _UniversitiesState();
}

class _UniversitiesState extends State<Universities> {
  final String pageName = 'Universities';
  late List notifications = [];
  late List universities = [];
  bool isNTFLoading = false;
  bool isLoading = false;
  final String imageUrl = 'http://10.0.2.2:3001';
  final _globalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    getNotifications();
    getUniversitiesDetails();
    super.initState();
  }

  Future getNotifications() async {
    notifications.clear();
    try {
      await MainScreenHelper.getNotifications().then((value) => {
            setState(() {
              notifications = value;
              isNTFLoading = false;
            })
          });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.8),
          elevation: 6.0,
          behavior: SnackBarBehavior.floating,
          content: const Text(
              'Failed to lead notifications, Please check you internet connection'),
        ),
      );
    }
  }

  void getUniversitiesDetails() async {
    try {
      await MainScreenHelper.getUniversities().then((value) => {
            setState(() {
              universities = value['universities'];
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
              'Ops something went wrong. Please check your internet connection'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        title: const Text('Universities'),
        leading: IconButton(
          icon: kDrawerIcon,
          onPressed: () {
            _globalKey.currentState?.openDrawer();
          },
        ),
        actions: [
          NotificationPopUp(
            isNTFLoading: isNTFLoading,
            notifications: notifications,
          ),
        ],
      ),
      drawer: DrawerItems(
        pageName: pageName,
      ),
      body: isLoading == false
          ? ListView.builder(
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
              itemCount: universities.length,
              itemBuilder: (context, index) {
                String universityImage =
                    universities[index]['image'].replaceAll('\\', '/');
                return ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UniversityProfile(
                          universityImage: '$imageUrl/$universityImage',
                          universityName: universities[index]['university'],
                          universityID: universities[index]['_id'],
                        ),
                      ),
                    );
                  },
                  contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                  horizontalTitleGap: 40.0,
                  leading: Hero(
                    tag: universities[index]['_id'],
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.200,
                      // height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.contain,
                          image: NetworkImage(
                            '$imageUrl/$universityImage',
                          ),
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    universities[index]['university'],
                    style: Theme.of(context)
                        .textTheme
                        .headline2
                        ?.copyWith(color: Colors.black),
                  ),
                );
              },
            )
          : Center(
              child: SpinKitFadingCircle(
                size: 60.0,
                color: Theme.of(context).primaryColor,
              ),
            ),
    );
  }
}
