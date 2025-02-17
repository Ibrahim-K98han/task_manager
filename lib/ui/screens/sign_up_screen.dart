import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/sign_in_screen.dart';
import 'package:task_manager/utils/app_colors.dart';

import '../../widgets/screen_background.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
    return Column(
      children: [
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: 'Email',
            hintStyle: TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
        SizedBox(height: 16),
        TextFormField(
          decoration: InputDecoration(
            hintText: 'First Name',
            hintStyle: TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
        SizedBox(height: 16),
        TextFormField(
          decoration: InputDecoration(
            hintText: 'Last Name',
            hintStyle: TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
        SizedBox(height: 16),
        TextFormField(
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            hintText: 'Mobile',
            hintStyle: TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
        SizedBox(height: 16),
        TextFormField(
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'Password',
            hintStyle: TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
        SizedBox(height: 36),
        ElevatedButton(
          onPressed: _onTapSignUpButton,
          child: Text(
            'Sign Up',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }

  void _onTapSignUpButton() {}
  void _onTapLoginUp() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SignInScreen(),
      ),
    );
  }
}

///================ Module 15 2) Ui Design iii =====================///