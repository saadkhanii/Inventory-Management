import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inventory_managment/shoe.dart';
import 'package:inventory_managment/shoe_tile.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade200,
      body: Column(
        children: [
          // search bar
          Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.symmetric(horizontal: 25),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text('Search'), Icon(Icons.search)],
            ),
          ),

          // slogan
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 25.0),
            child: Text(
              'Everyone flies.. some fly longer than others',
              style: TextStyle(color: Colors.black54),
            ),
          ),

          // hot picks title
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Hot Picks 🔥',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text('see all'),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // Firebase shoe list
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('inventory').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final docs = snapshot.data!.docs;

                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    Shoe shoe = Shoe.fromMap(docs[index].data());
                    return ShoeTile(
                      shoe: shoe,
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Tapped! (Connect to cart logic if needed)'),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: Divider(color: Colors.blue.shade200),
          ),
        ],
      ),
    );
  }
}
