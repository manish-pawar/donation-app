import 'package:donar_app/models/user.dart';
import 'package:donar_app/services/database.dart';
import 'package:donar_app/shared/constants.dart';
import 'package:donar_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class donationForm extends StatefulWidget {
  @override
  _DonationFormState createState() => _DonationFormState();
}

class _DonationFormState extends State<donationForm> {

  final _formKey = GlobalKey<FormState>();

  // form values
  String donation;

  @override
  Widget build(BuildContext context) {


    final ud = Provider.of<UserData>(context);
    final user = Provider.of<User>(context);
    return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            SizedBox(height: 40.0),
          Text(
          'Make people Happy who need happiness.',
          style: TextStyle(fontSize: 18.0),
          ),
          SizedBox(height: 40.0),
          TextFormField(
            decoration: textInputDecoration.copyWith(hintText: 'What you want to donate?'),
            validator: (val) => val.isEmpty ? 'Please enter a name' : null,
            onChanged: (val) => setState(() => donation = val),
          ),
          SizedBox(height: 30.0),


          RaisedButton(
            color: Colors.blueAccent,
            child: Text(
            'Donate',
            style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
                if(_formKey.currentState.validate()){
                  await DatabaseService(uid: user.uid).addDonation(donation, user.uid, ud.name, ud.address);
                  Navigator.pop(context);
                }
            }
          ),
          ],
          ),
    );
  }
}