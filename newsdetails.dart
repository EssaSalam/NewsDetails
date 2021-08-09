import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../Classes/imagecontrol.dart';
import '../Classes/styleandvariable.dart';
import '../Modules/post.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:provider/provider.dart';

class NewsDetails extends StatefulWidget {
  const NewsDetails({Key? key}) : super(key: key);
  static String newsDetailsScreen =
      "/newsDetailsScreen"; //this variable is routes of page to called from any page

  @override
  _NewsDetailsState createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  @override
  Widget build(BuildContext context) {
    Post arg = ModalRoute.of(context)!.settings.arguments
        as Post; //argument that was passing from mainPage
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          StyleAndText.arabicLanguage[22],
          style: Theme.of(context).textTheme.bodyText1,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_outlined,
            color: Theme.of(context).primaryColorDark,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Container(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  //first container is title of post
                  Container(
                    child: Text(
                      arg.title!,
                      style: Theme.of(context).textTheme.bodyText1,
                      textAlign: TextAlign.center,
                    ),
                  ),

                  Divider(
                    thickness: 1.0,
                  ),

                  //second container content details of post
                  Container(
                    child: Text(
                      arg.detail!,
                      style: Theme.of(context).textTheme.headline3,
                      textAlign: TextAlign.center,
                      
                    ),
                  ),

                  Divider(
                    thickness: 1.0,
                  ),

                  //CarouselSlider if post have images
                  arg.imageList!.isNotEmpty
                      ? CarouselSlider(
                          items: List.generate(
                              arg.imageList!.length,
                              (index) => Container(
                                    width: double.infinity,
                                    margin: EdgeInsets.symmetric(horizontal: 8),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                            ImageControl.imageControlScreen,
                                            arguments: arg.imageList);
                                      },
                                      child: Container(
                                        child: Image.network(
                                          arg.imageList![index],
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  )),
                          options: CarouselOptions(
                            height: 200,
                            enlargeCenterPage: true,
                            initialPage: 0,
                          ))
                      : SizedBox.shrink(),

                  //this row at end of page to put buttons as favorite button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          margin: EdgeInsets.only(top: 20),
                          child: StarButton(
                            isStarred: arg.isFavorite,
                            valueChanged: (_isStarred) {
                              Provider.of<Posts>(context, listen: false)
                                  .checkFavorite(arg, _isStarred);
                              print(Provider.of<Posts>(context, listen: false)
                                  .postList[
                                      Provider.of<Posts>(context, listen: false)
                                          .postList
                                          .indexOf(arg)]
                                  .isFavorite);
                            },
                          ))
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
