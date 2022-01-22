import 'package:amit_project/moduels/cartScreen.dart';
import 'package:amit_project/moduels/categoryScreen.dart';
import 'package:amit_project/moduels/homeScreen.dart';
import 'package:amit_project/moduels/menuScreen.dart';
import 'package:amit_project/shared/cubit/states.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  var screens = [
    HomeScreen(),
    CategoryScreen(),
    CartScreen(),
    MenuScreen(),
  ];
  int index = 0;

  void changeIndex(int currentIndex) {
    index = currentIndex;
    emit(ChangeIndexState());
  }

  int login = 0;

  void swapBetweenLoginAndRegister(current) //login index 0 register index 1
  {
    login = current;
    emit(SwapBetweenLoginAndRegisterState());
  }
}
