import 'package:flutter/material.dart';

class OffersPage extends StatelessWidget {
  const OffersPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    if (size.width > 500) {}
    return ListView(
      children: const [
        Offer(
            title: "My great offer of all the time!",
            description: " Buy 1, get 10 for free!"),
        Offer(
            title: "My great offer of all the time!",
            description: " Buy 1, get 10 for free!"),
      ],
    );
  }
}

class Offer extends StatelessWidget {
  final String title;
  final String description;
  const Offer({Key? key, required this.title, required this.description})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          color: Colors.amber.shade50,
          elevation: 7,
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("images/background.png"),
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Container(
                      color: Colors.amber.shade50,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          title,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color: Colors.amber.shade50,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        description,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
