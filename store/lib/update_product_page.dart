import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:store/models/product_model.dart';
import 'package:store/widgets/custom_button.dart';
import 'package:store/widgets/custom_text_form_field.dart';

import 'services/update_product.dart';

class UpdateProductPage extends StatefulWidget {
  UpdateProductPage({super.key});
  static String id = 'update product';

  @override
  State<UpdateProductPage> createState() => _UpdateProductPageState();
}

class _UpdateProductPageState extends State<UpdateProductPage> {
  String? image, title, desc, price;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    ProductModel product =
        ModalRoute.of(context)!.settings.arguments as ProductModel;
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          title: Text(
            'Update product',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                CustomTextFormField(
                  hintText: 'Product name',
                  onChanged: (val) {
                    title = val;
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                CustomTextFormField(
                  hintText: 'Product description',
                  onChanged: (val) {
                    desc = val;
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                CustomTextFormField(
                  hintText: 'Product price',
                  inputType: TextInputType.number,
                  onChanged: (val) {
                    price = val;
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                CustomTextFormField(
                  hintText: 'Product image',
                  onChanged: (val) {
                    image = val;
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                CustomButton(
                  label: 'Update',
                  onTap: (() async {
                    setState(() {
                      isLoading = true;
                    });
                    try {
                      await updateProductMethod(product);
                      print('success');
                    } catch (e) {
                      print(e.toString());
                    }
                    setState(() {
                      isLoading = false;
                    });
                  }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> updateProductMethod(ProductModel product) async {
    await UpdateProduct().updateProduct(
        id: product.id.toString(),
        category: product.category,
        image: image ?? product.image,
        price: price ?? product.price.toString(),
        title: title ?? product.title,
        description: desc ?? product.description);
  }
}
