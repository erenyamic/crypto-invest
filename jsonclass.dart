class vt{
  String balance;
  String email;
  String name;
  String password;
  vt(this.balance,this.email,this.name,this.password);
  factory vt.fromJson(Map<dynamic,dynamic> json){
  return vt(json["balance"] as String,json["email"] as String,json["name"] as String,json["password"] as String);
  }

}