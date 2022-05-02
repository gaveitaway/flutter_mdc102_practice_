// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
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

const url = 'https://www.handong.edu/';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

List<bool> isSelected = [true, false];
Map<int, bool> isFavorite = {};
bool isView = false;
List<bool> ListisView = [false, false];

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.fromLTRB(110.0, 8.0, 8.0, 8.0),
          child: const Text('Main'),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.search,
              semanticLabel: 'filter',
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/fourth');
            },
          ),
          IconButton(
              icon: const Icon(
                Icons.language,
                semanticLabel: 'filter',
              ),
              onPressed: () {
                launch(url, forceWebView: false, forceSafariVC: false);
              }),
        ],
      ),
      body: Center(
        child: Column(children: [
          toggleButton(),
          Container(
            height: 600,
            child: OrientationBuilder(builder: (context, orientation) {
              return isSelected[0]
                  ? GridView.count(
                      padding: const EdgeInsets.all(16.0),
                      childAspectRatio: 8.0 / 9.0,
                      crossAxisCount:
                          orientation == Orientation.portrait ? 2 : 3,
                      children: _buildGridCards(context),
                    )
                  : buildListViewCard();
            }),
          ),
        ]),
      ),
      resizeToAvoidBottomInset: false,
      drawer: buildDrawer(context),
    );
  }

  Widget buildListViewCard() {
    return Container(
      height: 600,
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: buildListCards(context),
      ),
    );
  }

  List<Widget> buildListCards(context) {
    List<Product> products = ProductsRepository.loadProducts(Category.all);

    if (products.isEmpty) {
      return const <Widget>[];
    }
    return products.map((product) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: Image(
            width : 60,
            height : 60,
            image: AssetImage(product.assetName),
            fit: BoxFit.fitWidth,
          ),
          title: Column(
            children: [
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.yellow, size: 10),
                  const Icon(Icons.star, color: Colors.yellow, size: 10),
                  const Icon(Icons.star, color: Colors.yellow, size: 10),
                ],
              ),
              Text(
                product.name,
              ),
              Text(
                product.location,
              ),
            ],

          ),
          trailing: Container(
            height: 40,
            width: 50,
            child: TextButton(
              child: Text("more"),
              onPressed: () {
                Duration(seconds: 2);
                Navigator.pushNamed(context, '/seventh', arguments: product);
              },
            ),
          ),
        ),
      );
    }).toList();
  }

  Widget toggleButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(200.0,0,0,0),
      child: ToggleButtons(
        children: <Widget>[
          Icon(Icons.grid_view),
          Icon(Icons.list),
        ],
        onPressed: (int index) {
          print(isSelected);
          setState(() {
            if (isSelected[0]) {
              isSelected = [false, true];
            } else {
              isSelected = [true, false];
            }
          });
        },
        isSelected: isSelected,
      ),
    );
  }
}

Widget buildDrawer(BuildContext context) {
  return Drawer(
    // Drawer 화면 그리기
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        const DrawerHeader(
          // Header
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          padding: EdgeInsets.only(top: 10),
          child: Padding(
            padding: EdgeInsets.fromLTRB(10.0, 100, 10, 10),
            child: Text(
              'Pages',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
        ),
        ListTile(
          // Item
          leading: Icon(Icons.home, color: Colors.blue),

          title: Text('Home'),
          onTap: () {
            Navigator.pushNamed(context, '/second');
          },
        ),
        ListTile(
          leading: Icon(Icons.search, color: Colors.blue),
          title: Text('Search'),
          onTap: () {
            Navigator.pushNamed(context, '/fourth');
          },
        ),
        ListTile(
          leading: Icon(Icons.location_city, color: Colors.blue),
          title: Text('Favorite Hotel'),
          onTap: () {
            Navigator.pushNamed(context, '/fifth');
          },
        ),
        ListTile(
          leading: Icon(Icons.person, color: Colors.blue),
          title: Text('My Page'),
          onTap: () {
            Navigator.pushNamed(context, '/six');
          },
        ),
        ListTile(
          leading: const Icon(Icons.location_city, color: Colors.blue),
          title: const Text('Log out'),
          onTap: () {
            Navigator.pushNamed(context, '/login');
          },
        ),
      ],
    ),
  );
}

List<Card> _buildGridCards(BuildContext context) {
  List<Product> products = ProductsRepository.loadProducts(Category.all);

  if (products.isEmpty) {
    return const <Card>[];
  }

  final ThemeData theme = Theme.of(context);
  final NumberFormat formatter = NumberFormat.simpleCurrency(
      locale: Localizations.localeOf(context).toString());

  return products.map((product) {
    return Card(
      clipBehavior: Clip.antiAlias,
      // TODO: Adjust card heights (103)
      child: Column(
        // TODO: Center items on the card (103)
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AspectRatio(
            aspectRatio: 18 / 11,
            child: Hero(
              tag: product.id,
              child: Image(
                image: AssetImage(product.assetName),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.yellow, size: 10),
                        const Icon(Icons.star, color: Colors.yellow, size: 10),
                        const Icon(Icons.star, color: Colors.yellow, size: 10),
                      ],
                    ),
                    Text(
                      product.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                        color: Colors.black,
                      ),
                      maxLines: 1,
                    ),
                    //const SizedBox(height: 8.0),
                    Text(
                      product.location,
                      style: theme.textTheme.overline,
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    Container(
                      height: 40,
                      width: 200,
                      child: TextButton(
                        child: Text("more"),
                        onPressed: () {
                          transitionDuration:
                          Duration(seconds: 2);
                          Navigator.pushNamed(context, '/seventh',
                              arguments: product);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }).toList();
}
