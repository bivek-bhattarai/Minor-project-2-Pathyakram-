import 'package:flutter/material.dart';
import '../../University Profile Screen/university_profile.dart';

class CustomSearchDelegate extends SearchDelegate {
  CustomSearchDelegate({required this.universityData});
  final Map universityData;
  String imageUrl = 'http://10.0.2.2:3001';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back_rounded),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Map> matchQuery = [];
    for (var university in universityData['universities']) {
      if (university['university'].toLowerCase().contains(
        query.toLowerCase(),
      )) {
        matchQuery.add(university);
      }
    }

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        int currentIndex = universityData['universities']
            .indexWhere((item) => item == matchQuery[index]);
        String universityImage = universityData['universities'][currentIndex]
        ['image']
            .replaceAll('\\', '/');
        String universityName = universityData['universities'][currentIndex]['university'];
        String universityID = universityData['universities'][currentIndex]['_id'];
        return ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UniversityProfile(
                  universityName: universityName,
                  universityID: universityID,
                  universityImage: '$imageUrl/$universityImage',
                ),
              ),
            );
          },
          title: Text(universityName),
        );
      },
    );

  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Map> matchQuery = [];
    for (var university in universityData['universities']) {
      if (university['university'].toLowerCase().contains(
            query.toLowerCase(),
          )) {
        matchQuery.add(university);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        int currentIndex = universityData['universities']
            .indexWhere((item) => item == matchQuery[index]);
        String universityImage = universityData['universities'][currentIndex]
                ['image']
            .replaceAll('\\', '/');
        String universityName = universityData['universities'][currentIndex]['university'];
        String universityID = universityData['universities'][currentIndex]['_id'];
        return ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UniversityProfile(
                    universityName: universityName,
                    universityID: universityID,
                    universityImage: '$imageUrl/$universityImage',
                ),
              ),
            );
          },
          title: Text(universityName),
        );
      },
    );
  }
}

