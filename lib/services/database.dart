import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donar_app/models/donation.dart';
import 'package:donar_app/models/user.dart';


class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  // collection reference
  final CollectionReference userCollection = Firestore.instance.collection('user');
  final CollectionReference donationCollection = Firestore.instance.collection('donations');



  Future<void> updateUserData(String name, String address, String otype) async {
    return await userCollection.document(uid).setData({
      'name': name,
      'address': address,
      'otype': otype,
    });
  }

  Future<void> addDonation(String donation, String uid, String name, String addr ) async {

    return await donationCollection.add({
        'donar' : name,
        'donar_address' : addr,
        'donar_uid': uid,
        'donation': donation,
        'taken_by' : 'none',
        'taken': 'no'
    });
  }

  Future<void> updateDonation(String did, String name, String donation, String uname, String addr, String doid) async {
    return await donationCollection.document(did).setData({
      'donar' : uname,
      'donar_address' : addr,
      'donar_uid': doid,
      'donation': donation,
      'taken_by': name,
      'taken': 'yes'
    });
  }

  //donation list from snapshot
  List<Donation> _donationListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      return Donation(
          id : doc.documentID,
          donar: doc.data['donar'] ?? '',
          donaraddress: doc.data['donar_address'] ?? '',
          donaruid: doc.data['donar_uid'] ?? '',
          donation: doc.data['donation'] ?? '',
          takenby: doc.data['taken_by'] ?? '',
          taken: doc.data['taken'] ?? '',
      );
    }).toList();
  }


  UserData _userdFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: snapshot.documentID,
      address: snapshot.data['address'] ?? '',
      otype: snapshot.data['otype'] ?? '',
      name: snapshot.data['name'] ?? '',
    );
  }



  Stream<List<Donation>> get donations {
    return donationCollection.snapshots()
        .map(_donationListFromSnapshot);
  }

  Stream<List<Donation>> get donationsbyuser {

    final Query userdonations = donationCollection;
    return donationCollection.where('donar_uid' , isEqualTo: uid).snapshots()
        .map(_donationListFromSnapshot);
  }


  Stream<UserData> get userd {
    return userCollection.document(uid).snapshots()
        .map(_userdFromSnapshot);
  }
  }