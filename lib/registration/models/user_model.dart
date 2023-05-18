import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
   final String? firstName;
   final String? lastname;
   final DateTime? dob;
   final String? email;
   final String? phoneno;

   UserModel({this.dob,this.email,this.lastname,this.firstName,this.phoneno});


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