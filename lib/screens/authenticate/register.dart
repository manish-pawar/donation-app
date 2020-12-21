import 'package:donar_app/services/auth.dart';
import 'package:donar_app/shared/constants.dart';
import 'package:donar_app/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({ this.toggleView });

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool loading = false;


  String error = '';

  final List<String> orgType = ['Donar', 'NGO'];

  // text field state
  String email = '';
  String password = '';
  String name='';
  String address = '';
  String _org;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.blueGrey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0.0,
        title: Text('Sign up to Donate'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(
                Icons.person,
              color: Colors.white,
            ),
            label: Text(
                'Sign In',
                style: TextStyle(
                  color: Colors.white,
                )
            ),
            onPressed: () => widget.toggleView(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'email'),
                  validator: (val) => val.isEmpty ? 'Enter an email' : null,
                  onChanged: (val) {
                    setState(() => email = val);
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'password'),
                  obscureText: true,
                  validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Organization or Donar name'),
                  validator: (val) => val.isEmpty ? 'Enter name of organization' : null,
                  onChanged: (val) {
                    setState(() => name = val);
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Address'),
                  validator: (val) => val.isEmpty ? 'Enter Address' : null,
                  onChanged: (val) {
                    setState(() => address = val);
                  },
                ),
                SizedBox(height: 20.0),
                DropdownButtonFormField(
                  value: _org ?? 'Donar',
                  decoration: textInputDecoration,
                  items: orgType.map((o) {
                    return DropdownMenuItem(
                      value: o,
                      child: Text('$o'),
                    );
                  }).toList(),
                  onChanged: (val) => setState(() => _org = val ),
                ),
                SizedBox(height: 10.0),
                RaisedButton(
                    color: Colors.blue,
                    child: Text(
                      'Register',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if(_formKey.currentState.validate()){
                        setState(() => loading = true);
                        dynamic result = await _auth.registerWithEmailAndPassword(email, password, name, address, _org );
                        if(result == null) {
                          setState(() {
                            loading = false;
                            error = 'Please supply a valid email';
                          });
                        }
                      }
                    }
                ),
                SizedBox(height: 12.0),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}