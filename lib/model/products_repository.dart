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

import 'product.dart';

class ProductsRepository {
  static List<Product> loadProducts(Category category) {
    const allProducts = <Product> [
      Product(
        category: Category.accessories,
        id: 0,
        isFeatured: true,
        name: 'Polonia hotel',
        location: 'al. Jerozolimskie 45, 00-692 warszawa',
        price: 0,
        phonenum: '31-333-1713',
          Description: 'The hotel is located 5 minutes from the beach and has 128 floors. In addition, there is a lake where you can catch fish around the hotel with a free buffet.',
      ),
      Product(
        category: Category.accessories,
        id: 1,
        isFeatured: true,
        name: 'Bethel Hotel',
        location:'pohang handongro-12 between cyper and rodem-9',
        price: 58,
        phonenum: '05345-2650-1713',
          Description:'Bethel Hotel is Sonyangwon RC, and there is a kiosk underneath and a pizzeria. The roll call is at 11 oclock, so you have to either stay overnight or receive the roll call. Otherwise, it is a penalty point.',
      ),
      Product(
        category: Category.accessories,
        id: 2,
        isFeatured: false,
        name: 'Hilton Hotel',
        location:'kore-123 location street',
        price: 35,
        phonenum: '0564-64-33',
        Description:'There is Yeongildae Lake in front of the Hilton Hotel, and you can rent a swimsuit for swimming. Also, BBQ is free and you need to reserve a bbq seat.',
      ),
      Product(
        category: Category.accessories,
        id: 3,
        isFeatured: true,
        name: 'Lotte Hotel',
        location:'484 - 7 bomunro Gyeongjusi geongsangbukdo KR',
        price: 98,
        phonenum: '123-5647-13',
        Description:'',
      ),
      Product(
        category: Category.accessories,
        id: 4,
        isFeatured: false,
        name: 'Silla Hotel',
        location:'484 - 7 bomunro Gyeongjusi geongsangbukdo KR',
        price: 34,
        phonenum: '324-21-1713',
        Description:'Hotel Shilla is operating with pride and responsibility as the face of the Samsung Group, hosting numerous state visits and international events.',
      ),
      Product(
        category: Category.accessories,
        id: 5,
        isFeatured: false,
        name: 'Hanwha Hotel',
        location:'484 - 7 bomunro Gyeongjusi geongsangbukdo KR',
        price: 12,
        phonenum: '30-263130-1713',
        Description:'',
      ),
      Product(
        category: Category.accessories,
        id: 6,
        isFeatured: false,
        name: 'Samsung Hotel',
        location:'484 - 7 bomunro Gyeongjusi geongsangbukdo KR',
        price: 16,
        phonenum: '120-22160-17133',
        Description:'',
      ),

    ];
    if (category == Category.all) {
      return allProducts;
    } else {
      return allProducts.where((Product p) {
        return p.category == category;
      }).toList();
    }
  }
}
