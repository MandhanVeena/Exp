import 'package:flutter/material.dart';
import 'package:lucky/constants/constants.dart';
import 'package:provider/provider.dart';
import '../components/appBar.dart';

import 'body.dart';
import '../components/drawer.dart';
import '../cartScreen/cartStore.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        //appBar: buildAppBar(),
        drawer: buildDrawer(context),
        body: Body());
  }
}
