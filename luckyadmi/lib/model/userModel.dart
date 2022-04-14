class UserModel {
  String userId, username, phone, role;
  List<String> addressIdsList;
  int lastSignInTime, creationTime, buildNumber;

  UserModel(
      this.userId,
      this.username,
      this.phone,
      this.role,
      this.addressIdsList,
      this.lastSignInTime,
      this.creationTime,
      this.buildNumber);

  UserModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    username = json['username'];
    phone = json['phone'];
    role = json['role'];
    addressIdsList = json['addressIdsList'];
    lastSignInTime = json['lastSignInTime'];
    creationTime = json['creationTime'];
    buildNumber = json['buildNumber'];
  }

  Map<String, dynamic> toJson() {
    final data = Map<String, dynamic>();
    data['userId'] = this.userId;
    data['username'] = this.username;
    data['phone'] = this.phone;
    data['role'] = this.role;
    data['addressIdsList'] = this.addressIdsList;
    data['lastSignInTime'] = this.lastSignInTime;
    data['creationTime'] = this.creationTime;
    data['buildNumber'] = this.buildNumber;
    return data;
  }
}
