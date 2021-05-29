class UserData {
  String uid;
  String emailid;
  String name;
  String mobilenumber;
  String usertype;
  String photourl;
  UserData(
      {this.uid,
      this.emailid,
      this.name,
      this.mobilenumber,
      this.usertype,
      this.photourl});
  Map<String, dynamic> uservalues() => {
        'Uid': uid,
        'Email Id': emailid,
        'Name': name,
        'Mobile Number': mobilenumber,
        'User Type': usertype,
        'Photo Url': photourl,
      };
  factory UserData.fromDocument(doc) {
    return UserData(
      uid: doc['Uid'],
      emailid: doc['Email Id'],
      name: doc['Name'],
      mobilenumber: doc['Mobile Number'],
      usertype: doc['User Type'],
      photourl: doc['Photo Url'],
    );
  }
}
