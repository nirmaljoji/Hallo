import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hallo/models/group.dart';
import 'package:hallo/models/uid.dart';
import 'package:hallo/models/user.dart';

class DatabaseService {
  final String uid;
  static Firestore _firestore = Firestore.instance;
  DatabaseService({this.uid});

  final CollectionReference profileCollection =
  _firestore.collection('user_profiles');

  Future updateUserData(String name, String status, String phone, String email,
      Timestamp dob, String address) async {
    return await profileCollection.document(uid).setData({
      'user_name': name,
      'user_status': status,
      'user_email': email,
      'user_phone': phone,
      'dob': dob,
      'address': address,
    });
  }



  Future createGroup(friendsCollected, groupName) async {

    List friendsSort = friendsCollected.toSet().toList();
//    print(groupName);
    friendsSort.add(current_user_uid);

    DocumentReference docref =
    Firestore.instance.collection('groups').document();

    for (var i in friendsSort) {
      _firestore
          .collection('groups')
          .document(docref.documentID)
          .collection('group_members')
          .document(i)
          .setData({'check': true});
    }

    _firestore
        .collection('groups')
        .document(docref.documentID)
        .collection('group_members')
        .document(current_user_uid)
        .setData({'check': true});

         docref
        .collection('group_info')
        .document(docref.documentID)
        .setData({'group_name': groupName});
         docref
        .collection('group_info')
        .document(docref.documentID)
        .collection('admins')
        .document(current_user_uid)
        .setData({'date_created': DateTime.now()});

    for (var i in friendsSort) {
      _firestore
          .collection('messages')
          .document(i)
          .collection('groups_chat')
          .document(docref.documentID)
          .setData({
        'guid': docref.documentID
      });

      _firestore
          .collection('messages')
          .document(i)
          .collection('groups_chat')
          .document(docref.documentID)
          .collection('Chats')
          .document()
          .setData({
        //'to': docref.documentID.toString(),
        'from': current_user_uid,
        'text': 'new member added',
        'time': FieldValue.serverTimestamp(),
      });
    }
    //returning docref so we can get th edoc id to redirect user to newly formed group's chatpage
    return Future.value(docref.documentID);
  }

  Future<QuerySnapshot> checkIfMailExist(String email) {
    var doc =
    profileCollection.where('user_email', isEqualTo: email).getDocuments();
    return Future.value(doc);
  }

  Future updateProfile(String i) async {
    return await profileCollection.document(uid).updateData({'imageUrl': i});
  }

  Future updateFriend(String i, String suid) async {
    profileCollection
        .document(uid)
        .collection('friends')
        .document(suid)
        .setData({
      'user_id': suid,
    });
  }

  Future sendRequest(String suid) async {
    profileCollection
        .document(suid)
        .collection('requests')
        .document(uid)
        .setData({
      'user_id': uid,
    });
  }

  Stream<UserData> get userData {
    return profileCollection
        .document(uid)
        .snapshots()
        .map(_userDataFromSnapshot);
  }

  Stream<GroupData> get groupData {
    return Firestore.instance
        .collection('groups')
        .document(uid)
        .collection('group_info')
        .document(uid)
        .snapshots()
        .map(_groupDataFromSnapshot);
  }

  Stream<QuerySnapshot> requestDocuments() {
    return profileCollection.document(uid).collection('requests').snapshots();
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: snapshot.data['user_name'],
        status: snapshot.data['user_status'],
        phone: snapshot.data['user_phone'],
        email: snapshot.data['user_email'],
        imageUrl: snapshot.data['imageUrl'],
        dob: snapshot.data['dob'],
        address: snapshot.data['address']);
  }

  GroupData _groupDataFromSnapshot(DocumentSnapshot snapshot) {
    return GroupData(
        uid: uid,
        name: snapshot.data['group_name']);
  }

  Stream<DocumentSnapshot> getProfileData(String uid) {
    return profileCollection.document(uid).snapshots();
  }

  updateAdmin(List<String> selectedFriends, String guid) async {

   await Firestore.instance.collection('groups').document(guid).collection('group_info').document(guid).collection('admins').getDocuments().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.documents){
        print('deleing ${ds.documentID}');
        ds.reference.delete();
      }
    });

    print('DONTTTT REMOVE MEEE: ${selectedFriends}');
    for (var i in selectedFriends) {


      Firestore.instance
          .collection('groups')
          .document(guid)
          .collection('group_info')
          .document(guid)
          .collection('admins').document(i).setData({'date_created': DateTime.now()});

  }
    
  }


  updateMembers(List<String> selectedFriends, String guid,List<String> removedFriends) async  {
    //print("GOIUSSSS : $guid");

    await Firestore.instance.collection('groups').document(guid).collection('group_members').getDocuments().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.documents){
        //print('deleing ${ds.documentID}');
        ds.reference.delete();
      }
    });

    for (var i in removedFriends){
       print("GOING TO REMOVE : $i");

       await Firestore.instance.collection('messages').document(i).collection('groups_chat').document(guid).collection('chats').getDocuments().then((snapshot) {
         for (DocumentSnapshot ds in snapshot.documents) {
           //print('deleing ${ds.documentID}');
           ds.reference.delete();
         }
       });
        await Firestore.instance.collection('messages').document(i).collection('groups_chat').document(guid).delete();
    }



    selectedFriends.add(current_user_uid);
    for (var i in selectedFriends) {

      Firestore.instance
          .collection('groups')
          .document(guid)
          .collection('group_members')
          .document(i).setData({'check': true});

    }
    for ( var i in selectedFriends){


      _firestore
            .collection('messages')
            .document(i)
            .collection('groups_chat')
            .document(guid)
            .setData({
          'guid': guid
        });
    _firestore
        .collection('messages')
        .document(i)
        .collection('groups_chat')
        .document(guid)
        .collection('Chats')
        .document()
        .setData({
      //'to': docref.documentID.toString(),
      'from': current_user_uid,
      'text': 'New member added',
      'time': FieldValue.serverTimestamp(),
    });
    }

  }


}
