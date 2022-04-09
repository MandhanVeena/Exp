import 'package:date_time_format/date_time_format.dart';

enum QuantityPriceType { quantity, fadeprice, price }

String getQuantityPrice(String qty, Map<String, List<double>> quantityPriceMap,
    QuantityPriceType quantityPriceType) {
  if (qty == "") {
    switch (quantityPriceType) {
      case QuantityPriceType.quantity:
        return quantityPriceMap.keys.first;
        break;
      case QuantityPriceType.fadeprice:
        return quantityPriceMap.values.first.first.toString();
        break;
      case QuantityPriceType.price:
        return quantityPriceMap.values.first.last.toString();
        break;
    }
  } else {
    switch (quantityPriceType) {
      case QuantityPriceType.quantity:
        return qty;
        break;
      case QuantityPriceType.fadeprice:
        return quantityPriceMap[qty].first.toString();
        break;
      case QuantityPriceType.price:
        return quantityPriceMap[qty].last.toString();
        break;
    }
  }
  return "";
}

bool isFadePriceEmpty(List<double> priceList) {
  return (priceList.first == priceList.last || priceList.first == 0)
      ? true
      : false;
}

String getOrderStatus(int status) {
  switch (status) {
    case 0:
      return "Pending";
      break;
    case 1:
      return "Dispatched";
      break;
    case 2:
      return "Delivered";
      break;
    case 3:
      return "Cancelled";
  }
  return "";
}

String getFormattedDateYearOrNot(int dateTime, String format) {
  DateTime date = DateTime.fromMillisecondsSinceEpoch(dateTime);
  //date = DateTime.parse("1999-11-24");
  if (date.year != DateTime.now().year) {
    format += " Y";
  }
  return date.format(format);
}
