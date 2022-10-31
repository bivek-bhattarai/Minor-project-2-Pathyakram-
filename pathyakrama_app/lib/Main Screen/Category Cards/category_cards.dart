import 'package:flutter/material.dart';

class CategoryCards extends StatelessWidget {
  const CategoryCards(
      {Key? key,
        required this.categoryTitle,
        required this.categoryIcon,
        required this.onPressed})
      : super(key: key);
  final IconData categoryIcon;
  final String categoryTitle;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return MaterialButton(
      onPressed: onPressed,
      color: Colors.white,
      height: height * 0.150,
      minWidth: width * 0.29,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 6.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: width * 0.067,
            backgroundColor: const Color(0xffBAE9F9),
            child: Icon(
              categoryIcon,
              size: width * 0.0860,
              color: Theme.of(context).primaryColor,
            ),
          ),
          Text(
            categoryTitle,
            style: Theme.of(context)
                .textTheme
                .headline2
                ?.copyWith(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}