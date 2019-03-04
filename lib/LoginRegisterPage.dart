import 'package:flutter/material.dart';
import 'Authencation.dart';


class LoginRegisterPage extends StatefulWidget {

  LoginRegisterPage({
    this.auth,
    this.onSignedIn,
  });

  final AuthImplementaion auth;
  final VoidCallback onSignedIn;

  State<StatefulWidget> createState() {
    return LoginRegisterState();
  }
}

enum FormType {
   login, 
   register }

class LoginRegisterState extends State<LoginRegisterPage> {
  final formKey = new GlobalKey<FormState>();
  FormType formtype = FormType.login;
  String email = " ";
  String password = "";
  //method
  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        if (formtype == FormType.login) {
          String userId = await widget.auth.SignIn(email, password);
          print("login userId =" + userId);
        } else {
          String userId = await widget.auth.SignUp(email, password);
          print("register userId =" + userId);
        }
        widget.onSignedIn();
      } catch (e) {
        print("Error = " + e.toString());
      }
    }
  }

  void movetoRegister() {
    formKey.currentState.reset();
    setState(() {
      formtype = FormType.register;
    });
  }

  void movetoLogin() {
    formKey.currentState.reset();
    setState(() {
      formtype = FormType.login;
    });
  }

  //Design
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
        title: new Text('flutter blog app'),
      ),
      body: new Container(
        margin: EdgeInsets.all(15.0),
        child: new Form(
          key: formKey,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: createInputs() + createButtons(),
          ),
        ),
      ),
    );
  }

  List<Widget> createInputs() {
    return [
      SizedBox(
        height: 10.0,
      ),
      logo(),
      SizedBox(
        height: 20.0,
      ),
      new TextFormField(
        decoration: new InputDecoration(labelText: 'Email'),
        validator: (value) {
          return value.isEmpty ? 'Email is required.' : null;
        },
        onSaved: (value) {
          return email = value;
        },
      ),
      SizedBox(
        height: 20.0,
      ),
      new TextFormField(
        decoration: new InputDecoration(labelText: 'Password'),
        validator: (value) {
          return value.isEmpty ? 'Password is required.' : null;
        },
        onSaved: (value) {
          return password = value;
        },
      ),
    ];
  }

  Widget logo() {
    return new Hero(
      tag: 'hero',
      child: new CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 10.0,
        // child: Image.asset('images/vtcaLogo.png'),
      ),
    );
  }

  List<Widget> createButtons() {
    if (formtype == FormType.login) {
      return [
        new RaisedButton(
          child: new Text(
            'Login',
            style: new TextStyle(fontSize: 20.0),
          ),
          textColor: Colors.white,
          color: Colors.blueGrey,
          onPressed: validateAndSave,
        ),
        new FlatButton(
          child: new Text(
            'not have an Account? Create Account',
            style: new TextStyle(fontSize: 14.0),
          ),
          textColor: Colors.red,
          onPressed: movetoRegister,
          //  color: Colors.blueGrey,
        ),
      ];
    } else {
      return [
        new RaisedButton(
          child: new Text(
            'Create Account',
            style: new TextStyle(fontSize: 20.0),
          ),
          textColor: Colors.white,
          color: Colors.blueGrey,
          onPressed: validateAndSubmit,
        ),
        new FlatButton(
          child: new Text(
            'Already have an Account? Login ',
            style: new TextStyle(fontSize: 14.0),
          ),
          textColor: Colors.red,
          onPressed: movetoLogin,
          //  color: Colors.blueGrey,
        ),
      ];
    }
  }
}
