
import 'package:donar_app/models/donation.dart';
import 'package:donar_app/models/user.dart';
import 'package:donar_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DonationTile extends StatelessWidget {
  final DatabaseService dbs = DatabaseService();

  final Donation donation;
  DonationTile({ this.donation });
  @override
  Widget build(BuildContext context) {


    final ud = Provider.of<UserData>(context);
    print(donation.donation);
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        color: ( donation.taken == 'no')? Colors.white: Colors.blue,
        child: ListTile(
          leading: ( ud.otype == 'Donar') ? Icon(
            ( donation.taken == 'no') ? Icons.pending: Icons.check,
            color: ( donation.taken == 'no') ? Colors.blue: Colors.white,
            size: 30.0,
          ): ( donation.taken != 'no') ? Text(
              'Taken',
              style: TextStyle(
                color: Colors.white,
              )
          ): FlatButton(
              color: Colors.blue,

              child: Text(
                  'Take donation',
                  style: TextStyle(
                    color: Colors.white,
                  )
              ),
            onPressed: () => {
                print('clicked'),
                dbs.updateDonation(donation.id, ud.name, donation.donation, donation.donar, donation.donaraddress, donation.donaruid),
            },
          ),
          title:  Text('donation - ${donation.donation}'),
          subtitle: ( ud.otype != 'Donar') ? Text(  'donated by -${donation.donar} , Address - ${donation.donaraddress}') : Text( ( donation.taken != 'no') ? 'taken by -${donation.takenby}': 'Not yet taken by anyone.'),

        ),
      ),
    );
  }
}