import 'package:flutter/material.dart';
import 'package:flutter_wallpaperhub/api_services/catergory_service.dart';
import 'package:flutter_wallpaperhub/ui/wallpaper_view.dart';

import '../widgets/appbar.dart';

class CategorieScreen extends StatefulWidget {
  String category;
  CategorieScreen({required this.category});

  @override
  State<CategorieScreen> createState() => _CategorieScreenState();
}

class _CategorieScreenState extends State<CategorieScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
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
              padding: EdgeInsets.symmetric(horizontal: 16),
              height: height/1.16,
              child: FutureBuilder(
                  future: CategoryService().getCatApi(widget.category),
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
    );
  }
}
