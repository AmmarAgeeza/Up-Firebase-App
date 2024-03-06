part of 'home_cubit.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}
class GetDateLoadingState extends HomeState {}
class GetDateErrorState extends HomeState {}
class GetDateSucessState extends HomeState {}
class AddDonatorLoadingState extends HomeState {}
class AddDonatorSucessfulltyState extends HomeState {
   final String message;

  AddDonatorSucessfulltyState({required this.message});
}
class AddDonatorErrorState extends HomeState {
  final String message;

  AddDonatorErrorState({required this.message});
}
class DecreaseBagsNumbersLoadingState extends HomeState {}
class DecreaseBagsNumbersSucessfulltyState extends HomeState {
   final String message;

  DecreaseBagsNumbersSucessfulltyState({required this.message});
}
class DecreaseBagsNumbersErrorState extends HomeState {
  final String message;

  DecreaseBagsNumbersErrorState({required this.message});
}