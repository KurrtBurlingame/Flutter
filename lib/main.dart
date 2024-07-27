import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  final appTitle = 'Hungry Hippo Inventory Management';

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      home: const LoginPage(), // Changed to LoginPage
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 137, 7, 211),
        colorScheme:
            ColorScheme.fromSwatch().copyWith(secondary: Colors.purple[800]),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.black54),
        ),
      ),
    );
  }
}

// New LoginPage class
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';

  void _submit() {
  if (_formKey.currentState!.validate()) {
    _formKey.currentState!.save();
    
    // Hardcoded username and password for demonstration
    String validUsername = 'hungryadmin@gmail.com';
    String validPassword = 'hungry';
    
    // Check if the entered username and password match the hardcoded values
    if (_username == validUsername && _password == validPassword) {
      // Navigate to the homepage
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => MyHomePage(title: 'Inventory Management'),
        ),
      );
    } else {
      // Show an error message or handle invalid credentials
      // For example, you can show a snackbar or set an error state
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid username or password'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/restaurant.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.5),
              BlendMode.darken,
            ),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple.withOpacity(0.5), Colors.transparent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
            child: Container(
              margin: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width *
                  0.8, // Adjust the width here
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  colors: [Colors.purple, Colors.blue],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Username',
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.8),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your username';
                          }
                          return null;
                        },
                        onSaved: (value) => _username = value!,
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Password',
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.8),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                        onSaved: (value) => _password = value!,
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        child: Text('Login'),
                        onPressed: _submit,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: MenuSearch());
            },
          ),
          IconButton(
            icon: const Icon(Icons.location_on),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: false,
                builder: (BuildContext context) {
                  return Container(
                    height: MediaQuery.of(context).size.height,
                    color: Colors.purple[800], // Background color for full page
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 20), // Add space at the top
                          Text(
                            'Hungry Hippo - SM City Batangas Branch',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 20),
                          Image.asset(
                            'assets/loc.png',
                            width: 5000, // Increase width
                            height: 250, // Increase height
                          ),
                          SizedBox(height: 20),
                          Image.asset(
                            'assets/sm.jpg',
                            width: 5000, // Increase width
                            height: 250, // Increase height
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () {},
          ),
          CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage('assets/admin.jpg'),
          ),
          SizedBox(
            width: 10,
          ) //Add some padding to the right
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple[800]!, Colors.purple[200]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Stack(
            children: [
              // Background Image
              Positioned.fill(
                child: Image.asset(
                  'assets/restaurant.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              // Gradient overlay to ensure text visibility
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.purple.withOpacity(0.8),
                        Colors.purple.withOpacity(0.2)
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
              // Content
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Welcome back Administrator!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Ensure text is readable
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildSalesContainer(
                      'Today\'s Sales:',
                      '2024-07-15',
                      'Php 500.00',
                      Colors.purple[50]!,
                    ),
                    const SizedBox(height: 20),
                    _buildSalesContainer(
                      'Total Sales:',
                      '(Overall)',
                      'Php 1000.00',
                      Colors.purple[100]!,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color.fromARGB(255, 147, 6, 207),
                    Colors.purple[100]!
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/logo.jpg', width: 50),
                        const SizedBox(width: 8.0),
                        const Text(
                          "HUNGRY HIPPO",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      "hungryhipposmbats@gmail.com",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            ..._drawerItems(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSalesContainer(
      String title, String date, String sales, Color color) {
    return Container(
      width: 1100,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(),
          Text(
            date,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              sales,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _drawerItems(BuildContext context) {
    return [
      _createDrawerItem(
        icon: Icons.home,
        text: 'Home',
        onTap: () => Navigator.pop(context),
      ),
      _createDrawerItem(
        icon: Icons.point_of_sale,
        text: 'Sales',
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SalesPage()),
        ),
      ),
      _createDrawerItem(
        icon: Icons.inventory,
        text: 'Inventory',
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => InventoryPage()),
        ),
      ),
      _createDrawerItem(
        icon: Icons.category,
        text: 'Product List',
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProductsPage()),
        ),
      ),
      _createDrawerItem(
        icon: Icons.list_alt,
        text: 'Supplier List',
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SupplierPage()),
        ),
      ),
      _createDrawerItem(
        icon: Icons.people,
        text: 'Customer List',
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CustomerPage()),
        ),
      ),
      _createDrawerItem(
        icon: Icons.logout,
        text: 'Log Out',
        onTap: () {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LoginPage()),
            (Route<dynamic> route) => false,
          );
        },
      ),
    ];
  }
}

Widget _createDrawerItem(
    {required IconData icon,
    required String text,
    required GestureTapCallback onTap}) {
  return Container(
    height: 80, // Adjust the height as needed
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.purple, Colors.purple],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    child: ListTile(
      contentPadding:
          EdgeInsets.symmetric(horizontal: 20.0), // Adjust padding as needed
      leading: Icon(icon, color: Colors.white),
      title: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
      onTap: onTap,
    ),
  );
}

class InventoryPage extends StatefulWidget {
  @override
  _InventoryPageState createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  final List<Map<String, String>> items = [
    {'item': 'Veggie Burger', 'quantity': '50', 'unitCost': 'P75'},
    {'item': 'Fillet Sandwich', 'quantity': '40', 'unitCost': 'P88'},
    {'item': 'Steak and Cheese', 'quantity': '35', 'unitCost': 'P125'},
    {'item': 'Hippo Fries', 'quantity': '25 packs', 'unitCost': 'P75'},
    {'item': 'Iced Coffee', 'quantity': '100', 'unitCost': 'P110'},
    {'item': 'Onion Rings', 'quantity': '15 packs', 'unitCost': 'P115'},
    {'item': 'Cheesy Nachos', 'quantity': '20 packs', 'unitCost': 'P65'},
    {'item': 'Chicken', 'quantity': '50', 'unitCost': 'P130'},
    {'item': 'Clubhouse', 'quantity': '35', 'unitCost': 'P85'},
    {'item': 'Fried Chicken', 'quantity': '20 packs', 'unitCost': 'P100'},
    {
      'item': 'Classic Double Cheeseburger',
      'quantity': '60',
      'unitCost': 'P99'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: MenuSearch());
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/restaurant.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.purple.withOpacity(0.7),
                  Colors.purple.withOpacity(0.3)
                ],
                begin: Alignment.topCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 253, 253)
                          .withOpacity(0.7),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                // Navigate to AddItemPage and wait for the result
                                final newItem = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddItemPage(),
                                  ),
                                );

                                // If a new item is returned, add it to the items list
                                if (newItem != null) {
                                  setState(() {
                                    items.add(newItem);
                                  });
                                }
                              },
                              child: const Text('+ Add Item'),
                            ),
                          ],
                        ),
                        Table(
                          border: TableBorder.all(),
                          children: [
                            TableRow(
                              children: [
                                _tableHeader('Item'),
                                _tableHeader('Quantity'),
                                _tableHeader('Unit Cost'),
                              ],
                            ),
                            ...items.map((item) {
                              return TableRow(
                                children: [
                                  _tableCell(item['item']!),
                                  _tableCell(item['quantity']!),
                                  _tableCell(item['unitCost']!),
                                ],
                              );
                            }).toList(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tableHeader(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Color.fromARGB(255, 27, 26, 26)),
      ),
    );
  }

  Widget _tableCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: const TextStyle(color: Color.fromARGB(255, 26, 25, 25)),
      ),
    );
  }
}

class AddItemPage extends StatefulWidget {
  @override
  _AddItemPageState createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  final _itemController = TextEditingController();
  final _quantityController = TextEditingController();
  final _unitCostController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Item'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6A0DAD), Color(0xFF8A2BE2)], // Purple gradient
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Item Information',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              _buildTextField(_itemController, 'Item Name'),
              SizedBox(height: 10),
              _buildTextField(_quantityController, 'Quantity'),
              SizedBox(height: 10),
              _buildTextField(_unitCostController, 'Unit Cost'),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Collect the input data
                      final newItem = {
                        'item': _itemController.text,
                        'quantity': _quantityController.text,
                        'unitCost': _unitCostController.text,
                      };

                      // Return the new item to the previous screen
                      Navigator.pop(context, newItem);
                    },
                    child: const Text('Save'),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Simply return to the previous screen without saving
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
  }
}

class ProductsPage extends StatelessWidget {
  final List<Map<String, dynamic>> products = [
    {
      'title': 'Classic Double Cheeseburger',
      'price': '₱100.00',
      'image': 'assets/yumbur.jpg',
      'availability': 'Availability Servings: 5',
    },
    {
      'title': 'Veggie Burger',
      'price': '₱120.00',
      'image': 'assets/classic.jpg',
      'availability': 'Availability Servings: 3',
    },
    {
      'title': 'Clubhouse',
      'price': '₱80.00',
      'image': 'assets/clubhouse.jpg',
      'availability': 'Availability Servings: 30',
    },
    {
      'title': 'Hippo Fries',
      'price': '₱88.00',
      'image': 'assets/hippo_fries.jpg',
      'availability': 'Availability Servings: 20',
    },
    {
      'title': 'Fried Chicken',
      'price': '₱125.00',
      'image': 'assets/chicken.jpg',
      'availability': 'Availability Servings: 15',
    },
    {
      'title': 'Onion Rings',
      'price': '₱75.00',
      'image': 'assets/onion_rings.jpg',
      'availability': 'Availability Servings: 6',
    },
    {
      'title': 'Cheesy Nachos',
      'price': '₱99.00',
      'image': 'assets/nachos.jpg',
      'availability': 'Availability Servings: 8',
    },
    {
      'title': 'Chuncky Sandwich',
      'price': '₱99.00',
      'image': 'assets/ccsand.jpg',
      'availability': 'Availability Servings: 10',
    },
{
      'title': 'Classic Double Cheeseburger',
      'price': '₱100.00',
      'image': 'assets/yumbur.jpg',
      'availability': 'Availability Servings: 5',
    },
    {
      'title': 'Veggie Burger',
      'price': '₱120.00',
      'image': 'assets/classic.jpg',
      'availability': 'Availability Servings: 3',
    },
    {
      'title': 'Clubhouse',
      'price': '₱80.00',
      'image': 'assets/clubhouse.jpg',
      'availability': 'Availability Servings: 30',
    },
    {
      'title': 'Hippo Fries',
      'price': '₱88.00',
      'image': 'assets/hippo_fries.jpg',
      'availability': 'Availability Servings: 20',
    },
    {
      'title': 'Fried Chicken',
      'price': '₱125.00',
      'image': 'assets/chicken.jpg',
      'availability': 'Availability Servings: 15',
    },
    {
      'title': 'Onion Rings',
      'price': '₱75.00',
      'image': 'assets/onion_rings.jpg',
      'availability': 'Availability Servings: 6',
    },
    {
      'title': 'Cheesy Nachos',
      'price': '₱99.00',
      'image': 'assets/nachos.jpg',
      'availability': 'Availability Servings: 8',
    },
    {
      'title': 'Chuncky Sandwich',
      'price': '₱99.00',
      'image': 'assets/ccsand.jpg',
      'availability': 'Availability Servings: 10',
    },
  ];


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    // Determine the number of columns based on screen width
    int crossAxisCount = screenWidth < 600
        ? 2
        : screenWidth < 900
            ? 3
            : 4;

    return Scaffold(
      appBar: AppBar(
        title: const Text('View Products'),
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: MenuSearch());
            },
          ),
          IconButton(
            icon: const Icon(Icons.location_on),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/background_image.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Gradient overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.purple[800]!.withOpacity(0.5),
                    Colors.purple[200]!.withOpacity(0.5)
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          // Product grid
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: screenWidth < 600
                    ? 1
                    : 3 / 2, // Adjust aspect ratio based on screen width
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Image.asset(
                              products[index]['image']!,
                              height: screenWidth < 600
                                  ? 80.0
                                  : 180.0, // Adjust image height based on screen width
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                products[index]['title']!,
                                style: TextStyle(
                                  fontSize: screenWidth < 600 ? 14 : 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                products[index]['price']!,
                                style: TextStyle(
                                  fontSize: screenWidth < 600 ? 12 : 14,
                                  color: Colors.black54,
                                ),
                              ),
                              const SizedBox(height: 4.0),
                              Text(
                                products[index]['availability'],
                                style: TextStyle(
                                  fontSize: screenWidth < 600 ? 10 : 12,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SalesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sales'),
      ),
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/restaurant.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Gradient overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.purple.withOpacity(0.7),
                  Colors.purple.withOpacity(0.7)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Welcome back Janaica Roblo!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                _buildSalesContainer(
                  'Today\'s Sales:',
                  '2024-07-15',
                  'Php 500.00',
                  Colors.purple[300]!.withOpacity(0.8),
                ),
                const SizedBox(height: 10), // Reduced height
                _buildSalesContainer(
                  'Total Sales:',
                  '(Overall)',
                  'Php 1000.00',
                  Colors.purple[500]!.withOpacity(0.8),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSalesContainer(
      String title, String date, String sales, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(
          vertical: 8.0, horizontal: 16.0), // Adjusted padding
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const Divider(color: Colors.white),
          Text(
            date,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              sales,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SupplierPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Supplier List'),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/restaurant.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.purple.withOpacity(0.8),
                  Colors.purple.withOpacity(0.4)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dashboard',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.06,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        int crossAxisCount =
                            (constraints.maxWidth ~/ 150).clamp(1, 4);
                        return GridView.count(
                          crossAxisCount: crossAxisCount,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          children: [
                            _dashboardItem(
                              context,
                              '1 Administrator/s',
                              'Active',
                              Icons.admin_panel_settings,
                              () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AdminInfoPage()),
                              ),
                            ),
                            _dashboardItem(
                              context,
                              '1 Worker',
                              'Active',
                              Icons.person,
                              () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: Text('Worker Information'),
                                    content: Container(
                                      color: Colors.blue.shade50,
                                      child: Card(
                                        color: Colors.blue.shade100,
                                        elevation: 4,
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text('Name: Kurt',
                                                  style:
                                                      TextStyle(fontSize: 16)),
                                              Text('Position: Cashier',
                                                  style:
                                                      TextStyle(fontSize: 16)),
                                              Text(
                                                  'LogIn/Time: 8:00 AM - 07/20/24',
                                                  style:
                                                      TextStyle(fontSize: 16)),
                                              Text(
                                                  'LogOut/Time: 9:00 PM - 07/20/2024',
                                                  style:
                                                      TextStyle(fontSize: 16)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: Text('Close'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            _dashboardItem(
                              context,
                              '1 Supplier',
                              'Available',
                              Icons.delivery_dining,
                              () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: Text('Supplier Information'),
                                    content: Container(
                                      color: Colors.green.shade50,
                                      child: Card(
                                        color: Colors.green.shade100,
                                        elevation: 4,
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  'Supplier Name: Fresh Produce Co.',
                                                  style:
                                                      TextStyle(fontSize: 16)),
                                              Text(
                                                  'Company Name: Prime Cuts Inc',
                                                  style:
                                                      TextStyle(fontSize: 16)),
                                              Text(
                                                  'Position: Sales Representative',
                                                  style:
                                                      TextStyle(fontSize: 16)),
                                              Text(
                                                  'Product Type: Fresh vegetables and Meats',
                                                  style:
                                                      TextStyle(fontSize: 16)),
                                              Text(
                                                  'Delivery Time: Daily, early morning deliveries',
                                                  style:
                                                      TextStyle(fontSize: 16)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: Text('Close'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            _dashboardItem(
                              context,
                              '2 Items',
                              'Total',
                              Icons.inventory,
                              () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: Text('Items Information'),
                                    content: Container(
                                      color: Colors.orange.shade50,
                                      child: Card(
                                        color: Colors.orange.shade100,
                                        elevation: 4,
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text('Fresh vegetables:',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Text(
                                                    'Lettuce: 100 heads per week',
                                                    style: TextStyle(
                                                        fontSize: 16)),
                                                Text(
                                                    'Tomatoes: 200 lbs per week',
                                                    style: TextStyle(
                                                        fontSize: 16)),
                                                Text(
                                                    'Cucumbers: 50 lbs per week',
                                                    style: TextStyle(
                                                        fontSize: 16)),
                                                SizedBox(height: 10),
                                                Text('Beef Patties:',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Text(
                                                    'Regular beef patties (4 oz): 500 patties per week',
                                                    style: TextStyle(
                                                        fontSize: 16)),
                                                Text(
                                                    'Angus beef patties (6 oz): 300 patties per week',
                                                    style: TextStyle(
                                                        fontSize: 16)),
                                                SizedBox(height: 10),
                                                Text('Chicken Products:',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Text(
                                                    'Chicken fillets (5 oz): 400 fillets per week',
                                                    style: TextStyle(
                                                        fontSize: 16)),
                                                Text(
                                                    'Breaded chicken patties: 200 patties per week',
                                                    style: TextStyle(
                                                        fontSize: 16)),
                                                SizedBox(height: 10),
                                                Text('Buns:',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Text(
                                                    'Burger buns: 100 dozen (1200 buns) per week',
                                                    style: TextStyle(
                                                        fontSize: 16)),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: Text('Close'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dashboardItem(BuildContext context, String title, String subtitle,
      IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: MediaQuery.of(context).size.width * 0.08,
              child: Icon(icon, size: MediaQuery.of(context).size.width * 0.1),
            ),
            const SizedBox(height: 8.0),
            Flexible(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.035,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Flexible(
              child: Text(
                subtitle,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.03,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AdminInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Administrator Information'),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/restaurant.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple, Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
          ),
          Center(
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.purple.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage(
                          'assets/admin.jpg'), // Ensure this path is correct
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Name: Janaica Mher Roblo',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Position: Manager',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    const Text(
                      'LogIn Time/Date: 7:00 AM - 07/20/24',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    const Text(
                      'LogOut Time: 5:00 PM - 07/20/2024',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomerPage extends StatelessWidget {
  final List<Map<String, String>> customers = [
    {'name': 'Janaica Roblo'},
    {'name': 'Kurt Burlingame'},
    {'name': 'Callie Callie'},
    {'name': 'Brian Emman'},
    {'name': 'Bryle Ethan'},
    {'name': 'Nancy Binay'},
    {'name': 'Cristine Rose Macatangay'},
    {'name': 'Annuary Mae'},
    {'name': 'Annalyn Casandra'},
    {'name': 'Lincelyn Mendrano'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer List'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: MenuSearch());
            },
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/restaurant.jpg'), // Ensure this path is correct
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Gradient Overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purple.withOpacity(0.6), Colors.transparent],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
          // Centered Content
          Center(
            child: Container(
              width: 600, // Adjust width as needed
              child: ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: customers.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 123, 17, 215),
                        child: const Icon(Icons.person, color: Colors.white),
                      ),
                      title: Text(customers[index]['name']!),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CustomerReceiptPage(
                              name: customers[index]['name']!,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomerReceiptPage extends StatelessWidget {
  final String name;

  CustomerReceiptPage({required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Receipt'),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image with gradient overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/restaurant.jpg'), // Path to your background image
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.5), Colors.transparent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          // Receipt content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Receipt',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Customer: $name'),
                        const Text('Date: 2024-04-20'),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    const Text('Reference Number: 67561742'),
                    const SizedBox(height: 16.0),
                    Table(
                      border: TableBorder.all(),
                      columnWidths: {
                        0: FractionColumnWidth(0.1),
                        1: FractionColumnWidth(0.6),
                        2: FractionColumnWidth(0.15),
                        3: FractionColumnWidth(0.15),
                      },
                      children: [
                        TableRow(
                          children: [
                            _buildTableCell('Qty', isHeader: true),
                            _buildTableCell('Product', isHeader: true),
                            _buildTableCell('Unit Price', isHeader: true),
                            _buildTableCell('Amount', isHeader: true),
                          ],
                        ),
                        TableRow(
                          children: [
                            _buildTableCell('3'),
                            _buildTableCell('Fillet Sandwich'),
                            _buildTableCell('80.00'),
                            _buildTableCell('240.00'),
                          ],
                        ),
                        TableRow(
                          children: [
                            _buildTableCell('5'),
                            _buildTableCell('Onion Rings'),
                            _buildTableCell('75.00'),
                            _buildTableCell('375.00'),
                          ],
                        ),
                        TableRow(
                          children: [
                            _buildTableCell('2'),
                            _buildTableCell('Classic Burger'),
                            _buildTableCell('100.00'),
                            _buildTableCell('200.00'),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    const Text('Total: 815'),
                    const SizedBox(height: 4.0),
                    const Text('Amount Tendered: 1000'),
                    const SizedBox(height: 4.0),
                    const Text('Change: 185'),
                    const Spacer(),
                    const Text(
                      'This is not an official receipt.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text('Print'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableCell(String text, {bool isHeader = false}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class MenuSearch extends SearchDelegate<String> {
  final List<String> menuItems = [
    'Classic Double Cheeseburger',
    'Fried Chicken',
    'Clubhouse',
    'Onion Rings',
    'Hippo Fries',
  ];

  final Map<String, String> itemDetails = {
    'Classic Double Cheeseburger': 'Buns: Sesame seed hamburger buns\n'
        'Meat Patties: Two beef patties (usually 4 oz each)\n'
        'Cheese: Slices of American cheese (or other preferred cheese)',
    'Fried Chicken': 'Details for Fried Chicken (if available)',
    'Clubhouse': 'Details for Clubhouse (if available)',
    'Onion Rings': 'Onions: 2 large onions\n'
        'Flour: 1 cup all-purpose flour\n'
        'Baking Powder: 1 teaspoon baking powder\n'
        'Salt: 1 teaspoon salt\n'
        'Egg: 1 egg\n',
    'Hippo Fries': 'Details for Hippo Fries (if available)',
  };

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.of(context).pop(); // Close the search screen
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final result = menuItems.firstWhere(
      (item) => item.toLowerCase() == query.toLowerCase(),
      orElse: () => '',
    );

    if (result.isNotEmpty) {
      return Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/restaurant.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: SizedBox(
              width: 500, // Adjust the width as needed
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    itemDetails[result] ?? 'Details not available',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }

    return Center(
      child: Text(
        'No item found.',
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? []
        : menuItems
            .where((item) => item.toLowerCase().contains(query.toLowerCase()))
            .toList();

    if (query.isEmpty) {
      return Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.purple],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                width: 300, // Adjust the width to make the container longer
                child: TextField(
                  autofocus: true,
                  onChanged: (value) {
                    query = value;
                    showSuggestions(context);
                  },
                  decoration: InputDecoration(
                    hintText: 'Start typing to search...',
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      );
    }

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/restaurant.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        ListView.builder(
          itemCount: suggestionList.length,
          itemBuilder: (context, index) {
            final suggestion = suggestionList[index];
            return ListTile(
              title: Text(
                suggestion,
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                query = suggestion;
                showResults(context);
              },
            );
          },
        ),
      ],
    );
  }
}


