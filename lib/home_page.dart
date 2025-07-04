import 'package:flutter/material.dart';
import 'shoe_page.dart';
import 'bottom_nav_bar.dart';
import 'add_item_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    const ShopPage(),
    const AddItemPage(), // Replaces Cart Page
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade200,
      bottomNavigationBar: MyBottomNavBar(
        onTabChange: navigateBottomBar,
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: const Icon(Icons.menu),
            color: Colors.black,
          ),
        ),
      ),
      drawer: Drawer(
        elevation: 0,
        backgroundColor: Colors.blue.shade300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                DrawerHeader(
                  margin: EdgeInsets.zero,
                  child: Image.asset(
                    'images/nike.png',
                    height: 200,
                    width: 200,
                  ),
                ),
                const ListTile(
                  leading: Icon(Icons.home, color: Colors.black),
                  title: Text('Home'),
                ),
                const ListTile(
                  leading: Icon(Icons.info, color: Colors.black),
                  title: Text('About'),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(left: 25.0, bottom: 25),
              child: ListTile(
                leading: Icon(Icons.logout, color: Colors.black),
                title: Text('Log Out'),
              ),
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
    );
  }
}
