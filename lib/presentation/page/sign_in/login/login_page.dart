import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cognito_login_example/presentation/bloc/auth/auth_bloc.dart';
import 'package:cognito_login_example/presentation/theme/palette.dart';

class LoginPage extends StatelessWidget {
  final AuthBloc _authBloc;

  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  LoginPage({
    required AuthBloc authBloc,
    Key? key,
  })  : _authBloc = authBloc,
        super(key: key);

  void _login(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      _authBloc.add(SignInEvent(
        email: _emailTextController.text,
        password: _passwordTextController.text,
      ));
    }
  }

  String? _emailValidator(String? value) {
    if (!EmailValidator.validate(value ?? '')) {
      return '';
    }
    return null;
  }

  String? _passwordValidator(String? value) {
    if (!_passwordValidateStructure(value ?? '')) {
      return '';
    }
    return null;
  }

  bool _passwordValidateStructure(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.primary,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Spacer(),
                  Text(
                    'Please use your username and password to login',
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            color: Palette.white,
            child: SafeArea(
              top: false,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Email:',
                      ),
                      TextFormField(
                        controller: _emailTextController,
                        validator: _emailValidator,
                        autocorrect: false,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          hintText: 'Type here ...',
                          errorStyle: TextStyle(
                            height: 0,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Password:',
                      ),
                      TextFormField(
                        controller: _passwordTextController,
                        validator: _passwordValidator,
                        autocorrect: false,
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: 'Type here ...',
                          errorStyle: TextStyle(
                            height: 0,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      BlocBuilder<AuthBloc, AuthState>(
                        bloc: _authBloc,
                        builder: (context, state) {
                          return SizedBox(
                            width: double.infinity,
                            child: TextButton(
                              onPressed:
                                  state.loading ? null : () => _login(context),
                              child: state.loading
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                        color: Palette.white,
                                      ),
                                    )
                                  : const Text(
                                      'Login',
                                    ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
