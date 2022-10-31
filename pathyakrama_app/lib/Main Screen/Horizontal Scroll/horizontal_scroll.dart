import 'package:flutter/material.dart';
import '../../University Profile Screen/university_profile.dart';

class HorizontalScroll extends StatelessWidget {
  const HorizontalScroll({
    required this.categoryText,
    required this.itemList,
    Key? key,
  }) : super(key: key);
  final String categoryText;
  final List itemList;

  final String imageUrl = 'http://10.0.2.2:3001';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 15.0),
          padding: const EdgeInsets.only(bottom: 3.0),
          decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(
              color: Color(0xff0D81B2),
              width: 1.5,
            )),
          ),
          child: Text(
            categoryText,
            style: Theme.of(context).textTheme.headline1?.copyWith(color: Colors.black),
          ),
        ),
        const SizedBox(
          height: 7.0,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.195,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(left: 15.0, top: 10.0),
            itemCount: itemList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              String universityImage = itemList[index]['image'].replaceAll('\\', '/');
              return Row(
                children: [
                  Column(
                    children: [
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 6.0,
                        color: Colors.white,
                        height: MediaQuery.of(context).size.height * 0.165,
                        minWidth: MediaQuery.of(context).size.width * 0.400,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UniversityProfile(
                                universityImage: '$imageUrl/$universityImage',
                                universityID: itemList[index]['_id'],
                                universityName: itemList[index]['university'],
                              ),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Hero(
                              tag: itemList[index]['_id'],
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.200,
                                height: MediaQuery.of(context).size.height * 0.120,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.contain,
                                    image: NetworkImage(
                                        '$imageUrl/$universityImage',),
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              itemList[index]['university'],
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2
                                  ?.copyWith(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 12.0,
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

// SizedBox(
// height: MediaQuery.of(context).size.height * 0.195,
// child: ListView.builder(
// physics: const BouncingScrollPhysics(),
// padding: const EdgeInsets.only(left: 15.0, top: 10.0),
// itemCount: itemList.length,
// scrollDirection: Axis.horizontal,
// itemBuilder: (context, index) {
// String universityImage = itemList[index]['image'].replaceAll('\\', '/');
// return Row(
// children: [
// Column(
// children: [
// MaterialButton(
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(10.0),
// ),
// elevation: 6.0,
// color: Colors.white,
// height: MediaQuery.of(context).size.height * 0.165,
// minWidth: MediaQuery.of(context).size.width * 0.400,
// onPressed: () {
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) => UniversityProfile(
// universityImage: '$imageUrl/$universityImage',
// universityID: itemList[index]['_id'],
// universityName: itemList[index]['university'],
// ),
// ),
// );
// },
// child: Column(
// children: [
// Hero(
// tag: itemList[index]['_id'],
// child: Container(
// width: MediaQuery.of(context).size.width * 0.200,
// height: MediaQuery.of(context).size.height * 0.120,
// decoration: BoxDecoration(
// image: DecorationImage(
// fit: BoxFit.contain,
// image: NetworkImage(
// '$imageUrl/$universityImage',),
// ),
// ),
// ),
// ),
// SizedBox(
// width: MediaQuery.of(context).size.width * 0.400,
// child: FittedBox(
// fit: BoxFit.fitWidth,
// child: Text(
// itemList[index]['university'],
// textAlign: TextAlign.center,
// style: Theme.of(context)
//     .textTheme
//     .headline2
//     ?.copyWith(color: Colors.grey),
// ),
// ),
// ),
// ],
// ),
// ),
// ],
// ),
// const SizedBox(
// width: 12.0,
// ),
// ],
// );
// },
// ),
// ),
