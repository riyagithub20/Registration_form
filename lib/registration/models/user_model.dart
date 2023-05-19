import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
    String? firstName;
    String? lastname;
    String? dob;
    String? email;
    String? phoneno;

   UserModel({this.dob,this.email,this.lastname,this.firstName,this.phoneno});

 
 
   UserModel.fromJson(Map<String, dynamic> json) {
      firstName = json['first_name'];
      lastname = json['last_name'];
      dob = json['dob'];
      email = json['email'];
      phoneno = json['phone_no'];

    }

  
 Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (firstName != null) {
      data['first_name'] = firstName;
    }
     if (lastname != null) {
      data['last_name'] = lastname;
    }
     if (dob != null) {
      data['dob'] = dob;
    }
     if (firstName != null) {
      data['email'] = email;
    }
     if (firstName != null) {
      data['phone_no'] = phoneno;
    }
    return data;
  }

  
  

}