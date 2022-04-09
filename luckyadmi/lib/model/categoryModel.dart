import 'package:luckyadmi/db/category.dart';

class CategoryModel {
  String catId;
  String catName;
  String image;
  double priority;

  CategoryModel(
      this.catId,
      this.catName,
      this.image,
      this.priority);
}

List<CategoryModel> convertMapToCategory(List categories) {
  List<CategoryModel> finalCategories = [];
  for (var item in categories) {
    finalCategories.add(
      CategoryModel(
          item['catId'],
          item['catName'],
          item['image'],
          item['priority']),
    );
  }
  return finalCategories;
}

Future<List<CategoryModel>> fetchCategoryList() async {
  List resultant = await CategoryService().getCategories1();
  if (resultant == null) {
    print("unable to retrieve");
    return [];
  } else {
    return convertMapToCategory(resultant);
  }
}
