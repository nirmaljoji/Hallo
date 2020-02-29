class User{
  final String uid;


  User({this.uid});
}

class UserData{
  String uid;
  String name;
  String status;
  String email;
  String phone;
  String imageUrl;
  String address;
  DateTime dob;

  UserData(
      {this.uid, this.name, this.status, this.email, this.phone, this.imageUrl, this.address, this.dob});



}

