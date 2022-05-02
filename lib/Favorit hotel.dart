import 'package:toggle_switch/toggle_switch.dart';
import 'package:url_launcher/url_launcher.dart';
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
import 'DetailPage.dart';
import 'package:shrine/Favorit hotel.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    List<Product> products = ProductsRepository.loadProducts(Category.all);
    List<int> favoriteProductsId = isFavorite.keys.where((element) => isFavorite[element] == true).toList();
    List<Product> favoriteProducts = products.where((element) => favoriteProductsId.contains(element.id)).toList();

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Favorite"),
        ),
      ),
      body: buildDismissibleCard(favoriteProducts),
    );
  }

  Widget buildDismissibleCard(List<Product> products){
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final keyValue = products[index].id.toString();
        return Dismissible(
          key: Key(keyValue),
          onDismissed: (direction) {
            setState(() {
              isFavorite.remove(products[index].id);
            });
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('${products[index].name} dismissed')));
          },
          background: Container(color: Colors.red),
          child: favoriteProductCard(products[index].name),
        );
      },
    );
  }
}
Widget favoriteProductCard(String name){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
      name,
      style: TextStyle(fontSize: 30),
    ),
  );
}

