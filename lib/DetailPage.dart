import 'package:toggle_switch/toggle_switch.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'search.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'login.dart';
import 'model/products_repository.dart';
import 'model/product.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'home.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context)!.settings.arguments as Product;

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 0, 30, 0),
            child: Text(product.name),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            child: Stack(children: <Widget>[
              Hero(
                tag: product.id,
                child: Image(
                  image: AssetImage(product.assetName),
                  fit: BoxFit.fitWidth,
                  width: 1000,
                  height: 240,
                ),
              ),
              IconButton(
                icon: Padding(
                    padding: EdgeInsets.fromLTRB(350, 8, 8, 8),
                    child: (isFavorite[product.id] == true)
                        ? Icon(
                            Icons.favorite,
                            semanticLabel: 'filter',
                            size: 20,
                            color: Colors.red,
                          )
                        : Icon(
                            Icons.favorite_border,
                            semanticLabel: 'filter',
                            size: 20,
                            color: Colors.red,
                          )),
                onPressed: () {
                  Navigator.pushNamed(context, '/second');
                },
              ),
            ]),
            onDoubleTap: () {
              setState(() {
                print("hi");
                if (isFavorite[product.id] == true) {
                  isFavorite.addAll({product.id: false});
                } else
                  isFavorite.addAll({product.id: true});
              });
              //Navigator.pushNamed(context,'/fifth',arguments:product);
            },
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(35.0, 20, 0, 0),
            child: Container(
              child: Row(
                children: [
                  const Icon(Icons.star, color: Colors.yellow),
                  const Icon(Icons.star, color: Colors.yellow),
                  const Icon(Icons.star, color: Colors.yellow),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(35.0, 10, 0, 0),
            child: AnimatedTextKit(animatedTexts: [
              TyperAnimatedText(
                product.name,
              ),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(35, 10, 0, 0),
            child: Row(
              children: [
                const Icon(Icons.location_on, color: Colors.lightBlue),
                Text("   " + product.location)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(35.0, 10, 0, 0),
            child: Row(
              children: [
                const Icon(Icons.phone, color: Colors.lightBlue),
                Text("   " + product.phonenum)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(35.0, 10, 35, 0),
            child: const Divider(
              height: 1,
              thickness: 1,
              endIndent: 0,
              color: Colors.black,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(35.0, 10, 35, 0),
            child: Text(
              product.Description,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: Colors.blueAccent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
