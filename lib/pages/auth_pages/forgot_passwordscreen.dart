import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/auth_provider.dart';
import '../../routes/route_generator_constants.dart';
import '../../widgets/buttons/custom_elevatedbutton.dart';
import '../../widgets/colors/custom_colors.dart';
import '../../widgets/text/custom_text.dart';
import '../../widgets/textfield/custom_textfield.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {

  final _formState = GlobalKey<FormState>();
  AuthenticationProvider? authProvider;
  String email = '';

  resetPassword()async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: CustomColors.primaryColor,
          content: CustomText(
            text: 'Password Reset email has been sent !',
            color: Colors.white,
          ),
        ),
      );
    }on FirebaseAuthException catch(err){
      if(err.code == 'user not found'){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: CustomColors.primaryColor,
            content: CustomText(
              text: 'No user found for this email',
              color: Colors.white,
            ),
          ),
        );
      }
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(context),
    );
  }
  Widget _body(context){
    return Consumer<AuthenticationProvider>(
        builder: (context,authProvider,_) {
          return Form(
            key: _formState,
            child: Container(
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
                        text: 'Password Recovery',
                        color: Colors.black,
                        size: 32,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      CustomText(
                        text: 'Please Enter your Email.',
                        color: Colors.black,
                      ),
                    ],
                  ),
                  SizedBox(height: 64,),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFromFieldWithPrefixSuffix(
                          controller: authProvider.emailRecoveryTextEditingController,
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
                        CustomElevatedButton(
                          borderRadius: 32,
                          width: MediaQuery.of(context).size.width * 0.80,
                          onPressed: () {
                            if(_formState.currentState!.validate()){
                              setState(() {
                                email = authProvider.emailRecoveryTextEditingController.value.text;
                              });
                              resetPassword();
                            }
                          },
                          backgroundColor: CustomColors.primaryColor2,
                          widget: CustomText(
                            text: 'Send Email',
                            isContent: true,
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              text: 'Don\'t have an account ?',
                              isContent: true,
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            InkWell(
                              onTap: (){
                                Navigator.of(context).pushNamed(UserConstants.signUpPage);
                              },
                              child: CustomText(
                                text: 'Create',
                                isContent: true,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}
