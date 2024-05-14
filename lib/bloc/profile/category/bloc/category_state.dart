part of 'category_bloc.dart';

sealed class CategoryState extends Equatable {
  const CategoryState();
  
  @override
  List<Object> get props => [];
}

 class CategoryInitial extends CategoryState {}
 class CategoryLoading extends CategoryState {}
 class Categoryloaded extends CategoryState {
  CategoryModel categoryModel;
  Categoryloaded({required this.categoryModel});
 }
 class CategoryError extends CategoryState {
  String message;
  CategoryError({required this.message});
 }

