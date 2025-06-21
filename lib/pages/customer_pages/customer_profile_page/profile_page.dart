import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:semester_project/widgets/colors/custom_colors.dart';

import '../../../provider/customer_provider/customer_profile_provider.dart';
import '../../../widgets/buttons/custom_elevatedbutton.dart';
import '../../../widgets/container/custom_container.dart';
import '../../../widgets/text/custom_text.dart';

class CustomerProfilePage extends StatefulWidget {
  const CustomerProfilePage({super.key});

  @override
  State<CustomerProfilePage> createState() => _CustomerProfilePageState();
}

class _CustomerProfilePageState extends State<CustomerProfilePage> {
  File? _imageFile;
  String? _imageUrl;
  bool _isUploading = false;

  @override
  void initState() {
    // TODO: implement initState
    CustomerProfileProvider customerProfileProvider = Provider.of<CustomerProfileProvider>(context,listen: false);
    super.initState();
  }

  Future<void> pickImage(ImageSource source) async{
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: source);
    setState(() {
      if(pickedFile != null) _imageFile = File(pickedFile.path);
    });
  }

  Future<void> _uploadImage() async {
    CustomerProfileProvider customerProfileProvider = Provider.of<CustomerProfileProvider>(context,listen: false);
    if (_imageFile == null) return;

    setState(() {
      _isUploading = true;
    });
    //https://api.cloudinary.com/v1_1/<CLOUD_NAME>/upload
    try {
      final url = Uri.parse('https://api.cloudinary.com/v1_1/dof45itpi/image/upload');
      final request = http.MultipartRequest('POST', url)
        ..fields['upload_preset'] = 'upload image'  // Make sure this matches your Cloudinary preset
        ..files.add(await http.MultipartFile.fromPath('file', _imageFile!.path));

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final jsonMap = jsonDecode(responseData);
        setState(() {
          _imageUrl = jsonMap['secure_url'];  // Use secure_url instead of url
          _isUploading = false;
        });

        customerProfileProvider.setImageUrl(_imageUrl!);
        // Optionally save to secure storage
        final secureStorage = FlutterSecureStorage();
        await secureStorage.write(key: 'profile_image_url', value: _imageUrl);
      } else {
        setState(() {
          _isUploading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Upload failed: ${response.statusCode}')),
        );
      }
    } catch (e) {
      setState(() {
        _isUploading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroudColor,
      body: body(context),
    );
  }

  Widget body(context){
    return SafeArea(
      child: Column(
        children: [
          CustomContainer(
            color:  CustomColors.backgroudColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: CircleAvatar(
                    child: Icon(Icons.arrow_back_ios_new),
                    radius: 24,
                    backgroundColor: Colors.white,
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.24,),
                CustomText(text: 'Profile', size: 24),
              ],
            ),
          ),
          SizedBox(height: 16,),
          InkWell(
            onTap: (){
              showModalBottomSheet(
                  isScrollControlled: true,
                  useSafeArea: true,
                  context: context,
                  builder: (context) =>
                      _pickProfileBottomSheet(context));
            },
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 64,
                  backgroundColor: Colors.white,
                  backgroundImage: _imageUrl != null
                      ? NetworkImage(_imageUrl!)
                      : null,
                  child: _imageUrl == null
                      ? Icon(Icons.person, size: 64)
                      : null,
                ),
                if (_isUploading)
                  Positioned.fill(
                    child: Container(
                      color: Colors.black54,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(height: 24,),
          CustomContainer(
            horizontalMargin: 16,
              applyShadow: true,
              child: Column(
                children: [
                  Row(
                    children: [
                      CustomText(text: 'Name:',isContent: true,),
                      SizedBox(width: 8,),
                      CustomText(text: 'Farhan Ansari',isContent: true,),
                      Spacer(),
                      InkWell(
                        onTap: (){

                        },
                          child: FaIcon(FontAwesomeIcons.pen),
                      ),
                    ],
                  ),
                  SizedBox(height: 8,),
                  Row(
                    children: [
                      CustomText(text: 'Age:',isContent: true,),
                      SizedBox(width: 8,),
                      CustomText(text: '23 years',isContent: true,)
                    ],
                  ),
                  SizedBox(height: 8,),
                  Row(
                    children: [
                      CustomText(text: 'DOB: ',isContent: true,),
                      SizedBox(width: 8,),
                      CustomText(text: '2058-10-23',isContent: true,)
                    ],
                  ),
                  SizedBox(height: 8,),
                  Row(
                    children: [
                      CustomText(text: 'Height: ',isContent: true,),
                      SizedBox(width: 8,),
                      CustomText(text: '5\'7',isContent: true,)
                    ],
                  ),
                  SizedBox(height: 8,),
                  Row(
                    children: [
                      CustomText(text: 'Weight:',isContent: true,),
                      SizedBox(width: 8,),
                      CustomText(text: '82 kg',isContent: true,)
                    ],
                  ),
                  SizedBox(height: 8,),
                  Row(
                    children: [
                      CustomText(text: 'Email:',isContent: true,),
                      SizedBox(width: 8,),
                      CustomText(text: 'ansarifarhan2316@gmail.com',isContent: true,)
                    ],
                  ),
                ],
              ),
          ),
        ],
      ),
    );
  }
  //-------------------------------------------------------------------BottomSheet------------------------------------------------------------------------------------------------------------------------------------//

 Widget _pickProfileBottomSheet(context){
    return ClipRRect(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.16,
        width: MediaQuery.of(context).size.width * 1,
        child: Column(
          children: [
            SizedBox(height: 16,),
            CustomElevatedButton(
              width: 1,
              borderRadius: 0,
              onPressed: ()async{
                await pickImage(ImageSource.gallery);
              },
              widget: CustomText(text: 'Pick Image'),
              backgroundColor: Colors.blueAccent,
            ),
            CustomElevatedButton(
              width: 1,
              borderRadius: 0,
              onPressed: _imageFile != null ? () async {
                await _uploadImage();
                // customerProfileProvider.setImageUrl
              } : null,
              widget: _isUploading
                  ? CircularProgressIndicator(color: Colors.white)
                  : CustomText(text: 'Upload Image'), backgroundColor: Colors.blueAccent,),
          ],
        ),
      ),
    );
}
//---------------------------------------------------------------------BottomSheet-------------------------------------------------------------------------------------------------------------------------------------//

}
