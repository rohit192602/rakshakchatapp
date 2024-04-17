import 'package:chat_application/consts.dart';
import 'package:chat_application/services/alert_service.dart';
import 'package:chat_application/services/auth_service.dart';
import 'package:chat_application/services/navigation_services.dart';
import 'package:chat_application/widgets/custom_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GetIt _getIt = GetIt.instance;
  final GlobalKey<FormState> _loginFromKey = GlobalKey<FormState>();
  late AuthService _authServices;
  late NavigationService _navigationService;
  late AlertService _alertService;
  String? email, password;
  @override
  void initState() {
    super.initState();
    _authServices = _getIt.get<AuthService>();
    _navigationService = _getIt.get<NavigationService>();
    _alertService = _getIt.get<AlertService>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
        child: Column(
          children: [
            _headerText(),
            _loginForm(),
            _loginButton(),
            _createAccountLink(),
          ],
        ),
      ),
    );
  }

  Widget _headerText() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: const Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Hii,Welcome back",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              )),
          Text(
            "Hello again you have been missed",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }

  Widget _loginForm() {
    return Container(
        height: MediaQuery.sizeOf(context).height * 0.40,
        margin: EdgeInsets.symmetric(
            vertical: MediaQuery.sizeOf(context).height * 0.05),
        child: Form(
          key: _loginFromKey,
          child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomFormField(
                  height: MediaQuery.sizeOf(context).height * 0.1,
                  hintText: "Email",
                  validationRexEx: EMAIL_VALIDATION_REGEX,
                  onSaved: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                ),
                CustomFormField(
                  height: MediaQuery.sizeOf(context).height * 0.1,
                  hintText: "password",
                  validationRexEx: PASSWORD_VALIDATION_REGEX,
                  obscureText: false,
                  onSaved: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                ),
              ]),
        ));
  }

  Widget _loginButton() {
    return SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: MaterialButton(
          onPressed: () async {
            print("object");
            if (_loginFromKey.currentState?.validate() ?? false) {
              print("object");
              _loginFromKey.currentState?.save();
              print("email");
              print(password);
              bool result = await _authServices.login(email!, password!);
              if (result) {
                _navigationService.pushReplacementNamed("/home");
              } else {
                _alertService.showToast(
                    text: "Failed to login, Please try again ",
                    icon: Icons.error_rounded);
              }
            }
          },
          color: Theme.of(context).colorScheme.primary,
          child: const Text(
            "Login",
            style: TextStyle(color: Colors.white),
          ),
        ));
  }

  Widget _createAccountLink() {
    return Expanded(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Text("Don't have an account?"),
        GestureDetector(
          onTap: () {
            _navigationService.pushNamed("/register");
          },
          child: const Text(
            "Sign up",
            style: TextStyle(
              fontWeight: FontWeight.w800,
            ),
          ),
        )
      ],
    ));
  }
}
