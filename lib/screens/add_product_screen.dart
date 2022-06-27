import 'package:boogle_mobile/providers/product_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:regexpattern/regexpattern.dart';

import '../main.dart';
import 'package:url_launcher/url_launcher.dart';
class AddProductScreen extends StatefulWidget {
  static String routeName = '/add-product';

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {

  TextEditingController urlController = TextEditingController();

  var urlPattern = r"(https?|http)://";

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
      showDialog<Null>(
          context: context,
          builder: (context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0))
              ),
              actionsPadding: EdgeInsets.all(10.0),
              title: Center(child: Text('Confirmation',style: TextStyle(fontWeight: FontWeight.bold))),
              content: Text(
                  'Have you checked'
                      '\n if all inputs are correct?',
                  textAlign: TextAlign.center,
                  style:TextStyle(fontWeight: FontWeight.w600)
              ),
              actions: [
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: (){
                          Navigator.of(context).pop();
                        },
                        child: Text('Discard', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),),
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xffe6f0fd),
                          elevation: 5,
                        ),
                      ),
                    ),
                    SizedBox(width: 20,),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: (){
                          setState(() {
                            productList.addProduct(productName, productImg, productDetails, productColors, productCategory, productPrice, productSizes, productRating, productCount);
                            FocusScope.of(context).unfocus();

                            form.currentState!.reset();

                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Product added successfully!'),));

                          });
                          Navigator.of(context).pop();
                        },
                        child: Text('Create', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xff314df8),
                          elevation: 5,
                        ),
                      ),

                    ),
                  ],
                ),

              ],
            );
          });

      /* Checking if Values is properly shown
      print(productName);
      print(productImg);
      print(productSizes);
      print(productCategory);
      print(productColors);
      print(productCount);
      print(productRating);
      print(productDetails);
       */
    }
  }

  @override
  Widget build(BuildContext context) {
    ProductList productList = Provider.of<ProductList>(context);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: MyApp.themeNotifier.value == ThemeMode.light? Colors.white: Colors.black,
          ),
          backgroundColor: MyApp.themeNotifier.value == ThemeMode.light? Colors.black: Colors.white,
          title: Text('Add Product',style: TextStyle(
          color:MyApp.themeNotifier.value == ThemeMode.light? Colors.white: Colors.black),),
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
                        InputDecoration(label: Text('Enter Product Name'),enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: MyApp.themeNotifier.value == ThemeMode.light? Colors.black: Colors.white),
                        ),
                          focusedBorder:OutlineInputBorder(
                            borderSide: BorderSide(color: MyApp.themeNotifier.value == ThemeMode.light? Colors.black: Colors.white),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                        ),
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
                    controller: urlController,
                    decoration: InputDecoration(
                      label: Text('Enter URL of Image'),
                      prefixIcon: IconButton(
                        icon: Icon(Icons.open_in_browser),
                        onPressed: () async {

                          if (urlController.text.isEmpty){
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: const Duration(seconds: 2),
                                content: Text('Please Enter a URL to access', ),
                              ),
                            );
                          }
                          //this has to come first to validate if value[0] == ':'
                          //if not this app crashes for exception handling
                          else if (!RegExp(urlPattern).hasMatch(urlController.text)) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: const Duration(seconds: 2),
                                content: Text('Invalid URL', ),
                              ),
                            );
                          }
                          /*once validation done on top, check user's value with flutter default
                          Url validator (some what redundant)*/
                          else if (Uri.parse(urlController.text).isAbsolute) {
                            Uri _url =  Uri.parse(urlController.text);
                            if(!await launchUrl(
                                _url,
                              mode: LaunchMode.inAppWebView,
                            ))
                              {
                                throw 'Could Not Launch $_url';
                              }
                          }

                          else{
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: const Duration(seconds: 2),
                                content: Text('URL cannot be resolve', ),
                              ),
                            );
                          }
                        },
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: MyApp.themeNotifier.value == ThemeMode.light? Colors.black: Colors.white),
                      ),
                      focusedBorder:OutlineInputBorder(
                        borderSide: BorderSide(color: MyApp.themeNotifier.value == ThemeMode.light? Colors.black: Colors.white),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),

                    validator: (value) {

                      if (value!.isEmpty)
                        return 'Please provide the URL of the image.';
                      else if (!value.isUrl())
                        return 'Invalid URL formatting';
                      else if (!value.isImage())
                       return 'Not in Image format! (jpeg| jpg| gif| png| bmp)';
                      else
                        return null;
                    },
                    onSaved: (value) {
                      productImg = value;
                    },
                  ),

                  SizedBox(height: 10,),

                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration:
                              InputDecoration(label: Text('Enter Product Size'),enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: MyApp.themeNotifier.value == ThemeMode.light? Colors.black: Colors.white),
                              ),
                                focusedBorder:OutlineInputBorder(
                                  borderSide: BorderSide(color: MyApp.themeNotifier.value == ThemeMode.light? Colors.black: Colors.white),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                              ),
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
                            hintText: '\$2.50',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: MyApp.themeNotifier.value == ThemeMode.light? Colors.black: Colors.white),
                            ),
                            focusedBorder:OutlineInputBorder(
                              borderSide: BorderSide(color: MyApp.themeNotifier.value == ThemeMode.light? Colors.black: Colors.white),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
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
                      label: Text('Select One Product Category'),enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: MyApp.themeNotifier.value == ThemeMode.light? Colors.black: Colors.white),
                    ),
                      focusedBorder:OutlineInputBorder(
                        borderSide: BorderSide(color: MyApp.themeNotifier.value == ThemeMode.light? Colors.black: Colors.white),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
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
                      label: Text('Select One Product Color'),enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: MyApp.themeNotifier.value == ThemeMode.light? Colors.black: Colors.white),
                    ),
                      focusedBorder:OutlineInputBorder(
                        borderSide: BorderSide(color: MyApp.themeNotifier.value == ThemeMode.light? Colors.black: Colors.white),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
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
                        maxLines: null,
                        maxLength: 512,
                        decoration: InputDecoration(
                          label: Text('Enter Product Details'),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color:MyApp.themeNotifier.value == ThemeMode.light? Colors.black: Colors.white,),
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
                          else if (value.length > 512) //this is for redundancy
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
      ),
    );
  }
}
