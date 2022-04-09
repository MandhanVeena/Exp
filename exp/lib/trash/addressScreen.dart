// import 'package:flutter/material.dart';
// import 'package:lucky/constants/constants.dart';
// import 'package:lucky/screens/checkOutScreen/orderModel.dart';

// class AddressScreen extends StatefulWidget {
//   @override
//   _AddressScreenState createState() => _AddressScreenState();
// }

// class _AddressScreenState extends State<AddressScreen> {
//   List<AddressModel> addressList = [
//     AddressModel("1", "fullAddress", "lko", "226001"),
//     AddressModel("2", "fullAddress2", "KNPR", "22327"),
//     AddressModel("3", "fullAddress3", "lko", "226001")
//   ];

//   AddressModel selectedAddress;
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;

//     return Scaffold(
//         appBar: AppBar(
//           title: Text("Address"),
//         ),
//         bottomNavigationBar: Padding(
//           padding: EdgeInsets.all(5),
//           child: MaterialButton(
//             color: themeColor,
//             textColor: Colors.white,
//             onPressed: (){

//             },
//             child: Text("Add Address"),),),
//         body: CustomScrollView(slivers: [
//           SliverToBoxAdapter(
//               child: Container(
//             height: size.height * 0.8,
//             child: ListView.builder(
//                 itemCount: addressList.length,
//                 itemBuilder: (context, index) => ListTile(
//                       title: Text(addressList[index].fullAddress),
//                       trailing: Radio(
//                         activeColor: themeColor,
//                         value: addressList[index],
//                         groupValue: selectedAddress,
//                         onChanged: (AddressModel value) {
//                           setState(() {
//                             selectedAddress = value;
//                             Navigator.pop(context, selectedAddress);
//                           });
//                         },
//                       ),
//                     )),
//           ))
//         ]));
//   }
// }

// // class AddressTile extends StatefulWidget {
// //   AddressTile({Key key, this.addressModel}) : super(key: key);

// //   final AddressModel addressModel;

// //   @override
// //   _AddressTileState createState() => _AddressTileState();
// // }

// // class _AddressTileState extends State<AddressTile> {
// //   @override
// //   Widget build(BuildContext context) {
// //     AddressModel addressModel = widget.addressModel;

// //     Size size = MediaQuery.of(context).size;

// //     return Text("");

// //     // return InkWell(
// //     //   onTap: () {
// //     //     var qty = store.getProductQty(product);
// //     //     store.setActive(product, qty);
// //     //     Navigator.push(
// //     //         context, MaterialPageRoute(builder: (context) => DetailsScreen()));
// //     //   },
// //     //   child: Container(
// //     //     margin: EdgeInsets.all(5),
// //     //     decoration: BoxDecoration(
// //     //         color: Colors.white,
// //     //         borderRadius: BorderRadius.circular(
// //     //           (8),
// //     //         ),
// //     //         boxShadow: [
// //     //           BoxShadow(
// //     //               offset: Offset(0, 10),
// //     //               blurRadius: 10,
// //     //               color: Colors.grey.withOpacity(0.23))
// //     //         ]),
// //     //     child: Row(
// //     //       children: [
// //     //         Padding(
// //     //           padding: const EdgeInsets.symmetric(horizontal: 5),
// //     //           child: Image.network(
// //     //             product.images[0],
// //     //             fit: BoxFit.contain,
// //     //             width: size.height * 0.12,
// //     //             height: size.height * 0.15,
// //     //           ),
// //     //         ),
// //     //         Column(
// //     //           crossAxisAlignment: CrossAxisAlignment.start,
// //     //           children: [
// //     //             Container(
// //     //               width: size.width * 0.35,
// //     //               child: Padding(
// //     //                 padding: const EdgeInsets.fromLTRB(7, 15, 0, 0),
// //     //                 child: Text(
// //     //                   product.name,
// //     //                   style: TextStyle(
// //     //                     fontSize: 17.5,
// //     //                     letterSpacing: -0.2,
// //     //                   ),
// //     //                 ),
// //     //               ),
// //     //             ),
// //     //             SizedBox(height: 10),
// //     //             Row(
// //     //               children: [
// //     //                 Padding(
// //     //                   padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
// //     //                   child: Text(
// //     //                     "\u{20B9} " +
// //     //                         // store.activeProduct.product.quantityPriceMap[store.activeProduct.qty].last.toString() ??
// //     //                         // widget.product.quantityPriceMap.values.first.last
// //     //                         //     .toString(),
// //     //                         getQuantityPrice(qty, product.quantityPriceMap,
// //     //                             QuantityPriceType.price),
// //     //                     //(qty == "" ? product.quantityPriceMap.values.first.last.toString() : product.quantityPriceMap[qty].last.toString()),
// //     //                     textAlign: TextAlign.left,
// //     //                     style: TextStyle(
// //     //                         color: themeColor,
// //     //                         fontWeight: FontWeight.bold,
// //     //                         fontSize: 16),
// //     //                   ),
// //     //                 ),
// //     //                 Padding(
// //     //                   padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
// //     //                   child: isFadePriceEmpty(
// //     //                           product.quantityPriceMap.values.first)
// //     //                       ? Text('')
// //     //                       : Text(
// //     //                           "\u{20B9} " +
// //     //                               getQuantityPrice(
// //     //                                   qty,
// //     //                                   product.quantityPriceMap,
// //     //                                   QuantityPriceType.fadeprice),
// //     //                           //store.activeProduct.product.quantityPriceMap[store.activeProduct.qty].first.toString() ??
// //     //                           // widget.product.quantityPriceMap.values
// //     //                           //     .first.first
// //     //                           //     .toString(),
// //     //                           textAlign: TextAlign.left,
// //     //                           style: TextStyle(
// //     //                               color: Colors.grey,
// //     //                               decoration: TextDecoration.lineThrough,
// //     //                               fontSize: 16),
// //     //                         ),
// //     //                 ),
// //     //               ],
// //     //             ),
// //     //             SizedBox(height: 10),
// //     //             Container(
// //     //               margin: const EdgeInsets.fromLTRB(10, 0, 0, 10),
// //     //               height: 25,
// //     //               padding: EdgeInsets.only(left: 8),
// //     //               decoration: BoxDecoration(
// //     //                   border: Border.all(color: themeColor, width: 1),
// //     //                   borderRadius: BorderRadius.circular(50)),
// //     //               child: DropdownButton<String>(
// //     //                   underline: SizedBox(),
// //     //                   hint: Text(product.quantityPriceMap.keys.first),
// //     //                   onChanged: (newValue) {
// //     //                     setState(() {
// //     //                       qty = newValue;
// //     //                     });
// //     //                     // store.activeProduct.qty = newValue;
// //     //                     // setState(() {
// //     //                     //   store.activeProduct.qty = newValue;
// //     //                     // });
// //     //                   },
// //     //                   value: getQuantityPrice(qty, product.quantityPriceMap,
// //     //                       QuantityPriceType.quantity),
// //     //                   items: widget.product.quantityPriceMap.keys
// //     //                       .map((e) => DropdownMenuItem<String>(
// //     //                             child: Text(
// //     //                               e,
// //     //                               style: TextStyle(fontSize: 12),
// //     //                             ),
// //     //                             value: e,
// //     //                           ))
// //     //                       .toList()),
// //     //             ),
// //     //           ],
// //     //         ),
// //     //         Spacer(),
// //     //         Container(
// //     //           height: size.height * 0.15,
// //     //           child: Column(
// //     //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //     //             children: [
// //     //               Padding(
// //     //                 padding: const EdgeInsets.only(right: 5, top: 20),
// //     //                 child: Icon(
// //     //                   Icons.favorite_border,
// //     //                   color: Colors.red,
// //     //                   size: 40,
// //     //                 ),
// //     //               ),
// //     //               /*store.exists(product) == false
// //     //                   ? InkWell(
// //     //                       onTap: () async {
// //     //                         store.setActive(product);
// //     //                         store.addToBasket(store.activeProduct);
// //     //                         print(store.activeProduct);
// //     //                       },
// //     //                       child: Container(
// //     //                         margin: EdgeInsets.only(bottom: 10, right: 20),
// //     //                         padding: EdgeInsets.symmetric(
// //     //                             vertical: 3, horizontal: 15),
// //     //                         decoration: BoxDecoration(
// //     //                             border: Border.all(color: themeColor, width: 1),
// //     //                             borderRadius: BorderRadius.circular(50)),
// //     //                         child: Text(
// //     //                           'Add',
// //     //                           style: TextStyle(
// //     //                               fontSize: 16, color: Colors.grey.shade600),
// //     //                         ),
// //     //                       ),
// //     //                     )
// //     //                   : Container(
// //     //                       margin: EdgeInsets.only(bottom: 10, right: 20),
// //     //                       padding:
// //     //                           EdgeInsets.symmetric(vertical: 5, horizontal: 5),
// //     //                       decoration: BoxDecoration(
// //     //                           border: Border.all(color: themeColor, width: 1),
// //     //                           borderRadius: BorderRadius.circular(50)),
// //     //                       child: Row(mainAxisSize: MainAxisSize.min, children: [
// //     //                         Padding(
// //     //                           padding: const EdgeInsets.only(right: 10),
// //     //                           child: InkWell(
// //     //                             onTap: () {
// //     //                               store.removeFromBasket(store.activeProduct);
// //     //                             },
// //     //                             child: Icon(
// //     //                               Icons.remove,
// //     //                               size: 18,
// //     //                               color: Colors.grey.shade600,
// //     //                             ),
// //     //                           ),
// //     //                         ),
// //     //                         Text(
// //     //                           store.activeProduct.quantity.toString(),
// //     //                           style: TextStyle(fontSize: 13),
// //     //                         ),
// //     //                         Padding(
// //     //                           padding: const EdgeInsets.only(left: 10),
// //     //                           child: InkWell(
// //     //                             onTap: () {
// //     //                               store.addToBasket(store.activeProduct);
// //     //                             },
// //     //                             child: Icon(
// //     //                               Icons.add,
// //     //                               size: 18,
// //     //                               color: Colors.grey.shade600,
// //     //                             ),
// //     //                           ),
// //     //                         ),
// //     //                       ]),
// //     //                     ),*/
// //     //             ],
// //     //           ),
// //     //         ),
// //     //       ],
// //     //     ),
// //     //   ),
// //     // );
// //   }
// // }
