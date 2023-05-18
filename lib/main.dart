import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:sign_up/registration/screens/registration_form_screen.dart';
import 'package:sign_up/registration/services/mail_service_provider.dart';
import 'package:sign_up/registration/services/registration_provider.dart';
import 'package:sign_up/routes/routes.dart';
import 'package:sign_up/routes/routes_names.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  const defaultFirebaseOptions =  FirebaseOptions(
  apiKey: 'AIzaSyCh2m5v9MDN_pto_g5H3V22AHXwri5haqM',
  appId: '1:726833645656:android:f631469ebde64567cf622d',
  messagingSenderId: '726833645656',
  projectId: 'registrationapp-6bae9',
   authDomain: "registrationapp-6bae9.firebaseapp.com",
  databaseURL:
      'https://registrationapp-6bae9-default-rtdb.firebaseio.com',
  storageBucket: 'registrationapp-6bae9.appspot.com',
   measurementId: "G-MLSPJZM59S"
);

  await Firebase.initializeApp(options:defaultFirebaseOptions );
  
  runApp( RegistrationApp());
  
}

class RegistrationApp extends StatelessWidget {
  final RouteGenerator routeGenerator = RouteGenerator();

   RegistrationApp({super.key});
  @override
 
   Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        theme: ThemeData(appBarTheme: const AppBarTheme(color: Color(0xfffe4e59)),iconTheme: IconThemeData(color: Color(0xfffe4e59),),textTheme: TextTheme(titleMedium: TextStyle(color: Color(0xff385a64))),buttonTheme:ButtonThemeData(colorScheme:ColorScheme.light(background:Color(0xfffe4e59) )) ),
        title: 'Registration App',
        debugShowCheckedModeBanner: false,
        initialRoute: RouteNames.splashScreen,
        onGenerateRoute: routeGenerator.generateRoute,
      ),
    );
  }

    List<SingleChildWidget> get providers => [
       
         ChangeNotifierProvider(
          create: (_) => RegistrationProvider()),
            ChangeNotifierProvider(
          create: (_) => MailService()),
      
      ];

}


