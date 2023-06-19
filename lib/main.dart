import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const ProductList(),
    );
  }
}

class Product {
  final String name;
  final double price;
  int counter;

  Product({required this.name, required this.price, this.counter = 0});
}

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<Product> products = [
    Product(name: 'Product 1', price: 10.0),
    Product(name: 'Product 2', price: 20.0),
    Product(name: 'Product 3', price: 30.0),
    Product(name: 'Product 4', price: 40.0),
    Product(name: 'Product 5', price: 50.0),
    Product(name: 'Product 6', price: 60.0),
    Product(name: 'Product 7', price: 70.0),
    Product(name: 'Product 8', price: 80.0),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          Product product = products[index];
          return ListTile(
            title: Text(product.name),
            subtitle: Text('\$${product.price.toStringAsFixed(3)}'),
            trailing: Column(
              children: [
                Text('Counter: ${product.counter.toString()}'),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      product.counter++;
                      if (product.counter == 5) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Congratulations!'),
                            content: Text('You\'ve bought 5 ${product.name}!'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }
                    });
                  },
                  child: const Text('Buy Now'),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CartPage(products: products),
            ),
          );
        },
         //child: const Icon(Icons.shopping_cart),
        label: const Text('Go to the Cart'),
      ),
    );
  }
}

class CartPage extends StatelessWidget {
  final List<Product> products;

  const CartPage({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int totalBoughtProducts = products.fold(
      0,
      (previousValue, product) => previousValue + product.counter,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('Total Bought Products: $totalBoughtProducts'),
      ),
    );
  }
}
