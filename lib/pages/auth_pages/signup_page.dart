import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../provider/auth_provider/auth_provider.dart';
import '../../routes/route_generator_constants.dart';
import '../../widgets/buttons/custom_elevatedbutton.dart';
import '../../widgets/colors/custom_colors.dart';
import '../../widgets/container/custom_container.dart';
import '../../widgets/dropdown/custom_dropdown.dart';
import '../../widgets/text/custom_text.dart';
import '../../widgets/textfield/custom_textfield.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';

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
  String formattedDate = '';
  String dateString = '';
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
          dateString = authProvider.selectedDate.toString().split(" ")[0];
          DateTime dateTime = DateTime.parse(dateString);
          formattedDate = DateFormat('EEEE d MMMM').format(dateTime);
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
                      CustomContainer(
                        horizontalMargin: 16,
                        horizontalPad: 24,
                        glassEffect: true,
                        height: 0.3,
                        child: SingleChildScrollView(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: MediaQuery.of(context).size.height * 0.5,
                            ),
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
                                TextFromFieldWithPrefixSuffix(
                                  controller:
                                  authProvider.signUpUserTypeTextEditingController,
                                  glassEffect: true,
                                  hintText: 'UserType',
                                  obscure: authProvider.obscureForPwd,
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
                                  validator: (value) {
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                CustomDropdown(
                                    borderRadius: 16,
                                    labelText: 'Select Gender',
                                    items: authProvider.gender,
                                    value: authProvider.defaultGenderValue,
                                    onChanged: (selectedGender) {
                                      authProvider.setGender(selectedGender);
                                    },
                                    glassEffect: true,
                                    blurAmount: 5.0,
                                    glassOpacity: 0.4,
                                    focusedBorderColor: Colors.blue,
                                    // dropdownBackgroundColor: Colors.white,
                                    ),
                                SizedBox(
                                  height: 16,
                                ),
                                TextFromFieldWithPrefixSuffix(
                                  controller:
                                  authProvider.signUpUserHeightTextEditingController,
                                  glassEffect: true,
                                  hintText: 'Enter your Height',
                                  blurAmount: 5.0,
                                  glassOpacity: 0.4,
                                  keyboardType: TextInputType.number,
                                  borderColor: Colors.white, // Default border color
                                  focusedBorderColor: Colors.blue, // Color when focused
                                  enabledBorderColor: Colors.grey, // Color when enabled
                                  errorBorderColor: Colors.red,
                                  borderRadius: 16,
                                  prefixIcon: Icon(
                                    Icons.height,
                                    color: Colors.grey.shade600,
                                  ),
                                  validator: (value) {
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                TextFromFieldWithPrefixSuffix(
                                  controller: authProvider.signUpUserWeightTextEditingController,
                                  glassEffect: true,
                                  hintText: 'Enter your Weight',
                                  blurAmount: 5.0,
                                  glassOpacity: 0.4,
                                  borderColor: Colors.white,
                                  keyboardType: TextInputType.number,// Default border color
                                  focusedBorderColor: Colors.blue, // Color when focused
                                  enabledBorderColor: Colors.grey, // Color when enabled
                                  errorBorderColor: Colors.red,
                                  borderRadius: 16,
                                  prefixIcon: Icon(
                                    Icons.monitor_weight_outlined,
                                    color: Colors.grey.shade600,
                                  ),
                                  validator: (value) {
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                TextFromFieldWithPrefixSuffix(
                                  controller: authProvider.dateController,
                                  glassEffect: true,
                                  hintText: 'Enter your Date of Birth',
                                  blurAmount: 5.0,
                                  glassOpacity: 0.4,
                                  borderColor: Colors.white, // Default border color
                                  focusedBorderColor: Colors.blue, // Color when focused
                                  enabledBorderColor: Colors.grey, // Color when enabled
                                  errorBorderColor: Colors.red,
                                  borderRadius: 16,
                                  prefixIcon: InkWell(
                                    onTap: (){
                                      showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1800),
                                        lastDate: DateTime(2040),
                                      ).then((value){
                                        authProvider.setDate(value);
                                        authProvider.setDatetime(formattedDate);
                                        print(formattedDate);
                                      });
                                    },
                                    child: Icon(
                                      Icons.calendar_month,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                  validator: (value) {
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                TextFromFieldWithPrefixSuffix(
                                  controller: authProvider.signUpUserPhoneTextEditingController,
                                  glassEffect: true,
                                  hintText: 'Enter your Phone Number',
                                  blurAmount: 5.0,
                                  glassOpacity: 0.4,
                                  keyboardType: TextInputType.number,
                                  borderColor: Colors.white, // Default border color
                                  focusedBorderColor: Colors.blue, // Color when focused
                                  enabledBorderColor: Colors.grey, // Color when enabled
                                  errorBorderColor: Colors.red,
                                  borderRadius: 16,
                                  prefixIcon: Icon(
                                    Icons.phone,
                                    color: Colors.grey.shade600,
                                  ),
                                  validator: (value) {
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                TextFromFieldWithPrefixSuffix(
                                  controller: authProvider.signUpUserAddressTextEditingController,
                                  glassEffect: true,
                                  hintText: 'Enter your Address',
                                  blurAmount: 5.0,
                                  glassOpacity: 0.4,
                                  keyboardType: TextInputType.text,
                                  borderColor: Colors.white, // Default border color
                                  focusedBorderColor: Colors.blue, // Color when focused
                                  enabledBorderColor: Colors.grey, // Color when enabled
                                  errorBorderColor: Colors.red,
                                  borderRadius: 16,
                                  prefixIcon: Icon(
                                    Icons.location_city,
                                    color: Colors.grey.shade600,
                                  ),
                                  validator: (value) {
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                CustomElevatedButton(
                                  borderRadius: 32,
                                  width: MediaQuery.of(context).size.width * 0.80,
                                  onPressed: () async{
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
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 24,
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
                ],
              ),
            ),
          );
        });
  }
}
