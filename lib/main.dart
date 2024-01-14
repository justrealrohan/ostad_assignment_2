import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _item1Quantity = 1;
  int _item2Quantity = 1;
  int _item3Quantity = 1;

  String _getItemName(int itemNumber) {
    switch (itemNumber) {
      case 1:
        return 'Pullover';
      case 2:
        return 'T-Shirt';
      case 3:
        return 'Sports Dress';
      default:
        return 'Unknown';
    }
  }

  void _incrementQuantity(int item) {
    setState(() {
      int maxQuantity = 5;

      switch (item) {
        case 1:
          if (_item1Quantity < maxQuantity) {
            _item1Quantity++;
          }
          break;
        case 2:
          if (_item2Quantity < maxQuantity) {
            _item2Quantity++;
          }
          break;
        case 3:
          if (_item3Quantity < maxQuantity) {
            _item3Quantity++;
          }
          break;
      }

      if (_item1Quantity == maxQuantity ||
          _item2Quantity == maxQuantity ||
          _item3Quantity == maxQuantity) {
        String itemName = _getItemName(item);

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              title: const Center(child: const Text('Congratulations!')),
              content: SizedBox(
                height: 100,
                child: Column(children: [
                  const Text('You have added',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                  const Text('5', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                  Text(
                    '$itemName on your bag!',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ]),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white, minimumSize: Size(40, 20),
                    backgroundColor: Colors.red,
                  ),
                  child: const Center(child: Text('OK')),
                ),
              ],
            );
          },
        );
      }
    });
  }

  void _decrementQuantity(int item) {
    setState(() {
      switch (item) {
        case 1:
          if (_item1Quantity > 0) {
            _item1Quantity--;
          }
          break;
        case 2:
          if (_item2Quantity > 0) {
            _item2Quantity--;
          }
          break;
        case 3:
          if (_item3Quantity > 0) {
            _item3Quantity--;
          }
          break;
      }
    });
  }

  void _showCheckoutSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Congratulations! Your order has been placed.'),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Widget _buildItem(
      int itemNumber,
      String imagePath,
      String itemName,
      String color,
      String size,
      int price,
      ) {
    int currentQuantity;

    switch (itemNumber) {
      case 1:
        currentQuantity = _item1Quantity;
        break;
      case 2:
        currentQuantity = _item2Quantity;
        break;
      case 3:
        currentQuantity = _item3Quantity;
        break;
      default:
        currentQuantity = 1;
    }

    String displayName;
    int itemPrice;

    switch (itemNumber) {
      case 1:
        displayName = 'Pullover';
        itemPrice = 51;
        break;
      case 2:
        displayName = 'T-Shirt';
        itemPrice = 30;
        break;
      case 3:
        displayName = 'Sports Dress';
        itemPrice = 43;
        break;
      default:
        displayName = 'Unknown';
        itemPrice = 0;
    }

    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        children: [
          Image(
            image: Image.asset(imagePath).image,
            height: screenWidth * 0.3,
            width: screenWidth * 0.3,
            fit: BoxFit.fill,
          ),
          Container(
            height: screenWidth * 0.3,
            width: screenWidth * 0.6,
            color: Colors.white70,
            child: Padding(
              padding: const EdgeInsets.only(top: 10, left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        displayName,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Icon(Icons.menu),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Color: '),
                      Text(
                        color,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text('Size: '),
                      Text(
                        size,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              _decrementQuantity(itemNumber);
                            },
                            icon: const Icon(Icons.remove),
                            style: IconButton.styleFrom(
                              elevation: 10,
                              shadowColor: Colors.black,
                              backgroundColor: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              currentQuantity.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              _incrementQuantity(itemNumber);
                            },
                            icon: const Icon(Icons.add),
                            style: IconButton.styleFrom(
                              elevation: 10,
                              shadowColor: Colors.black,
                              backgroundColor: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: screenWidth * 0.172),
                            child: Text(
                              (itemPrice * currentQuantity).toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.attach_money,
                            size: 16,
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(actions: const [Icon(Icons.search)]),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(
              'My Bag',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
            ),
          ),
          _buildItem(1, 'images/image.png', 'Pullover', 'Black', 'L', 51),
          _buildItem(2, 'images/image1.png', 'T-Shirt', 'Gray', 'L', 30),
          _buildItem(3, 'images/image2.png', 'Sports Dress', 'Black', 'M', 43),
          Padding(
            padding: EdgeInsets.only(
                top: screenWidth * 0.4, bottom: screenWidth * 0.02),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Amount: ',
                        style: TextStyle(
                          fontSize: screenWidth * 0.042,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            (_item1Quantity * 51 +
                                _item2Quantity * 30 +
                                _item3Quantity * 43)
                                .toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: screenWidth * 0.05,
                            ),
                          ),
                          const Icon(
                            Icons.attach_money,
                            size: 20,
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  _showCheckoutSnackbar();
                },
                style: ElevatedButton.styleFrom(
                  elevation: 10,
                  alignment: Alignment.center,
                  minimumSize: Size(screenWidth * 0.7, screenWidth * 0.1),
                  textStyle: const TextStyle(fontSize: 16),
                  foregroundColor: Colors.white,
                  shadowColor: Colors.black,
                  backgroundColor: Colors.red,
                ),
                child: const Text('CHECK OUT'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
