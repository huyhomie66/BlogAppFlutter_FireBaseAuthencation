import 'package:flutter/material.dart';
import 'LoginRegisterPage.dart';
import 'HomePage.dart';
import 'Authencation.dart';

class MappingPage extends StatefulWidget {
  final AuthImplementaion auth;

  MappingPage
  ({
    this.auth,
  });

  State<StatefulWidget> createState() {
    return MappingPageState();
  }
}

enum AuthStatus {
  notSignedIn,
  signedIn,
}

class MappingPageState extends State<MappingPage> {
  AuthStatus authStatus = AuthStatus.notSignedIn;

  @override
  void initState() {
    //constructor initState
    super.initState();
// checking authencation loign
    widget.auth.getCurrentUser().then((firebaseUserId) {
      setState(() {
        //checking status login
        authStatus = firebaseUserId == null
            ? AuthStatus.notSignedIn
            : AuthStatus.signedIn;
      });
    });
  }

  void signedIn() {
    setState(() {
      authStatus = AuthStatus.signedIn;
    });
  }

  void signedOut() {
    setState(() {
      authStatus = AuthStatus.notSignedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.notSignedIn:
        return new LoginRegisterPage(
        auth: widget.auth,
         onSignedIn: signedIn
        );

      case AuthStatus.signedIn:
        return new HomePage(
          auth: widget.auth,
          onSignedOut: signedOut,
        );
    }

    return null;
  }
}
