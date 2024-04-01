import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jbfr_april_fp/features/home/home_widget.dart';
import 'package:jbfr_april_fp/features/login/components/login_information_column.dart';
import 'package:jbfr_april_fp/features/login/login_controller.dart';
import 'package:jbfr_april_fp/features/login/login_model.dart';
import 'package:jbfr_april_fp/services/user_service.dart';

class LoginPage extends StatefulWidget {
  static const String route = '/login';

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginController? controller;
  LoginStatus? status;
  bool isTryingToLogin = false;

  @override
  void initState() {
    controller = LoginController();
    controller!.verifyConnection().then((value) => setState(() {
          print(value);
          status = value;
        }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: status == null
              ? _buildLoading()
              : status == LoginStatus.connected
                  ? _buildConnectedToDiscord()
                  : _buildConnectionToDiscord(),
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildConnectionToDiscord() {
    if (isTryingToLogin) {
      return _buildTryingToConnectToDiscord();
    }
    return LoginInformationColumnWidget(
        text: "Et si on se connectait avant de commencer ?",
        buttonText: "Se connecter avec Discord",
        onPressed: () {
          controller!.openLoginPage();
          setState(() {
            isTryingToLogin = true;
          });
        });
  }

  Widget _buildTryingToConnectToDiscord() {
    return LoginInformationColumnWidget(
        text: "Vous vous êtes connecté ? Appuyez sur le bouton pour continuer.",
        buttonText: "Continuer",
        onPressed: () {
          isTryingToLogin = false;
          controller!.verifyConnection().then((value) => setState(() {
                status = value;
              }));
        });
  }

  Widget _buildConnectedToDiscord() {
    return LoginInformationColumnWidget(
        text: 'Hello ${UserService().player!.name}, vous êtes connecté à Discord !',
        buttonText: "Continuer",
        onPressed: () {
          Navigator.popAndPushNamed(context, HomePage.route);
        });
  }
}
