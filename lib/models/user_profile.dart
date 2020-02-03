class User_Profile {

  String user_name;
  String user_status;
  String user_email;
  String user_phone;

  User_Profile(String u, String s, String p, String e) {
    this.user_name = u;
    this.user_status = s;
    this.user_email = e;
    this.user_phone = p;
  }

  String getUser_name() {
    return user_name;
  }

  Map<String, dynamic> toMap() {
    return {
      'name': user_name,
      'status': user_status,
      'email': user_email,
      'phone': user_phone,
    };
  }
}