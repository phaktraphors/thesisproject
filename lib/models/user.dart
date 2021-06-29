class User {
  int id;
  String username;
  String email;
  String password;

  toJson(){
    return {
      'id' : id.toString(),
      'username' : username,
      'email' : email,
      'password' : password,
    };
  }
}