
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:sign_up/registration/services/registration_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class PreviewRegistration extends StatefulWidget {
  final String userId;
  final String url;
  const PreviewRegistration({super.key, required this.userId,required this.url});

  @override
  State<PreviewRegistration> createState() => _PreviewRegistrationState();
}

class _PreviewRegistrationState extends State<PreviewRegistration> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
            future:
                context.read<RegistrationProvider>().fetchData(widget.userId),
            builder: (context, snapshot) {
              final provider = context.read<RegistrationProvider>();
              return SingleChildScrollView(

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      "assets/image/5907.jpg",
                      fit: BoxFit.contain,
                    ),
              
              
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color(0xfffe4e59),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              TextFormField(
                                enabled: false,
                                readOnly: true,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                                decoration: textField(
                                    provider,
                                    provider.userDetails.firstName.toString(),
                                    const Icon(
                                      Icons.person,
                                      color: Colors.white
                                    )),
                              ),
                              const SizedBox(height: 16.0),
                               TextFormField(
                                 enabled: false,
                                readOnly: true,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                                decoration: textField(
                                    provider,
                                    provider.userDetails.lastname.toString(),
                                    const Icon(
                                      Icons.person,
                                     color: Colors.white
                                    )),
                              ),
                              const SizedBox(height: 16.0),
                               TextFormField(
                                 enabled: false,
                                readOnly: true,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                                decoration: textField(
                                    provider,
                                    provider.userDetails.dob.toString(),
                                    const Icon(
                                      Icons.calendar_month,
                                      color: Colors.white
                                    )),
                              ),
                              const SizedBox(height: 16.0),
                               TextFormField(
                                 enabled: false,
                                readOnly: true,
                                style: const TextStyle(
                                 color: Colors.white
                                ),
                                decoration: textField(
                                    provider,
                                    provider.userDetails.email.toString(),
                                    const Icon(
                                      Icons.email,
                                     color: Colors.white
                                    )),
                              ),
                              const SizedBox(height: 16.0),
                               TextFormField(
                                 enabled: false,
                                readOnly: true,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                                decoration: textField(
                                    provider,
                                    provider.userDetails.phoneno.toString(),
                                    const Icon(
                                      Icons.phone_android,
                                     color: Colors.white
                                    )),
                              ),
                              const SizedBox(height: 16.0),
                               InkWell(
                                onTap: () {
                                  launchUrl(Uri(path: widget.url));
                                },
                                 child: TextFormField(
                                   enabled: false,
                                  readOnly: true,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                  decoration: textField(
                                      provider,
                                     widget.url.split("/").last,
                                      const Icon(
                                        Icons.file_download,
                                       color: Colors.white
                                      )),
                                                             ),
                               ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          )),
    );
  }

  InputDecoration textField(
      RegistrationProvider provider, String text, Widget icon) {
    return InputDecoration(
      labelText: text,
      prefixIcon: icon,
      labelStyle: const TextStyle(
        color: Colors.white,
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white,
          width: 2.0,
        ),
      ),
      disabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white,
          width: 2.0,
        ),
      ),
      focusedBorder:const  OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white,
          width: 2.0,
        ),
      ),
    );
  }
}
