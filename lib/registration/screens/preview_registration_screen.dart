import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:sign_up/registration/services/registration_provider.dart';

class PreviewRegistration extends StatefulWidget {
  const PreviewRegistration({super.key});

  @override
  State<PreviewRegistration> createState() => _PreviewRegistrationState();
}

class _PreviewRegistrationState extends State<PreviewRegistration> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<RegistrationProvider>().fetchData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Welcome Riya"),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text("You Have Successfully Registered with us"),


          Text("riya"),
           Text("riya"),

            Text("riya"),
             Text("riya")

          ],
        ),
      ),
    );
  }
}