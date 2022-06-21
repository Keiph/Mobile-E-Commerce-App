import 'package:boogle_mobile/providers/product_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AddProductScreen extends StatefulWidget {
  static String routeName = '/add-product';

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  var form = GlobalKey<FormState>();

  String? productName,
      productImg,
      productCategory,
      productSizes,
      productDetails;
  Color? productColors;
  double? productPrice;
  int productCount = 1;
  double productRating = 5.0;

  void saveForm(ProductList productList) {
    bool isValid = form.currentState!.validate();
    if (isValid) {
      form.currentState!.save();
      print(productName);
      print(productImg);
      print(productSizes);
      print(productCategory);
      print(productColors);
      print(productCount);
      print(productRating);
      print(productDetails);

      productList.addProduct(productName, productImg, productDetails, productColors, productCategory, productPrice, productSizes, productRating, productCount);

      FocusScope.of(context).unfocus();

      form.currentState!.reset();

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Product added successfully!'),));
    }
  }

  @override
  Widget build(BuildContext context) {
    ProductList productList = Provider.of<ProductList>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed:() {saveForm(productList);},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Form(
            key: form,
            child: Column(
              children: [
                TextFormField(
                  decoration:
                      InputDecoration(label: Text('Enter Product Name')),
                  validator: (value) {
                    if (value!.isEmpty)
                      return 'Please provide the name of the product.';
                    else if ( value.length<3 ||value.length > 24)
                      return 'Please provide name of product in the range 3-24';
                    else
                      return null;
                  },
                  onSaved: (value) {
                    productName = value;
                  },
                ),
                SizedBox(height: 20,),
                TextFormField(
                  decoration:
                      InputDecoration(label: Text('Enter URL of Image')),
                  validator: (value) {
                    var urlPattern = r"(https?|http)://";
                    RegExp regEx = new RegExp(urlPattern);

                    if (value!.isEmpty)
                      return 'Please provide the URL of the image.';
                    else if (!Uri.parse(value).isAbsolute)
                      if (!regEx.hasMatch(value))
                      // Must match regex, if user type :/ it will have an exception . This is to prevent that
                      return 'Please don\'t try to crash my system add in http or https:// ';
                    else
                      return 'Please provide a valid URL';
                    else
                      return null;
                  },
                  onSaved: (value) {
                    productImg = value;
                  },
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration:
                            InputDecoration(label: Text('Enter Product Size')),
                        validator: (value) {
                          if (value!.isEmpty)
                            return 'Please provide the size of the product';
                          else if (value.length > 18)
                            return 'Please provide a valid product size. keep it less than 19 words';
                          else
                            return null;
                        },
                        onSaved: (value) {
                          productSizes = value;
                        },
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          label: Text('Enter Price'),
                          hintText: '\$2.50'
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty)
                            return 'Please provide a price';
                          else if (double.tryParse(value) == null)
                            return 'Invalid price format';
                          else
                            return null;
                        },
                        onSaved: (value) {
                          productPrice = double.parse(value!);
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20,),

                DropdownButtonFormField(
                  decoration: InputDecoration(
                    label: Text('Select One Product Category'),
                  ),
                  items: [
                    DropdownMenuItem(child: Text('Clothes'), value: 'clothes'),
                    DropdownMenuItem(child: Text('Pants'), value: 'pants'),
                    DropdownMenuItem(child: Text('Shoes'), value: 'shoes'),
                    DropdownMenuItem(child: Text('Computer & Games'), value: 'computer&games'),
                    DropdownMenuItem(child: Text('Grocery'), value: 'grocery'),
                    DropdownMenuItem(child: Text('Pet Supplies'), value: 'petSupplies'),
                    DropdownMenuItem(child: Text('Miscellaneous'), value: 'misc'),
                  ],
                  validator: (value) {
                    if (value == null)
                      return "Please provide the category of the product";
                    else
                      return null;
                  },
                  onChanged: (value) {productCategory = value as String;},
                ),
                SizedBox(height: 20,),

                DropdownButtonFormField(
                  decoration: InputDecoration(
                    label: Text('Select One Product Color'),
                  ),
                  items: [
                    DropdownMenuItem(
                        child: Row(
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(width: 0.5),
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 10.0,),
                            Text('White'),
                          ],
                        ),
                        value: Colors.white
                    ),
                    DropdownMenuItem(
                        child: Row(
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                border: Border.all(width: 0.5),
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 10.0,),
                            Text('Black'),
                          ],
                        ),
                        value: Colors.black
                    ),
                    DropdownMenuItem(
                        child: Row(
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                border: Border.all(width: 0.5),
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 10.0,),
                            Text('Grey'),
                          ],
                        ),
                        value: Colors.grey
                    ),
                    DropdownMenuItem(
                        child: Row(
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: Colors.yellow,
                                border: Border.all(width: 0.5),
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 10.0,),
                            Text('Yellow'),
                          ],
                        ),
                        value: Colors.yellow
                    ),
                    DropdownMenuItem(
                        child: Row(
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                border: Border.all(width: 0.5),
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 10.0,),
                            Text('Green'),
                          ],
                        ),
                        value: Colors.green
                    ),
                    DropdownMenuItem(
                        child: Row(
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                border: Border.all(width: 0.5),
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 10.0,),
                            Text('Blue'),
                          ],
                        ),
                        value: Colors.blue
                    ),
                    DropdownMenuItem(
                        child: Row(
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: Colors.purple,
                                border: Border.all(width: 0.5),
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 10.0,),
                            Text('Purple'),
                          ],
                        ),
                        value: Colors.purple
                    ),
                    DropdownMenuItem(
                        child: Row(
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                border: Border.all(width: 0.5),
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 10.0,),
                            Text('Red'),
                          ],
                        ),
                        value: Colors.red
                    ),
                    DropdownMenuItem(
                        child: Row(
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                border: Border.all(width: 0.5),
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 10.0,),
                            Text('Orange'),
                          ],
                        ),
                        value: Colors.orange
                    ),
                    DropdownMenuItem(
                        child: Row(
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: Colors.brown,
                                border: Border.all(width: 0.5),
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 10.0,),
                            Text('Brown'),
                          ],
                        ),
                        value: Colors.brown
                    ),
                  ],
                  validator: (value) {
                    if (value == null)
                      return "Please provide the category of the product";
                    else
                      return null;
                  },
                  onChanged: (value) {
                    productColors = value as Color;
                  },
                ),
                SizedBox(height: 30,),
                SizedBox(
                  height: 200,
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    child: TextFormField(
                      expands: true,
                      maxLines: null,
                      maxLength: 150,
                      decoration: InputDecoration(
                        label: Text('Enter Product Details'),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty)
                          return 'Please provide the detail of the product';
                        else if (value.length > 150) //this is for redundancy
                          return 'Do Not Exceed the word limit';
                        else if (value.length < 10)
                          return 'Details is way too short!';
                        else
                          return null;
                      },
                      onSaved: (value) {
                        productDetails = value;
                      },
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
