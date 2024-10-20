import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/utils/app_colors.dart';
import 'package:task_manager/ui/widgets/center_circular_progress_indicator.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';

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
      // resizeToAvoidBottomInset: false,
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 82,
                ),
                Text(
                  'Join With Us',
                  style: textTheme.displaySmall
                      ?.copyWith(fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 24,
                ),
                _buildSignUpForm(),
                const SizedBox(
                  height: 24,
                ),
                Center(
                  child: Column(
                    children: [
                      _buildHaveAccountSection(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
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
            decoration: const InputDecoration(hintText: 'Email'),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Enter Valid Email';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            controller: _firstNameETController,
            decoration: const InputDecoration(hintText: 'First Name'),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Enter First Name';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            controller: _lastNameETController,
            decoration: const InputDecoration(hintText: 'Last Name'),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Enter Last Name';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            controller: _mobileETController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(hintText: 'Mobile'),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Enter Mobile Number';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            controller: _passwordETController,
            decoration: const InputDecoration(hintText: 'Password'),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Enter Password';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 24,
          ),
          Visibility(
            visible: !_inProgress,
            replacement: const CenterCircularProgressIndicator(),
            child: ElevatedButton(
              onPressed: _onTapNextButton,
              child: const Icon(Icons.arrow_circle_right_outlined),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHaveAccountSection() {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 14,
          letterSpacing: 0.5,
        ),
        text: 'Have account? ',
        children: [
          TextSpan(
            text: 'Sign In',
            style: const TextStyle(
              color: AppColors.themeColor,
            ),
            recognizer: TapGestureRecognizer()..onTap = _onTapSignIn,
          ),
        ],
      ),
    );
  }

  void _onTapNextButton() {
    if (_formKey.currentState!.validate()) {
      _signUp();
    }
  }

  Future<void> _signUp() async {
    _inProgress = true;
    setState(() {});
    Map<String, dynamic> requestBody = {
      "email": _emailETController.text.trim(),
      "firstName": _firstNameETController.text.trim(),
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
      showSnackBarMessage(context, 'New user created');
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
  }

  void _clearTextFields() {
    _emailETController.clear();
    _firstNameETController.clear();
    _lastNameETController.clear();
    _mobileETController.clear();
    _passwordETController.clear();
  }

  void _onTapSignIn() {
    Navigator.pop(context);
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
