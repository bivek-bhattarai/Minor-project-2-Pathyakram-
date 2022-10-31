import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import '../Main Screen/constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../Universities Screen/universities.dart';
import 'Category Cards/category_cards.dart';
import 'Drawer/drawer.dart';
import 'Horizontal Scroll/horizontal_scroll.dart';
import 'Notification Pop Up/notification_pop_up.dart';
import 'Search Delegate/search_delegate.dart';
import 'helper.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    Key? key,
    this.fbImageUrl,
  }) : super(key: key);
  static String id = 'mainScreen';
  final String? fbImageUrl;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _globalKey = GlobalKey<ScaffoldState>();
  String pageName = 'Home';
  bool isLoading = true;
  late List universities = [];
  bool isNTFLoading = true;
  List notifications = [];
  Map dataAsItIs = {};

  @override
  void initState() {
    getUniversitiesDetails();
    getNotificationsDetails();
    super.initState();
  }

  void getUniversitiesDetails() async {
    try {
      await MainScreenHelper.getUniversities().then((value) => {
            setState(() {
              universities = value['universities'];
              dataAsItIs = value;
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
    // for (var university in universities) {
    //   setState(() {
    //     extractedUniversities.add(university['university']);
    //   });
    // }
  }

  Future getNotificationsDetails() async {
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
              'Failed to load notifications, Please check you internet connection'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          key: _globalKey,
          appBar: AppBar(
            title: kMainScreenTitle,
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
              ? Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 20.0),
                      child: MaterialButton(
                        onPressed: () {
                          showSearch(
                            context: context,
                            delegate: CustomSearchDelegate(
                                universityData: dataAsItIs),
                          );
                        },
                        color: Theme.of(context).backgroundColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        elevation: 10.0,
                        padding: const EdgeInsets.symmetric(horizontal: 0.0),
                        child: Container(
                          height: 50.0,
                          padding: const EdgeInsets.only(left: 25.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Find what you seek for..',
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              Material(
                                elevation: 10.0,
                                borderRadius: BorderRadius.circular(30.0),
                                child: Container(
                                  height: 50.0,
                                  width: 50.0,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  child: const Icon(
                                    Icons.search_rounded,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        physics: const BouncingScrollPhysics(),
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
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
                                    'Category',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1
                                        ?.copyWith(color: Colors.black),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CategoryCards(
                                      categoryIcon: Icons.school_rounded,
                                      categoryTitle: 'Universities',
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const Universities(),
                                          ),
                                        );
                                      },
                                    ),
                                    CategoryCards(
                                      categoryIcon: Icons.local_library_rounded,
                                      categoryTitle: 'Courses',
                                      onPressed: () {},
                                    ),
                                    CategoryCards(
                                      categoryIcon: Icons.description_rounded,
                                      categoryTitle: 'Notes',
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                              ],
                            ),
                          ),
                          HorizontalScroll(
                            itemList: universities,
                            categoryText: 'Universities',
                          ),
                          // HorizontalScroll(
                          //   itemList: universities,
                          //   categoryText: 'Universities',
                          // ),
                          // HorizontalScroll(
                          //   itemList: universities,
                          //   categoryText: 'Universities',
                          // ),
                        ],
                      ),
                    ),
                  ],
                )
              : Center(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.77,
                    child: SpinKitFadingCircle(
                      size: 60.0,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
