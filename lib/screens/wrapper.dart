import 'package:donar_app/models/user.dart';
import 'package:donar_app/screens/home/home.dart';
import 'package:donar_app/screens/authenticate/authenticate.dart';
import 'package:donar_app/services/auth.dart';
import 'package:donar_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    final user = Provider.of<User>(context);

    // return either the Home or Authenticate widget
    if (user == null){
      return Authenticate();
    } else {
      return StreamProvider<UserData>.value(
        value: DatabaseService(uid: user.uid).userd,
        child:Home(),
      );
    }

  }
}

