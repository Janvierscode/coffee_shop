import 'package:flutter/material.dart';

import 'data_manager.dart';
import 'pages/menu_page.dart';
import 'pages/offers_page.dart';
import 'pages/order_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'I.J Coffee Masters',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var dataManager = DataManager();
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget currentWidgetPage = const Text("!!!!");
    switch (selectedIndex) {
      case 0:
        {
          currentWidgetPage = MenuPage(
            dataManager: dataManager,
          );
        }

        break;
      case 1:
        {
          currentWidgetPage = const OffersPage();
        }
        break;
      case 2:
        {
          currentWidgetPage = OrderPage(
            dataManager: dataManager,
          );
        }
        break;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: Image.asset("images/logo.png"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (newIndex) {
          setState(() {
            selectedIndex = newIndex;
          });
        },
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Colors.yellow.shade400,
        unselectedItemColor: Colors.brown.shade50,
        items: const [
          BottomNavigationBarItem(
              label: "Menu", icon: Icon(Icons.coffee_rounded)),
          BottomNavigationBarItem(
              label: "Offers", icon: Icon(Icons.local_offer_outlined)),
          BottomNavigationBarItem(
              label: "Order",
              icon: Icon(Icons.shopping_cart_checkout_outlined)),
        ],
      ),
      body: currentWidgetPage,
    );
  }
}
