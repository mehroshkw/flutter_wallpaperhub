import 'package:flutter/material.dart';

class SearchView extends StatefulWidget {
  String search;
   SearchView({required this.search});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("hiiiiiii"),),
    );
  }
}
