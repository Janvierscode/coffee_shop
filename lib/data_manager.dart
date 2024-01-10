import 'dart:convert';
import 'data_model.dart';
import 'package:http/http.dart' as http;

class DataManager {
  List<Category>? _menu;
  List<ItemInCart> cart = [];

  fetchMenu() async {
    try {
      const url = "https://firtman.github.io/coffeemasters/api/menu.json";
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        _menu = [];
        var decodedData = jsonDecode(response.body) as List<dynamic>;
        for (var json in decodedData) {
          _menu?.add(Category.fromJson(json));
        }
      } else {
        throw Exception("Error loading menu");
      }
    } catch (e) {
      throw Exception("Error loading menu");
    }
  }

  Future<List<Category>> getMenu() async {
    if (_menu == null) {
      await fetchMenu();
    }
    return _menu!;
  }

  cartAdd(Product product) {
    var item = cart.firstWhere((element) => element.product.id == product.id,
        orElse: () => ItemInCart(product: product, quantity: 0));
    if (item.quantity == 0) {
      cart.add(ItemInCart(product: product, quantity: 1));
    } else {
      item.quantity++;
    }
  }

  // cartRemove(Product product) {
  //   var item = cart.firstWhere((element) => element.product.id == product.id,
  //       orElse: () => ItemInCart(product: product, quantity: 0));
  //   if (item.quantity == 0) {
  //     cart.remove(item);
  //   } else {
  //     item.quantity--;
  //   }
  // }

  //  cartClear() {
  //   cart.clear();
  // }

  //  double cartTotal() {
  //   return cart.fold(0, (previousValue, element) {
  //     return previousValue + element.product.price * element.quantity;
  //   });
  // }

  // cartAdd(Product product) {
  //   bool found = false;
  //   for (var item in cart) {
  //     if (item.product.id == product.id) {
  //       item.quantity++;
  //       found = true;
  //     }
  //     if (!found) {
  //       cart.add(ItemInCart(product: product, quantity: 1));
  //     }
  //   }
  // }

  cartRemove(Product product) {
    cart.removeWhere((item) => item.product.id == product.id);
  }

  cartClear() {
    cart.clear();
  }

  double cartTotal() {
    var total = 0.0;
    for (var item in cart) {
      total += item.quantity * item.product.price;
    }
    return total;
  }
}
