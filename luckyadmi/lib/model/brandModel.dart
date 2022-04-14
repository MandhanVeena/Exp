import 'package:luckyadmi/db/brand.dart';

class BrandModel {
  String catId;
  String catName;
  String image;
  double priority;

  BrandModel(
      this.catId,
      this.catName,
      this.image,
      this.priority);
}

List<BrandModel> convertMapToBrand(List brands) {
  List<BrandModel> finalBrands = [];
  for (var item in brands) {
    finalBrands.add(
      BrandModel(
          item['catId'],
          item['catName'],
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
