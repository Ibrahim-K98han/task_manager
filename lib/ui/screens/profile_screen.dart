import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager/ui/controllers/auth_controller.dart';
import 'package:task_manager/widgets/tm_app_bar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _phoneTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  XFile? _selectedImage;
  bool _updateProfileInProgress = false;
  @override
  void initState() {
    _setUserData();
    super.initState();
  }

  void _setUserData() {
    _emailTEController.text = AuthController.userData?.email ?? '';
    _firstNameTEController.text = AuthController.userData?.firstName ?? '';
    _lastNameTEController.text = AuthController.userData?.lastName ?? '';
    _phoneTEController.text = AuthController.userData?.mobile ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(
        isProfileScreenOpen: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 32),
                Text(
                  'Update Profile',
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall
                      ?.copyWith(fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 32),
                _buildPhotoPicker(),
                SizedBox(height: 8),
                TextFormField(
                  enabled: false,
                  controller: _emailTEController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: _firstNameTEController,
                  decoration: InputDecoration(
                    hintText: 'First Name',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter First Name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: _lastNameTEController,
                  decoration: InputDecoration(
                    hintText: 'Last Name',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter Last Name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: _phoneTEController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Phone',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter Phone Number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 8),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {}
                  },
                  child: Text('Update'),
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _updateProfile() async {
    _updateProfileInProgress = true;
    setState(() {});
    Map<String, dynamic> requestBody = {
      "email": _emailTEController.text.trim(),
      "firstName": _firstNameTEController.text.trim(),
      "lastName": _lastNameTEController.text.trim(),
      "mobile": _phoneTEController.text.trim(),
    };
    if (_passwordTEController.text.isNotEmpty) {
      requestBody['password'] = _passwordTEController.text;
    }
    if (_selectedImage != null) {
      List<int> imageBytes = await _selectedImage!.readAsBytes();
      String convertedImage = base64Encode(imageBytes);
      requestBody['photo'] = convertedImage;
    }
  }

  Widget _buildPhotoPicker() {
    return GestureDetector(
      onTap: () {
        _selectImage();
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Container(
              height: 50,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                'Photo',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(width: 8),
            Text(_getSelectedPhotoTitle()),
          ],
        ),
      ),
    );
  }

  String _getSelectedPhotoTitle() {
    if (_selectedImage != null) {
      return _selectedImage!.name;
    }
    return 'Select photo';
  }

  Future<void> _selectImage() async {
    ImagePicker _imagePicker = ImagePicker();
    XFile? pickImage = await _imagePicker.pickImage(source: ImageSource.camera);
    if (pickImage != null) {
      _selectedImage = pickImage;
      setState(() {});
    }
  }
}
