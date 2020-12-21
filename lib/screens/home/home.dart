import 'package:donar_app/models/donation.dart';
import 'package:donar_app/models/user.dart';
import 'package:donar_app/screens/home/donateForm.dart';
import 'package:donar_app/screens/home/userda.dart';
import 'package:donar_app/services/auth.dart';
import 'package:donar_app/services/database.dart';
import 'package:donar_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final ud = Provider.of<UserData>(context);
    final user = Provider.of<UserData>(context);
    print(user);
    void _showSettingsPanel() {
      showModalBottomSheet(context: context, builder: (context) {
        return StreamProvider<UserData>.value(
          value: DatabaseService(uid: user.uid).userd,
          child: Container(
            color: Colors.blue[50],
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
            child: donationForm(),
          ),
        );
      });
    }
    if (ud != null ){
      if (ud.otype != 'Donar') {
        return StreamProvider<List<Donation>>.value(
          value: DatabaseService(uid: user.uid).donations,
          child: Scaffold(
            backgroundColor: Colors.amber[50],
            appBar: AppBar(
              title: Text('Donation App'),
              backgroundColor: Colors.blue,
              elevation: 0.0,
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  label: Text(
                    'logout',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () async {
                    await _auth.signOut();
                  },
                ),
              ],
            ),
            body: userdShow(),
          ),
        );
      }
      else {
        return StreamProvider<List<Donation>>.value(
          value: DatabaseService(uid: user.uid).donationsbyuser,
          child: Scaffold(
            backgroundColor: Colors.amber[50],
            appBar: AppBar(
              title: Text('Hi donar'),
              backgroundColor: Colors.blue,
              elevation: 0.0,
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  label: Text(
                    'logout',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () async {
                    await _auth.signOut();
                  },
                ),
                FlatButton.icon(
                  icon: Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  label: Text(
                      'Donate',
                      style: TextStyle(
                        color: Colors.white,
                      )
                  ),
                  onPressed: () => _showSettingsPanel(),
                )
              ],
            ),
            body: userdShow(),
          ),
        );
      }

    }
    else{
      return Loading();
    }



  }
}