import 'package:flutter/material.dart';
import 'package:flutter_wallpaperhub/ui/search.dart';
import 'package:flutter_wallpaperhub/ui/wallpaper_view.dart';
import 'package:flutter_wallpaperhub/widgets/appbar.dart';
import 'package:url_launcher/url_launcher.dart';

import '../api_services/photos_service.dart';
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

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    PhotosService().getApi();
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0.0,
        // leading: Container(),
        backgroundColor: Colors.white,
        title: WallpaperAppBar(),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
             Container(
               margin: EdgeInsets.symmetric(horizontal: 18, vertical: 2),
               padding: EdgeInsets.symmetric(horizontal: 16, vertical: 3),
               decoration: BoxDecoration(
                   color: const Color(0xfff5f8fd),
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
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                height: height/1.43,
                child: FutureBuilder(
                future: PhotosService().getApi(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            // print(snapshot.data!.photos!.length);
                            // print(snapshot.data!.status);
                            return GridView.builder(
                                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 200,
                                    childAspectRatio: 1.3 / 2,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 5),
                                itemCount: snapshot.data!.photos!.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (context) => ImageView(
                                             imgPath: '${snapshot.data!.photos![index]!.src!.portrait}',
                                          )
                                      ));
                                    },
                                    child: Container(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.network("${snapshot.data!.photos![index]!.src!.portrait}",
                                        fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Text("Wallpapers Provided by: www.pexels.com",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 12
                  ),
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     _launchURL("https://www.pexels.com/");
                  //   },
                  // child: Text("Pexels.com"),
                  // ),
                ],),
            ],
          ),
        ),
      ),
    );
  }
}
