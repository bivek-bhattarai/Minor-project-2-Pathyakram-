import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

class ProfileDetails extends StatelessWidget {
  const ProfileDetails({Key? key, required this.universityName, required this.courseName, required this.firstTileIcon, required this.secondTileIcon, required this.profileMessage}) : super(key: key);
  final String universityName;
  final String courseName;
  final Icon firstTileIcon;
  final Icon secondTileIcon;
  final String profileMessage;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                color: Colors.grey,
                width: 1.5,
              ))),
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      margin: const EdgeInsets.only(bottom: 10.0),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              ListTile(
                title: Text(universityName,
                    style: Theme.of(context).textTheme.headline3),
                leading: firstTileIcon,
              ),
              ListTile(
                title: Text(courseName,
                    style: Theme.of(context).textTheme.headline3),
                leading: secondTileIcon,
              ),
            ],
          ),
          Text(
            profileMessage,
            style: Theme.of(context).textTheme.headline2?.copyWith(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
