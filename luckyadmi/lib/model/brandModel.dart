import 'package:luckyadmi/db/brand.dart';

class BrandModel {
  String brandId;
  String brandName;
  String image;
  double priority;

  BrandModel(
      this.brandId,
      this.brandName,
      this.image,
      this.priority);
}

List<BrandModel> convertMapToBrand(List brands) {
  List<BrandModel> finalBrands = [];
  for (var item in brands) {
    finalBrands.add(
      BrandModel(
          item['brandId'],
          item['brandName'],
          item['image'],
          item['priority']),
    );
  }
  return finalBrands;
}

Future<List<BrandModel>> fetchBrandList() async {
  List resultant = await BrandService().getBrands1();
  if (resultant == null) {
    print("unable to retrieve");
    return [];
  } else {
    return convertMapToBrand(resultant);
  }
}
