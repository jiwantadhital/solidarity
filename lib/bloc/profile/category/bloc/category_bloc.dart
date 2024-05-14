import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:solidarity/data/controller/profile_controller.dart';
import 'package:solidarity/data/model/profile/network_model.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  ProfileCOntroller profileCOntroller = ProfileCOntroller();
  CategoryBloc() : super(CategoryInitial()) {

    on<CategoryGettingEvent>((event, emit) async{
      emit(CategoryLoading());
      try{
        var data = await profileCOntroller.getCategory();
        if(data.status == "ok"){
          emit(Categoryloaded(categoryModel: data));
        }
        else{
          emit(CategoryError(message: data.message.toString()));
        }
      }
      catch(e){
          emit(CategoryError(message: "Something went wrong"));

      }
    });
  }
}
