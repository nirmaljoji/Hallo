import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hallo/models/user.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  final CollectionReference profileCollection =
      Firestore.instance.collection('user_profiles');

  Future updateUserData(String name, String status, String phone, String email,
      DateTime dob, String address) async {
    return await profileCollection.document(uid).setData({
      'user_name': name,
      'user_status': status,
      'user_email': email,
      'user_phone': phone,
      'dob': dob,
      'address': address,
    });
  }

//  Future createFriendsCollection() async{
//    return  profileCollection.document(uid).collection('friends').document("test").setData({
//      'user_id':"dummy"
//    });
//  }


  Future<QuerySnapshot> checkIfMailExist(String email) {
    var doc = profileCollection.where('user_email',isEqualTo: email).getDocuments();
    return Future.value(doc);


  }

  Future updateProfile(
      String i) async {
    return await profileCollection.document(uid).updateData(
      {
        'imageUrl':i
      });
  }

  Future updateFriend(String i,String suid) async {
    profileCollection.document(uid).collection('friends').document(suid).setData({
      'user_id':suid,
    });

  }

  Future sendRequest(String suid) async {
    profileCollection.document(suid).collection('requests').document(uid).setData({
      'user_id':uid,
    });

  }


    
  


      

//  Stream<DocumentSnapshot> get profile {
//
////    print("database class :$uid");
////    DocumentReference docRef = await
////         Firestore.instance.collection('user_profiles').document(uid);
////    await docRef.get().then((DocumentSnapshot datasnapshot) {
////      if (datasnapshot.exists) {
////
////       String u;
////       String s;
////       String e;
////       String p;
////        u=datasnapshot.data['user_name'];
////        s=datasnapshot.data['user_status'];
////        p=datasnapshot.data['user_phone'];
////        e=datasnapshot.data['user_email'];
////
////        User_Profile up=new User_Profile(u,s,p,e);
////        print(datasnapshot.data);
////
////        return profileCollection.document((uid));
////
////      }
////      else{
////        print("document not found");
////        return null;
////      }
//
//
////
//  return profileCollection.document()
//
//  }

  //hallo Stream



Stream<UserData> get userData{
    return profileCollection.document(uid).snapshots().map(_userDataFromSnapshot);
}

Stream<QuerySnapshot> requestDocuments(){
    return profileCollection.document(uid).collection('requests').snapshots();
}

UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
        uid:uid,

        name: snapshot.data['user_name'],
        status: snapshot.data['user_status'],
        phone: snapshot.data['user_phone'],
        email: snapshot.data['user_email'],
        imageUrl: snapshot.data['imageUrl'],
        dob: snapshot.data['dob'],
        address: snapshot.data['address']

    );
}


Stream<DocumentSnapshot> getProfileData(String uid){
    return profileCollection.document(uid).snapshots();
}

}
