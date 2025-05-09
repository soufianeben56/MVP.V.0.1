class LoginRequestModel {
  String? username;
  String? password;
  String? pushToken;


  LoginRequestModel({
    this.username,
    this.password,
    this.pushToken,
  });

  LoginRequestModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    pushToken = json['pushToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['password'] = password;
    data['pushToken'] = pushToken;
    return data;
  }
}
