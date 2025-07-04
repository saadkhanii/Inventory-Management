import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddItemPage extends StatefulWidget {
  const AddItemPage({super.key});

  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  final _formKey = GlobalKey<FormState>();

  String name = '';
  String category = '';
  String quantity = '';
  String price = '';
  String imagePath = 'images/sho_1.png'; // You can allow user to select

  void addItemToFirestore() async {
    if (_formKey.currentState!.validate()) {
      await FirebaseFirestore.instance.collection('inventory').add({
        'name': name,
        'category': category,
        'quantity': int.parse(quantity),
        'price': price,
        'imagePath': imagePath,
        'discription': 'No description added.',
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Item added successfully!')),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade200,
        title: const Text('Add New Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Item Name'),
                onChanged: (val) => name = val,
                validator: (val) =>
                val == null || val.isEmpty ? 'Enter name' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Category'),
                onChanged: (val) => category = val,
                validator: (val) =>
                val == null || val.isEmpty ? 'Enter category' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
                onChanged: (val) => quantity = val,
                validator: (val) => int.tryParse(val!) == null || int.parse(val) < 0
                    ? 'Enter valid quantity'
                    : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                onChanged: (val) => price = val,
                validator: (val) => double.tryParse(val!) == null || double.parse(val) < 0
                    ? 'Enter valid price'
                    : null,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: addItemToFirestore,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                child: const Text('Add Item'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
