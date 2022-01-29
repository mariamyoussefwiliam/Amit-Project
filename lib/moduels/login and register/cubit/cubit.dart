import 'package:amit_project/models/login%20model.dart';
import 'package:amit_project/moduels/login%20and%20register/cubit/state.dart';
import 'package:amit_project/shared/component/constant.dart';
import 'package:amit_project/shared/network/end_points.dart';
import 'package:amit_project/shared/network/remote/dio-helper.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class LoginCubit extends Cubit<LoginStates> {

  LoginCubit() : super(InitLoginState());

  static LoginCubit get(context) => BlocProvider.of(context);

  LoginModel? model ;
  void UserLogin({required String email, required String password }) {
    emit(LoginLoadingState());
    DioHelper.postData(url: login, data: {
      'email':email,
      'password':password,

    })
        .then((value) {

      model = LoginModel.fromJson(value.data);
      print(model!.token);
      Token=model!.token;
      emit( LoginSuccessState(model!));

    })
        .catchError((onError) {
      print(onError.toString());
      emit(LoginErrorState(onError.toString()));
    });
  }
  void UserRegister({
    required String name,
    required String email,
    required String password
  }) {


    emit(RegisterLoadingState());
    DioHelper.postData(url: register, data: {
      'name':name,
      'email':email,
      'password':password,

    })
        .then((value) {
      print(value.data);
      model = LoginModel.fromJson(value.data);
     Token=model?.token;
      print(model?.token);
      emit( RegisterSuccessState(model!));

    })
        .catchError((onError) {
      print(onError.toString());
      emit(RegisterErrorState(onError.toString()));
    });
  }


void logOut()
{
  emit(LogOutState());
}
}