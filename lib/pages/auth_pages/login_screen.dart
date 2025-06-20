import 'dart:convert';
import 'dart:core';
import 'package:cloudinary_url_gen/transformation/region.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../classes/secure_storage.dart';
import '../../const.dart';
import '../../provider/auth_provider/auth_provider.dart';
import '../../routes/route_generator_constants.dart';
import '../../services/auth.dart';
import '../../widgets/buttons/custom_elevatedbutton.dart';
import '../../widgets/colors/custom_colors.dart';
import '../../widgets/container/custom_container.dart';
import '../../widgets/text/custom_text.dart';
import '../../widgets/textfield/custom_textfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isChecked = false;
  final _formState = GlobalKey<FormState>();
  AuthenticationProvider? authProvider;


  late SharedPreferences prefs;

  void initSharedPref() async{
    prefs = await SharedPreferences.getInstance();
  }

  void  login () async {
    AuthenticationProvider authProvider = Provider.of<AuthenticationProvider>(context, listen: false);

    final Url = 'http://localhost:3000/api/auth/login';

    Map<String,dynamic> body = {
      // "email":"ansarifarhan2316@gmail.com",
      // "pwd":"ansariFarhan",
      "email": authProvider.userEmailTextEditingController.text.trim(),
      "pwd":authProvider.userPasswordTextEditingController.value.text,
    };

    var response = await http.post(Uri.parse(Url),
        headers: {
          'Content-Type': 'Application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode(body));
    final decodedBody = jsonDecode(response.body);
    print(decodedBody);
    if(response.statusCode == 200){
      accessToken = decodedBody["token"];
      userName = decodedBody["user"]["name"];
      userId = decodedBody["user"]["_id"];
      // print(userName);
      await SessionController.instance.saveSession(accessToken, userId,userName);
      authProvider.setName(userName);
      print(authProvider.userName);
      Navigator.of(context).pushNamed(UserConstants.userDashboard);
      // Navigator.push(context, MaterialPageRoute(builder: (context) => CustomerScreen()));
      //ansarifarhan2316@gmail.com
      //ansariFarhan
      //physician
      //opthalmologist
      //pediatrician
      //onocologist
    }
    print(response.statusCode);
    print(response.body);
    print(userId);
    // print(body);
  }

  @override
  void initState() {
    super.initState();
    authProvider = Provider.of<AuthenticationProvider>(context, listen: false);
    initSharedPref();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(context),
    );
  }

  Widget _body(context) {
    return Consumer<AuthenticationProvider>(
        builder: (context, authProvider, _) {
          return Container(
            width: MediaQuery.of(context).size.width * 1,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    CustomColors.primaryColor,
                    CustomColors.midColor,
                    CustomColors.primaryColor,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    CustomText(
                      text: 'Welcome Back',
                      color: Colors.black,
                      size: 32,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    CustomText(
                      text: 'Please Enter your Details To Login.',
                      color: Colors.black,
                    ),
                  ],
                ),
                SizedBox(height: 64,),
                CustomContainer(
                  horizontalMargin: 16,
                  horizontalPad: 24,
                  glassEffect: true,
                  height: 0.36,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height * 0.5,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: 'Login',
                          size: 24,
                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        TextFromFieldWithPrefixSuffix(
                          controller: authProvider.userEmailTextEditingController,
                          // fillColor: Colors.black,
                          glassEffect: true,
                          hintText: 'Enter your Email',
                          blurAmount: 4.0,
                          glassOpacity: 0.4,
                          borderColor: Colors.white, // Default border color
                          focusedBorderColor: Colors.blue, // Color when focused
                          enabledBorderColor: Colors.grey, // Color when enabled
                          errorBorderColor: Colors.red,
                          borderRadius: 16,
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.grey.shade600,
                          ),
                          validator: (value) {
                            String pattern =
                                r'^[a-zA-Z]{3,}(?:\.[a-zA-Z]{2,})?@[a-zA-Z]{2,}\.[a-zA-Z]{2,}$';
                            RegExp regex = RegExp(pattern);
                            return value!.isEmpty ? 'Email is Required' : null;
                          },
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        TextFromFieldWithPrefixSuffix(
                          controller: authProvider.userPasswordTextEditingController,
                          obscure: authProvider.obscure,
                          glassEffect: true,
                          hintText: '••••••',
                          blurAmount: 5.0,
                          glassOpacity: 0.4,
                          borderColor: Colors.white, // Default border color
                          focusedBorderColor: Colors.blue, // Color when focused
                          enabledBorderColor: Colors.grey, // Color when enabled
                          errorBorderColor: Colors.red,
                          borderRadius: 16,
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.grey.shade600,
                          ),
                          applySuffixIcon: true,
                          suffixIcon: InkWell(
                            onTap: () {
                              authProvider.toggleObscure();
                            },
                            child: Icon(
                              authProvider.obscure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          validator: (value) {
                            return value!.isEmpty ? 'Password required' : null;
                          },
                        ),
                        Row(
                          children: [
                            Checkbox(
                                value: authProvider.rememberMe,
                                onChanged: (value) {
                                  authProvider.toggleRememberMe(value!);

                                }),
                            CustomText(
                              text: 'Remember me',
                              isContent: true,
                            ),
                            Spacer(),
                            InkWell(
                              onTap: (){
                                Navigator.of(context).pushNamed(UserConstants.forgotPasswordPage);
                              },
                              child: CustomText(
                                text: 'Forgot Password ?',
                                isContent: true,
                              ),
                            ),
                          ],
                        ),
                        CustomElevatedButton(
                          borderRadius: 32,
                          width: MediaQuery.of(context).size.width * 0.80,
                          onPressed: () async{
                            authProvider.setName(userName);
                            // Navigator.of(context).pushNamed(UserConstants.userDashboard);
                            login();
                            final session = SessionController.instance;
                            // session.setSession(userId, accessToken, DateTime.timestamp());
                            // print('hello');
                          },
                          backgroundColor: CustomColors.primaryColor2,
                          widget: CustomText(
                            text: 'Login',
                            isContent: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text: 'Don\'t have an account yet? ',
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    InkWell(
                      onTap: () {
                        // login();
                        print('not working');
                        Navigator.of(context).pushNamed(UserConstants.signUpPage);
                      },
                      child: CustomText(
                        text: 'Sign Up',
                        color: Colors.white,
                        isContent: true,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}