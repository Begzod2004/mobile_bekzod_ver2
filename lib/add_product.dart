import 'package:flutter/material.dart';
import 'main.dart';

class AddNewProductPage extends StatefulWidget {
  @override
  _AddNewProductPageState createState() => _AddNewProductPageState();
}

class _AddNewProductPageState extends State<AddNewProductPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController imageLinkController = TextEditingController();
  String? selectedCategory;

  final List<String> categories = [
    'Teddy',
    'Barbie',
    'Cars',
    'Balls',
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add New Product'),
          backgroundColor: Colors.blue[100],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextField(
                controller: titleController,
                labelText: 'Title',
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 15),
              _buildTextField(
                controller: priceController,
                labelText: 'Price',
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 15),
              _buildTextField(
                controller: imageLinkController,
                labelText: 'Image Link',
                keyboardType: TextInputType.url,
              ),
              SizedBox(height: 15),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value;
                  });
                },
                items: categories.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: () {
                  if (titleController.text.isNotEmpty &&
                      priceController.text.isNotEmpty &&
                      imageLinkController.text.isNotEmpty &&
                      selectedCategory != null) {
                    final newProduct = Product(
                      title: titleController.text,
                      category: selectedCategory!,
                      price: double.parse(priceController.text),
                      image: imageLinkController.text,
                    );
                    Navigator.pop(context, newProduct);
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  textStyle: TextStyle(fontSize: 18),
                  backgroundColor: Colors.blue[100],
                ),
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required TextInputType keyboardType,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
      ),
      keyboardType: keyboardType,
    );
  }
}
