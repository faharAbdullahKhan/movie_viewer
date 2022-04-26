import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:movie_viewer/UI/move_detail_page.dart';
// import 'package:http/http.dart';
import 'package:movie_viewer/Widget/big_text.dart';
import 'package:movie_viewer/Widget/small_text.dart';
import 'package:movie_viewer/bloc/movie_bloc/movie_bloc.dart';
import 'package:movie_viewer/bloc/movie_bloc/movie_event.dart';
import 'package:movie_viewer/bloc/movie_bloc/movie_state.dart';
import 'package:movie_viewer/utilities/colors.dart';
// import 'package:retrofit/http.dart';

import '../models/response/popularMovie_response.dart';

class PopularMoviePage extends StatefulWidget {
  const PopularMoviePage({Key? key}) : super(key: key);

  @override
  _PopularMoviePageState createState() => _PopularMoviePageState();
}

class _PopularMoviePageState extends State<PopularMoviePage> {
  MovieBloc? movieBloc;
  bool isTextField = false;
  List<Result> searchedMovieList = [];
  List<Result>? resultMovieList;

  static final TextEditingController _searchController = new TextEditingController();


  void navigationToMovieDetailPage(BuildContext context, Result movies ) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return MovieDetailPage(
        movies: movies,
      );
    }));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    movieBloc = BlocProvider.of<MovieBloc>(context);
    movieBloc?.add(FetchMovieEvent());


    // mResponse = fetchPopularMovieResponseAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        // toolbarOpacity: 0.5,

        backgroundColor: AppColors.blueColor,
        title: buildAppBarSearch(),
      ),
      body: Container(
        child: BlocListener<MovieBloc, MovieState>(
          listener: (context, state) {
            if (state is MovieErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.message),
              ));
            }
          },
          child: BlocBuilder<MovieBloc, MovieState>(builder: (context, state) {
            if (state is MovieInitialState) {
              return buildLoading();
            } else if (state is MovieLoadingState) {
              print("Loading state");
              return buildLoading();
            } else if (state is MovieLoadedState) {
              print("Loaded state");
              return buildMovieList(state.movies);
            } else if (state is MovieErrorState) {
              print("Error state");
              return buildErrorUI(state.message);
            } else {
              return Text("This");
            }
          }),
        ),
      ),
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildErrorUI(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          message,
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  Widget buildMovieList(List<Result> result) {
    // for(int i=0 ; i<result.length; i++){
    //   movieList.add(result[i].title);
    // }
    resultMovieList = result;
    print(resultMovieList);
    // movieList.length = result.length;
    return ListView.builder(
      itemCount: _searchController.text.isNotEmpty ? searchedMovieList.length : resultMovieList!.length,

      itemBuilder: (BuildContext context, int index) {
          // movieList.add(result[index].title);
          // print(movieList);
          return Column(
            children: [
              InkWell(
                child: ListTile(
                  horizontalTitleGap: 5,
                  leading: CircleAvatar(
                    radius: 18,
                    backgroundImage:
                        NetworkImage("https://image.tmdb.org/t/p/original"+ resultMovieList![index].posterPath),
                  ),
                  title: SmallText(

                    text: _searchController.text.isNotEmpty ? searchedMovieList[index].title : resultMovieList![index].title ,
                  ),

                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 10,
                    color: Colors.grey.shade400,
                  ),
                ),
                onTap: (){
                  navigationToMovieDetailPage(context, _searchController.text.isNotEmpty ? searchedMovieList[index]: resultMovieList![index]);
                },
              ),
              Divider(
                height: 0,
              ),
            ],
          );
        },

    );


  }

  onSearch(String search) {
    setState(() {
      print(search);
      searchedMovieList = resultMovieList!.where((element) => element.title.toLowerCase().contains(search)).toList();
    });
  }

  //App bar
  Widget buildAppBarSearch() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              isTextField ?
              Container(
                width: MediaQuery.of(context).size.width * 0.85,
                child: TextField(
                  onChanged: (value) {
                    onSearch(value);
                  },
                  controller: _searchController,
                  decoration: InputDecoration(
                      hintText: "Search here",
                      hintStyle: TextStyle(
                        color: Colors.grey.shade300,
                      )
                  ),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              )
                  : BigText(
                text: "Movie Viewer",
                color: Colors.white,
                size: 17,
              ),
              InkWell(child: isTextField ? Icon(Icons.cancel_outlined): Icon(Icons.search),
                onTap: () {
                _searchController.clear();
                searchedMovieList.clear();
                  setState(() {
                    _searchController.text = "";
                    if (isTextField == true) {
                      isTextField = false;
                    }else {
                      isTextField = true;
                    }


                  });

                },
              ),
            ],
          ),
        ),
      ],
    );
  }


}
