import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sign_up/registration/screens/preview_registration_screen.dart';
import 'package:sign_up/registration/services/mail_service_provider.dart';
import 'package:sign_up/registration/services/registration_provider.dart';
import 'package:sign_up/registration/widgets/snackbar.dart';

import '../../routes/routes_names.dart';
import '../models/user_model.dart';
import '../widgets/loader.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';
  String _password = '';
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  DateTime? _selectedDate;
  String? _errorText;
  String? filePath; // Variable to store the selected file path
  PlatformFile? fileSelected;
  Future<void> _openFileExplorer() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );

    if (result != null) {
      setState(() {
        fileSelected = result.files[0];
        filePath = result.files.single.path!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Return false to disable going back
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Registration Form'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    "assets/image/Mobile-login.jpg",
                    fit: BoxFit.contain,
                  ),
    
                  ///First Name field
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(10), // Rounded border radius
                        color: Colors.grey[200],
                      ),
                      child: TextFormField(
                        controller: firstName,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          labelText: 'First Name',
                          labelStyle: TextStyle(color: Color(0xfffe4e59)),
                          prefixIcon: Icon(
                            Icons.person,
                            color: Color(0xfffe4e59),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your First name';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _name = value!;
                        },
                      ),
                    ),
                  ),
    
                  ///Last Name Text Field
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(10), // Rounded border radius
                        color: Colors.grey[200],
                      ),
                      child: TextFormField(
                        controller: lastName,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Last Name',
                          labelStyle: TextStyle(color: Color(0xfffe4e59)),
                          prefixIcon: Icon(
                            Icons.person,
                            color: Color(0xfffe4e59),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your Last Name';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _name = value!;
                        },
                      ),
                    ),
                  ),
    
                  ///DATE OF BIRTH TEXT FIELD
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(10), // Rounded border radius
                        color: Colors.grey[200],
                      ),
                      child: TextFormField(
                         validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter Date of Birth';
                          }
                          return null;
                        },
                        readOnly: true,
                        onTap: () {
                          DatePicker.showDatePicker(
                            context,
                            showTitleActions: true,
                            minTime: DateTime(1900),
                            maxTime: DateTime.now(),
                            onConfirm: (date) {
                              setState(() {
                                _selectedDate = date;
    
                                // dateController.text =
                                //     _selectedDate.toString().split(' ')[0];
                                _errorText = validateDate(_selectedDate!);
                                dateController.text = DateFormat('dd MMMM yyyy')
                                    .format(_selectedDate!);
                              });
                            },
                            currentTime: _selectedDate,
                          );
                        },
                        controller: dateController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Date Of Birth',
                          labelStyle: const TextStyle(color: Color(0xfffe4e59)),
                          prefixIcon: const Icon(
                            Icons.calendar_today,
                            color: Color(0xfffe4e59),
                          ),
                          suffixIcon: const Icon(
                            Icons.calendar_month_rounded,
                            color: Color(0xfffe4e59),
                          ),
                          errorText: _errorText,
                        ),
                      ),
                    ),
                  ),
    
                  ///EMAIL TEXT FIELD
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(10), // Rounded border radius
                        color: Colors.grey[200],
                      ),
                      child: TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Color(0xfffe4e59)),
                          prefixIcon: Icon(
                            Icons.email,
                            color: Color(0xfffe4e59),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter an email';
                          }
                          if (!isEmailValid(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
    
                  ///PHONE NUMBER TEXT FIELD
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(10), // Rounded border radius
                        color: Colors.grey[200],
                      ),
                      child: TextFormField(
                        controller: _phoneNumberController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Phone Number',
                          labelStyle: TextStyle(color: Color(0xfffe4e59)),
                          prefixIcon: Icon(
                            Icons.phone,
                            color: Color(0xfffe4e59),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a phone number';
                          }
                          if (!isPhoneNumberValid(value)) {
                            return 'Please enter a valid phone number';
                          }
                            if (!validatePhoneNumber(value)) {
                            return 'Phone number should be 10 digits';
                          }
    
                          return null;
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Text("Upload Resume",style: TextStyle(  color: Color(0xfffe4e59),fontSize: 16,fontWeight: FontWeight.bold ),),
                   const SizedBox(height: 16.0),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        SizedBox(
                            height: 50,
                            width: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                _openFileExplorer();
                              },
                              child: Icon(Icons.file_copy_outlined),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xfffe4e59),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  )),
                            )),
                        const SizedBox(height: 16),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                            width: 200,
                            child: Text(
                              filePath?.split("/").last ?? "NO FILE SELECTED",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            )),
                      ],
                    ),
                  ),
    
                  Center(
                    child: ElevatedButton(
                      onPressed:() async {
    _formKey.currentState!.validate();
                        if(fileSelected==null  ){
                           ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Upload resume to register"),
                                backgroundColor:
                                    Colors.orange, // Custom background color
                                elevation: 8.0),
                          );
                        }

                        else if (_formKey.currentState!.validate()  && fileSelected!=null) {
                          _formKey.currentState!.save();
                          OrangeLoaderOverlay.show(context);
                          UserModel userModel = UserModel(
                              dob: dateController.text,
                              email: emailController.text,
                              firstName: firstName.text,
                              lastname: lastName.text,
                              phoneno: _phoneNumberController.text);
                          if (await context
                              .read<RegistrationProvider>()
                              .register(userModel, File(fileSelected!.path!))) {
                            context
                                .read<MailService>()
                                .sendEmail(emailController.text);
                          }
    
                          OrangeLoaderOverlay.hide();
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Registration successfull"),
                                backgroundColor:
                                    Colors.orange, // Custom background color
                                elevation: 8.0),
                          );
    
                          // ignore: use_build_context_synchronously
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PreviewRegistration(
                                    userId: _phoneNumberController.text,
                                    url: fileSelected!.path!)),
                          );
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xfffe4e59)), // Set the background color
                        foregroundColor: MaterialStateProperty.all<Color>(
                            Colors.white), // Set the text color
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10.0), // Set the border radius
                          ),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(18.0),
                        child: Text('REGISTER'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  ///VALIDATIONS FOR THE TEXT FIELDS
  validateDate(DateTime selectedDate) {
    final currentDate = DateTime.now();
    final validDate =
        DateTime(currentDate.year - 18, currentDate.month, currentDate.day);

    if (selectedDate.isAfter(validDate)) {
      return 'You must be at least 18 years old.';
    }

    return null;
  }
   
  bool isEmailValid(String email) {
    final emailRegex = RegExp(
        r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$');
    return emailRegex.hasMatch(email);
  }

  bool isPhoneNumberValid(String phoneNumber) {
    final phoneNumberRegex = RegExp(r'^\+?[0-9]{8,}$');
    return phoneNumberRegex.hasMatch(phoneNumber);
  }

  bool validatePhoneNumber(String phoneNumber) {
    RegExp regex = RegExp(r'^[0-9]{10}$');

    if (regex.hasMatch(phoneNumber)) {
      return true; // Phone number is valid
    }

    return false; // Phone number is invalid
  }

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      final email = emailController.text;
      final phoneNumber = _phoneNumberController.text;
    }
  }
}
