import 'package:donar_app/models/donation.dart';
import 'package:donar_app/screens/home/donationTile.dart';
import 'package:flutter/material.dart';
import 'package:donar_app/models/user.dart';
import 'package:donar_app/shared/loading.dart';
import 'package:provider/provider.dart';


class userdShow extends StatefulWidget {
  @override
  _UserdShowState createState() => _UserdShowState();
}

class _UserdShowState extends State<userdShow> {
  @override
  Widget build(BuildContext context) {
    final donations = Provider.of<List<Donation>>(context) ?? [];

    if ( donations.length == 0){
      return Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          title: Text(
              'You have not donated yet. Please donate to help others!!',
               style: TextStyle(
                 color: Colors.black87,
               ),
          ),
          subtitle: Text( 'You can donate via above Donate button.'),
        ),
      );
    }
    else{
      return ListView.builder(
        itemCount: donations.length,
        itemBuilder: (context, index) {
          return DonationTile(donation : donations[index]);
        },
      );
    }


  }
}