class Shipping{
  int id;
  String name;
  String email;
  String address;

  toJson(){
    return {
      'ID' : id.toString(),
      'CUST_NAME' : name,
      'EMAIL' : email,
      'ADDRESS' : address
    };
  }
}