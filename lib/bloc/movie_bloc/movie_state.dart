import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:movie_viewer/models/response/popularMovie_response.dart';
import 'package:meta/meta.dart';

abstract class MovieState extends Equatable {
}

class MovieInitialState extends MovieState{
  @override
  // TODO: implement props
  List<Object> get props => [];

}

class MovieLoadingState extends MovieState{
  @override
  // TODO: implement props
  List<Object> get props => [];

}

class MovieLoadedState extends MovieState {

  List<Result> movies;
  MovieLoadedState({required this.movies});
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}

class MovieErrorState extends MovieState {

  String message;
  MovieErrorState({required this.message});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();


}