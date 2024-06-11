import 'package:flutter/material.dart';
import 'package:mobile/add_product.dart';
import 'main.dart';
import 'admin_login.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Product> products = [
    Product(
      title: "For present",
      category: "Teddy",
      price: 10,
      image: "https://m.media-amazon.com/images/I/71vdTBiBEEL.jpg",
    ),
    Product(
      title: "For present",
      category: "Teddy",
      price: 10,
      image:
          "https://i.etsystatic.com/37300092/r/il/383ff1/4759312785/il_fullxfull.4759312785_p63a.jpg",
    ),
    Product(
      title: "For kids",
      category: "Cars",
      price: 7,
      image:
          "https://hips.hearstapps.com/vader-prod.s3.amazonaws.com/1663697000-41KwiXdrl3S._SL500_.jpg?crop=1xw:1.00xh;center,top&resize=980:*",
    ),
    Product(
      title: "For kids",
      category: "Cars",
      price: 7,
      image:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZJ1zSKh6MNHEiGtsCrQ8PiPRa8VFLB6aiC1pG1UNJ-yUwcRG_QtO2JjAOZG9Y3_zCSpg&usqp=CAU",
    ),
    Product(
      title: "For kids",
      category: "Barbie",
      price: 5,
      image:
          "https://www.billboard.com/wp-content/uploads/2023/11/barbie-pink-jumpsuit.webp?w=1024",
    ),
    Product(
      title: "For kids",
      category: "Barbie",
      price: 5,
      image:
          "https://i5.walmartimages.com/seo/Barbie-Extra-Fancy-Doll-with-Extra-Long-Blond-Hair-Blue-Eyes-in-Pink-Glossy-Gown-with-Accessories_e4ee3b61-5cb4-458f-9c14-975746a45696.630d06346940c82be326559f63a69697.jpeg",
    ),
    Product(
      title: "For kids",
      category: "Balls",
      price: 3,
      image:
          "https://target.scene7.com/is/image/Target/GUEST_09ed0e6e-55d0-4e79-a52d-d8a6422e21e9?wid=488&hei=488&fmt=pjpeg",
    ),
    Product(
      title: "For kids",
      category: "Balls",
      price: 3,
      image:
          "https://i5.walmartimages.com/seo/Soft-Plastic-Kids-Play-Balls-for-Ball-Pit-Kiddie-Pool-Playpen-50-Balls_15a6e8c7-3830-4af3-bb95-3b43c957935c_1.fedbcc236d4edab74aa011366370dc09.jpeg",
    ),
  ];

  List<String> categories = ['All', 'Teddy', 'Cars', 'Barbie', 'Balls'];
  String selectedCategory = 'All';
  bool isSearchExpanded = false;
  TextEditingController searchController = TextEditingController();
  bool isAdminLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[100],
        title: Row(
          children: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                setState(() {
                  isSearchExpanded = !isSearchExpanded;
                });
              },
            ),
            if (!isSearchExpanded)
              Expanded(
                child: Center(
                  child: const Text('Home Page'),
                ),
              ),
            if (isSearchExpanded)
              Expanded(
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Search',
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    setState(() {
                      products = products
                          .where((product) => product.title
                              .toLowerCase()
                              .contains(value.toLowerCase()))
                          .toList();
                    });
                  },
                ),
              ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      products.sort((a, b) => a.price.compareTo(b.price));
                    });
                  },
                  child: const Text('Sort by Price'),
                ),
                const SizedBox(width: 10),
                DropdownButton<String>(
                  value: selectedCategory,
                  items: categories.map((String category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value!;
                      if (selectedCategory == 'All') {
                        // Reset the product list to the original list
                        products = [
                          Product(
                            title: "For present",
                            category: "Teddy",
                            price: 10,
                            image:
                                "https://m.media-amazon.com/images/I/71vdTBiBEEL.jpg",
                          ),
                          Product(
                            title: "For kids",
                            category: "Cars",
                            price: 7,
                            image:
                                "https://hips.hearstapps.com/vader-prod.s3.amazonaws.com/1663697000-41KwiXdrl3S._SL500_.jpg?crop=1xw:1.00xh;center,top&resize=980:*",
                          ),
                          Product(
                            title: "For kids",
                            category: "Barbie",
                            price: 5,
                            image:
                                "https://www.billboard.com/wp-content/uploads/2023/11/barbie-pink-jumpsuit.webp?w=1024",
                          ),
                          Product(
                            title: "For kids",
                            category: "Balls",
                            price: 3,
                            image:
                                "https://target.scene7.com/is/image/Target/GUEST_09ed0e6e-55d0-4e79-a52d-d8a6422e21e9?wid=488&hei=488&fmt=pjpeg",
                          ),
                        ];
                      } else {
                        products = products
                            .where((product) =>
                                product.category == selectedCategory)
                            .toList();
                      }
                    });
                  },
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () async {
                    if (isAdminLoggedIn) {
                      final newProduct = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddNewProductPage()),
                      );
                      if (newProduct != null && newProduct is Product) {
                        setState(() {
                          products.add(newProduct);
                        });
                      }
                    } else {
                      final newProduct = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AdminLoginPage()),
                      );
                      if (newProduct != null && newProduct is Product) {
                        setState(() {
                          products.add(newProduct);
                          isAdminLoggedIn = true;
                        });
                      }
                    }
                  },
                  child: const Text('Add Product'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 6,
                  mainAxisSpacing: 5,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  if (selectedCategory == 'All' ||
                      products[index].category == selectedCategory) {
                    return Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                              child: Image.network(
                                products[index].image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  products[index].title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  '${products[index].category} - \$${products[index].price}',
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
