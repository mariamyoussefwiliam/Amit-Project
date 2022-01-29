class LoginModel {

  String? token;

  LoginModel.fromJson(Map<String, dynamic> json)
  {
    token=json['token'];
  }
}
