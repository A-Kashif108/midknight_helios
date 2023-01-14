class MyUser{
  final String first_name;
  final String last_name;
  final String? id;
  final String  gender;
  final String  interested;
  final String password;
  final String email;
  final String url;



  MyUser({required this.first_name,required this.last_name, this.id,required this.gender, 
  required this.interested,required this.password,required this.url,required this.email});

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