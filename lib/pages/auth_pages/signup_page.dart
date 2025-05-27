import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/auth_provider/auth_provider.dart';
import '../../routes/route_generator_constants.dart';
import '../../widgets/buttons/custom_elevatedbutton.dart';
import '../../widgets/colors/custom_colors.dart';
import '../../widgets/container/custom_container.dart';
import '../../widgets/text/custom_text.dart';
import '../../widgets/textfield/custom_textfield.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool isChecked = false;
  String email = '';
  String name = '';
  String password = '';
  AuthenticationProvider? authProvider;
  final _formState = GlobalKey<FormState>();

  registration() async {
    authProvider = Provider.of<AuthenticationProvider>(context, listen: false);
    if (password != null && authProvider?.signUpNameTextEditingController.text !="" &&authProvider?.signUpEmailTextEditingController.text != "") {
      try {
        UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: authProvider!.signUpEmailTextEditingController.value.text,
          password:
          authProvider!.signUpPasswordTextEditingController.value.text,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: CustomColors.primaryColor,
            content: CustomText(
              text: 'Registered Successfully',
              color: Colors.white,
            ),
          ),
        );
        Navigator.of(context).pushNamed(UserConstants.userDashboard);
      } on FirebaseAuthException catch (err) {
        if (err.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: CustomColors.primaryColor,
              content: CustomText(
                text: 'Password is too weak',
                color: Colors.white,
              ),
            ),
          );
        }else if(err.code == 'Email-already in use'){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: CustomColors.primaryColor,
              content: CustomText(
                text: 'Account already exist',
                color: Colors.white,
              ),
            ),
          );
        }
      }
    }
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      CustomText(
                        text: 'Create Your Account',
                        color: Colors.black,
                        size: 32,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      CustomText(
                        text: 'Please Enter your Details To Sign Up.',
                        color: Colors.black,
                      ),
                      SizedBox(
                        height: 64,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: 'Sign Up',
                              size: 24,
                              fontWeight: FontWeight.w600,
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            TextFromFieldWithPrefixSuffix(
                              controller: authProvider.signUpNameTextEditingController,
                              glassEffect: true,
                              hintText: 'Enter Your Name',
                              blurAmount: 5.0,
                              glassOpacity: 0.4,
                              borderColor: Colors.white, // Default border color
                              focusedBorderColor: Colors.blue, // Color when focused
                              enabledBorderColor: Colors.grey, // Color when enabled
                              errorBorderColor: Colors.red,
                              borderRadius: 16,
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.grey.shade600,
                              ),
                              validator: (Value) {
                                if (Value == null || Value.isEmpty) {
                                  return 'Please enter the valid name';
                                }
                              },
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            TextFromFieldWithPrefixSuffix(
                              controller:
                              authProvider.signUpEmailTextEditingController,
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
                              controller:
                              authProvider.signUpPasswordTextEditingController,
                              glassEffect: true,
                              hintText: 'Password',
                              obscure: authProvider.obscureForPwd,
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
                                  authProvider.setToggle();
                                },
                                child: Icon(
                                  authProvider.obscureForPwd
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              validator: (value) {
                                return value!.isEmpty
                                    ? 'Password is required'
                                    : null;
                              },
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            CustomElevatedButton(
                              borderRadius: 32,
                              width: MediaQuery.of(context).size.width * 0.80,
                              onPressed: () {
                                Navigator.of(context).pushNamed(UserConstants.userDashboard);
                                // if(_formState.currentState!.validate()){
                                //   setState(() {
                                //     name = authProvider.signUpNameTextEditingController.value.text;
                                //     email = authProvider.signUpEmailTextEditingController.value.text;
                                //     password = authProvider.signUpPasswordTextEditingController.value.text;
                                //   });
                                //   registration();
                                //
                                // }
                              },
                              backgroundColor: CustomColors.primaryColor2,
                              widget: CustomText(
                                text: 'Sign Up',
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
                                  text: 'Already have an account? ',
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamed(UserConstants.logInPage);
                                  },
                                  child: CustomText(
                                    text: 'Log In',
                                    color: Colors.white,
                                    isContent: true,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: Colors.black,
                              thickness: 0.5,
                              endIndent: 40,
                              indent: 40,
                            ),
                          ),
                          CustomText(text: 'or'),
                          Expanded(
                            child: Divider(
                              color: Colors.black,
                              thickness: 0.5,
                              endIndent: 40,
                              indent: 40,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomContainer(
                            child: Image.asset(
                              'assets/images/apple.png',
                              fit: BoxFit.cover,
                              height: 56,
                            ),
                            glassEffect: true,
                            blurAmount: 6.0,
                            glassOpacity: 0.15,
                            // glassBorderWidth: 0.5,
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          CustomContainer(
                            child: Image.asset(
                              'assets/images/google.png',
                              fit: BoxFit.cover,
                              height: 56,
                            ),
                            glassEffect: true,
                            blurAmount: 6.0,
                            glassOpacity: 0.15,
                            // glassBorderWidth: 0.5,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
