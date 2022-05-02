import 'package:toggle_switch/toggle_switch.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'search.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'home.dart';
import 'login.dart';
import 'model/products_repository.dart';
import 'model/product.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lottie/lottie.dart';

import 'package:flutter/material.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    List<Product> products = ProductsRepository.loadProducts(Category.all);
    List<int> favoriteProductsId = isFavorite.keys
        .where((element) => isFavorite[element] == true)
        .toList();
    List<Product> favoriteProducts = products
        .where((element) => favoriteProductsId.contains(element.id))
        .toList();

    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.fromLTRB(10, 8.0, 8.0, 8.0),
          child: Text('My Page'),
        ),
      ),
      body: buildProductCard(favoriteProducts),
    );
  }
}

class MyClipper extends CustomClipper<Rect> {
  Rect getClip(Size size) {
    return Rect.fromLTWH(0, 0, 150, 150);
  }

  bool shouldReclip(oldClipper) {
    return false;
  }
}

Widget favoriteProductCard(Product product) {
  return Card(
    elevation: 100,
    child: Stack(
      children: [
        Image(
          image: AssetImage(product.assetName),
          fit: BoxFit.fitWidth,
          width: 1000,
          height: 240,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 8, 8, 8),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Text(product.name,
                    style: TextStyle(fontSize: 30, color: Colors.white)),
              ),
              Text(product.location,
                  style: TextStyle(fontSize: 20, color: Colors.white)),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildProductCard(List<Product> products) {
  return Container(
    width: 400,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: ClipOval(
            clipper: MyClipper(),
            child: Lottie.network(
              'https://raw.githubusercontent.com/xvrh/lottie-flutter/master/example/assets/Mobilo/A.json',
              height: 100,
              width: 100,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(0),
          child: Text(
            'Minsoo KIM',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Colors.black,
            ),
          ),
        ),
        const Text(
          '21700094',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: Colors.black,
          ),
        ),
        const Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
          child: Text(
            'My Favorite Hotel List',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Colors.black,
            ),
          ),
        ),

        buildProductCard1(products),
      ],
    ),
  );
}

Widget buildProductCard1(List<Product> products) {
  print(products);
  return Container(
    height: 500,

    child: ListView(
      children:
          products.map((products) => favoriteProductCard(products)).toList(),
    ),
  );
}
