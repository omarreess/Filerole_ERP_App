
 import 'package:hive/hive.dart';

part 'MasterAccountModel.g.dart';

 @HiveType(typeId: 0)
 
 

class MasterAccountModel  extends HiveObject {
   @HiveField(0)
  String? storeName;
   @HiveField(1)
  String? domain;
   @HiveField(2)
  String? img;
   @HiveField(3)
  String? accessToken ;
   @HiveField(4)
  String? id;
   @HiveField(5)
  String? name;
   @HiveField(6)
  String? lastName;
   @HiveField(7)
  String? firstName;
   @HiveField(8)
  String? email;
   @HiveField(9)
  String? phoneNumber;
   @HiveField(10)
  String? address;
   @HiveField(11)
  String? endpoint;
   @HiveField(12)
  String?   subscriptions;
   @HiveField(13)
  String?   userType;
  
   MasterAccountModel({
    this.name,
    this.email,
    this.phoneNumber,
    this.address,
    this.subscriptions,
    this.id,
    this.img,
    this.domain,
    this.endpoint,
    this.storeName,
    this.firstName,
    this.lastName,
    this.accessToken,
  this.userType
  });
}
