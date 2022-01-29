
import 'package:amit_project/models/login%20model.dart';

abstract class LoginStates
{

}
class InitLoginState extends LoginStates
{

}

class LoginLoadingState extends LoginStates
{

}
class LoginSuccessState extends LoginStates
{
  final LoginModel model;

  LoginSuccessState(this.model);
}
class LoginErrorState extends LoginStates
{
  final String error;
  LoginErrorState(this.error);

}



class RegisterLoadingState extends LoginStates
{

}
class RegisterSuccessState extends LoginStates
{
  final LoginModel model;

  RegisterSuccessState(this.model);
}
class RegisterErrorState extends LoginStates
{
  final String error;
  RegisterErrorState(this.error);

}
class LogOutState extends  LoginStates{}