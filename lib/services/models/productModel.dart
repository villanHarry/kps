import 'package:kps/utils/app_enums.dart';

class ProductModel {
  int? id;
  String? name;
  double? volt;
  double? price;
  String? image;
  imageType? type;
  double? outputUpperLimit;
  double? outputLowerLimit;

  ProductModel({
    this.id,
    this.name,
    this.volt,
    this.type,
    this.price,
    this.image,
    this.outputUpperLimit,
    this.outputLowerLimit,
  });
}
