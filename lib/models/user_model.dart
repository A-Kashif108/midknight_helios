class MyUser{
  final String first_name;
  final String last_name;
  final int id;
  final String  gender;
  final String  interested;
  final String password;
  final String email;
  final String url;



  MyUser(this.first_name, this.last_name, this.id, this.gender, this.interested, this.password, this.url, this.email);

  MyUser.fromJSON(Map<String, dynamic> json):
      first_name=json['first_name'],
      last_name=json['last_name'],
      id=json['id'],
      gender=json['gender'],
      interested=json['interested'],
      password=json['password'],
      email=json['email'],
      url=json['url'];
  Map<String, dynamic> toJson() => {
  'first_name':first_name,
  'last_name':last_name,
  'id':id,
  'gender':gender,
  'interested':interested,
  'password':password,
  'email':email,
  'url':url,


  };




}