import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:movie_viewer/bloc/movie_bloc/movie_event.dart';
import 'package:movie_viewer/bloc/movie_bloc/movie_state.dart';
import 'package:movie_viewer/models/response/popularMovie_response.dart';
import 'package:movie_viewer/repositories/result_respository.dart';
import 'package:meta/meta.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieRepository? repository;

  MovieBloc({@required this.repository}) : super(MovieInitialState());
  // MovieBloc(super.initialState,{this.repository});

  // MovieBloc( {required this.repository});

  // MovieBloc({super.initialState,@required this.repository}) {
  //   // TODO: implement
  //   throw UnimplementedError();
  // }

  @override
  // TODO: implement initialState
  MovieState get initialState => MovieInitialState();

  @override
  Stream<MovieState> mapEventToState(MovieEvent event) async* {
    if (event is FetchMovieEvent) {
      yield MovieLoadingState();

      try {
        List<Result>? movies = await repository?.getResult();
        yield MovieLoadedState(movies: movies!);
      } catch (e) {
        yield MovieErrorState(message: e.toString());
      }
    }
  }
}
