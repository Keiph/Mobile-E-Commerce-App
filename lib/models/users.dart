class FirestoreUser{
  String userName;
  String phoneNo;

  FirestoreUser({required this.userName, required this.phoneNo});

  FirestoreUser.fromMap(Map <String, dynamic>? snapshot):
      userName = snapshot!['userName'] ?? '',
      phoneNo = snapshot['phoneNo'] ?? '';

}