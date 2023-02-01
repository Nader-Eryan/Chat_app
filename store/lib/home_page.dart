import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:store/models/product_model.dart';
import 'package:store/widgets/cusstom_card.dart';

import 'services/get_all_products.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static String id = 'HomePage';
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              'New Trend',
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon:
                      Icon(FontAwesomeIcons.cartShopping, color: Colors.black))
            ]),
        body: FutureBuilder<List<ProductModel>>(
          future: GetProductsService().getAllProducts(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<ProductModel> products = snapshot.data!;
              return Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 50),
                child: GridView.builder(
                    itemCount: products.length,
                    clipBehavior: Clip.none,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.6,
                        crossAxisSpacing: 4,
                        mainAxisSpacing: 60),
                    itemBuilder: (context, index) {
                      return CustomCard(product: products[index]);
                    }),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
