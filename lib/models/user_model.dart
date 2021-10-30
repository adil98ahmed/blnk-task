import 'dart:io';

class UserModel {
  String id, firstName, lastName, address, mobile;
  File frontIdImage, backIdImage;
  UserModel(
      {this.id,
      this.firstName,
      this.lastName,
      this.address,
      this.mobile,
      this.frontIdImage,
      this.backIdImage});
}
