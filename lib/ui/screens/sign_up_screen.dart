import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/screens/sign_in_screen.dart';
import 'package:task_manager/utils/app_colors.dart';
import 'package:task_manager/widgets/center_circular_progress.dart';
import 'package:task_manager/widgets/snack_bar_message.dart';

import '../../widgets/screen_background.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailETController = TextEditingController();
  final TextEditingController _firstNameETController = TextEditingController();
  final TextEditingController _lastNameETController = TextEditingController();
  final TextEditingController _mobileETController = TextEditingController();
  final TextEditingController _passwordETController = TextEditingController();
  bool _inProgress = false;
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 82),
                Text(
                  'Join With Us',
                  style: textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 24),
                _buildSignUpForm(),
                SizedBox(height: 36),
                Center(
                  child: _buildHaveAccountSection(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHaveAccountSection() {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 14,
          letterSpacing: 0.5,
        ),
        text: 'have an account?',
        children: [
          TextSpan(
            text: ' Login',
            style: TextStyle(
              color: AppColors.themeColor,
            ),
            recognizer: TapGestureRecognizer()..onTap = _onTapLoginUp,
          )
        ],
      ),
    );
  }

  Widget _buildSignUpForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _emailETController,
            keyboardType: TextInputType.emailAddress,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              hintText: 'Email',
              hintStyle: TextStyle(
                color: Colors.grey,
              ),
            ),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Enter Valid Email';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _firstNameETController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
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
          SizedBox(height: 16),
          TextFormField(
            controller: _lastNameETController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
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
          SizedBox(height: 16),
          TextFormField(
            controller: _mobileETController,
            keyboardType: TextInputType.phone,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              hintText: 'Mobile',
              hintStyle: TextStyle(
                color: Colors.grey,
              ),
            ),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Enter Mobile Number';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _passwordETController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Password',
              hintStyle: TextStyle(
                color: Colors.grey,
              ),
            ),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Enter Password';
              }
              return null;
            },
          ),
          SizedBox(height: 36),
          Visibility(
            visible: !_inProgress,
            replacement: CenterCircularProgress(),
            child: ElevatedButton(
              onPressed: _onTapSignUpButton,
              child: Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onTapSignUpButton() {
    if (_formKey.currentState!.validate()) {
      _signUp();
    }
  }

  Future<void> _signUp() async {
    _inProgress = true;
    setState(() {});
    Map<String, dynamic> requestBody = {
      "email": _emailETController.text.trim(),
      "firstName": _firstNameETController.text.trimLeft(),
      "lastName": _lastNameETController.text.trim(),
      "mobile": _mobileETController.text.trim(),
      "password": _passwordETController.text,
      "photo": ""
    };
    NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.registration,
      body: requestBody,
    );
    _inProgress = false;
    setState(() {});
    if (response.isSuccess) {
      _clearTextFields();
      showSnackBarMessage(context, 'New User Created');
    } else {
      showSnackBarMessage(
        context,
        response.errorMessage,
        true,
      );
    }
  }

  void _onTapLoginUp() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SignInScreen(),
      ),
    );
  }

  void _clearTextFields() {
    _emailETController.clear();
    _firstNameETController.clear();
    _lastNameETController.clear();
    _mobileETController.clear();
    _passwordETController.clear();
  }

  @override
  void dispose() {
    _emailETController.dispose();
    _firstNameETController.dispose();
    _lastNameETController.dispose();
    _mobileETController.dispose();
    _passwordETController.dispose();
    super.dispose();
  }
}

