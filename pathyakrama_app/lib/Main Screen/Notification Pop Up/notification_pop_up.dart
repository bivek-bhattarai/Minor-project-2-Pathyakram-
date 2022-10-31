import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class NotificationPopUp extends StatelessWidget {
  const NotificationPopUp({Key? key, required this.isNTFLoading, required this.notifications}) : super(key: key);
  final bool isNTFLoading;
  final List notifications;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              titleTextStyle: Theme.of(context)
                  .textTheme
                  .headline1
                  ?.copyWith(color: Colors.white, fontSize: 17),
              backgroundColor:
              Theme.of(context).primaryColor.withOpacity(0.9),
              elevation: 6.0,
              title: Column(
                children: const [
                  Center(child: Text('Notifications')),
                  Divider(
                    thickness: 2.0,
                    color: Colors.white,
                  ),
                ],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              content: isNTFLoading == false
                  ? SizedBox(
                height: height * 0.300,
                width: double.maxFinite,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      minLeadingWidth: 12.0,
                      leading: const Icon(
                        Icons.circle,
                        color: Colors.greenAccent,
                        size: 10.0,
                      ),
                      title: Text(
                        notifications[index]['Notice'],
                        style: Theme.of(context)
                            .textTheme
                            .headline2
                            ?.copyWith(color: Colors.white),
                      ),
                    );
                  },
                ),
              )
                  : const FittedBox(
                fit: BoxFit.scaleDown,
                child: SpinKitFadingCircle(
                  size: 60.0,
                  color: Colors.white,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Close',
                    style: Theme.of(context)
                        .textTheme
                        .headline1
                        ?.copyWith(color: Colors.white, fontSize: 17),
                  ),
                ),
              ],
            );
          },
        );
      },
      splashRadius: 20.0,
      icon: const Icon(
        Icons.notifications_rounded,
        size: 27.0,
      ),
    );
  }
}
