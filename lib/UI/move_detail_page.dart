import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:movie_viewer/Widget/big_text.dart';
import 'package:movie_viewer/Widget/small_text.dart';
import 'package:movie_viewer/models/response/popularMovie_response.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../utilities/colors.dart';

class MovieDetailPage extends StatelessWidget {
  Result? movies;

  MovieDetailPage({Key? key, this.movies}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.1162,
            color: AppColors.blueColor,
            child: Padding(
              padding: const EdgeInsets.only(top: 60, left: 8),
              child: Row(
                children: [
                  InkWell(
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 25,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  BigText(
                      text: movies!.originalTitle,
                      color: AppColors.appBarFontColor,
                      size: 17)
                ],
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.86,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.65,
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.6,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                image: DecorationImage(
                                  image: NetworkImage("https://image.tmdb.org/t/p/original"+ movies!.posterPath),
                                  fit: BoxFit.cover,
                                )),

                            // child: Image.asset("assets/images/food001.png", fit: BoxFit.fill,),
                          ),
                        ),
                        Positioned(
                          bottom: 5,
                          left: 40,
                          // top: 510,
                          child: Stack(
                            children: [
                              Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  color: Color(0xFF042541),
                                  borderRadius: BorderRadius.all(Radius.circular(100)),
                                ),
                              ),
                              Positioned(
                                top: 5,
                                left: 5,
                                child: CircularPercentIndicator(
                                  radius: 25,
                                  progressColor: AppColors.circularMeterColor,
                                  lineWidth: 3.0,
                                  animation: true,
                                  backgroundColor: AppColors.blueColor,
                                  percent: movies!.voteAverage/10,
                                  circularStrokeCap: CircularStrokeCap.round,
                                ),
                              ),
                              Positioned(
                                  top: 23,
                                  left: 15,
                                  child: Text(((movies!.voteAverage*10).toInt()).toString() + "%",style: TextStyle(color: Colors.white),)),

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(movies!.overview),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
