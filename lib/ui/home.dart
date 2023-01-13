import 'package:flutter/material.dart';
import 'package:flutter_wallpaperhub/ui/search.dart';
import 'package:flutter_wallpaperhub/widgets/appbar.dart';

import '../models/category_model.dart';
import '../widgets/category_tile.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CategoryModel? categoryModel;
  // List<News> newsModel = [];
  TextEditingController searchC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        // leading: Container(),
        backgroundColor: Colors.white,
        title: WallpaperAppBar(),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
           Container(
             margin: EdgeInsets.symmetric(horizontal: 24, vertical: 2),
             padding: EdgeInsets.symmetric(horizontal: 24, vertical: 5),
             decoration: BoxDecoration(
                 color: Color(0xfff5f8fd),
               borderRadius: BorderRadius.circular(30),
             ),
             child:  Row(
               children: [
                 Expanded(
                   child: TextFormField(
                     controller: searchC,
                     decoration: InputDecoration(
                         hintText: "search wallpaprs",
                         suffixIcon: IconButton(icon: Icon(Icons.search),
                           onPressed: (){
                             if (searchC.text != "") {
                               Navigator.push(
                                   context,
                                   MaterialPageRoute(
                                       builder: (context) => SearchView(
                                         search: searchC.text,
                                       )));
                             }
                           },),
                         border: InputBorder.none
                     ),

                   ),
                 )
               ],
             ),
           ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              height: 70,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categoryDetails.length,
                  itemBuilder: (context, index) {
                    return CategoryCard(
                      imageAssetUrl: categoryDetails[index].imageAssetUrl!,
                      categoryName: categoryDetails[index].categorieName!,
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
