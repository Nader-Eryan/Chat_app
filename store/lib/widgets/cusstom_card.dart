import 'package:flutter/material.dart';
import 'package:store/models/product_model.dart';
import 'package:store/services/update_product.dart';

import '../update_product_page.dart';

class CustomCard extends StatelessWidget {
  CustomCard({required this.product, super.key});
  ProductModel product;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, UpdateProductPage.id, arguments: product);
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Card(
            elevation: 10,
            shadowColor: Colors.grey,
            // color: Colors.greenAccent,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(
                height: 48,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(product.title.substring(0, 7)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('\$ ${product.price.toString()}'),
                    const Icon(
                      Icons.favorite,
                      color: Colors.red,
                    )
                  ],
                ),
              )
            ]),
          ),
          Positioned(
            top: -40,
            right: 8,
            child: Image.network(width: 100, height: 100, product.image),
          ),
        ],
      ),
    );
  }
}
