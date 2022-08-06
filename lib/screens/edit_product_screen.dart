import 'package:boogle_mobile/constants.dart';
import 'package:boogle_mobile/main.dart';
import 'package:boogle_mobile/models/product.dart';
import 'package:boogle_mobile/services/firestore_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:regexpattern/regexpattern.dart';
import 'package:url_launcher/url_launcher.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({Key? key}) : super(key: key);
  static String routeName ='/edit-product';


  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {

  String? productName,
      productImg,
      productCategory,
      productSizes,
      productDetails;
  int? productColors;
  double? productPrice;
  int productCount = 1;
  double productRating = 5.0;

  var urlPattern = r'(https?|http)://';

  var form = GlobalKey<FormState>();

  void saveForm( String id ) {
    bool isValid = form.currentState!.validate();
    // check if all TextFormField are validated
    if (isValid) {
      form.currentState!.save();
      showDialog<void>(
        context: context,
        // Builds on Alert Dialog widget
        builder: (context) {
          return AlertDialog(
            // Smoothen the border of the Dialog
            shape: kDefaultAlertBorder,
            actionsPadding: const EdgeInsets.all(10.0),
            title: const Center(
              child: Text(
                'Confirmation',
                style: TextStyleConst.kLargeBold,
              ),
            ),
            content: const Text(
              'Have you checked'
                  '\n if all inputs are correct?',
              textAlign: TextAlign.center,
              style: TextStyleConst.kMediumSemi,
            ),
            actions: [
              Row(
                // Width of Row shared equally with the 2 elevated button
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate out of the Dialog
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Discard',
                        style: TextStyleConst.kBlackMediumSemi,
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: ColorConst.kWhiteSecondaryBtn,
                        elevation: 5,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          // make call to provider addProduct Function and added required params into the constructor
                          FirestoreService fsService = FirestoreService();
                          fsService.editProduct(id, productName, productImg, productDetails, productCategory,productColors, productPrice, productSizes, productRating, productCount).then((value){
                            fsService.updateCartProduct(id,productName, productImg, productDetails, productCategory,productColors, productPrice, productSizes, productRating, productCount);
                            fsService.updateLikedProduct(id ,productName, productImg, productDetails, productCategory,productColors, productPrice, productSizes, productRating, productCount);
                          });
                          FocusScope.of(context).unfocus();

                          if (kDebugMode) {
                            print(productName);
                            print(productImg);
                            print(productSizes);
                            print(productCategory);
                            print(productColors);
                            print(productCount);
                            print(productRating);
                            print(productDetails);
                          }

                          // initialise a new form
                          form.currentState!.reset();

                          //Shows Snackbar upon adding product
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Product added successfully!'),
                            ),
                          );
                        }
                        );
                        // Navigate out of Dialog
                        Navigator.of(context).pop();
                        // Navigate out of edit screen
                        Navigator.of(context).pop();
                        // Navigate out of product screen
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Create',
                        style: TextStyleConst.kWhiteMediumSemi,
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: ColorConst.kBluePrimaryBtn,
                        elevation: 5,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    Product selectedProduct = ModalRoute.of(context)?.settings.arguments as Product;
    TextEditingController urlController = TextEditingController(text: selectedProduct.productImg);
    return GestureDetector(
      //hide mobile keyboard upon click
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: MyApp.themeNotifier.value == ThemeMode.light
                ? Colors.white
                : Colors.black,
          ),
          backgroundColor: MyApp.themeNotifier.value == ThemeMode.light
              ? Colors.black
              : Colors.white,
          title: Text(
            'Edit Product',
            style: TextStyle(
              color: MyApp.themeNotifier.value == ThemeMode.light
                  ? Colors.white
                  : Colors.black,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.save),
              // call method
              onPressed: () {
                saveForm(selectedProduct.id);
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Form(
              // calls FormState GlobalKey
              key: form,
              child: Column(
                children: [
                  //Product Name Text Form
                  TextFormField(
                    initialValue: selectedProduct.productName,
                    decoration: InputDecoration(
                      label: const Text('Enter Product Name'),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: MyApp.themeNotifier.value == ThemeMode.light
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: MyApp.themeNotifier.value == ThemeMode.light
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                      errorBorder: kErrorBorder,
                      focusedErrorBorder: kErrorBorder,
                    ),
                    validator: (value) {
                      // if TextFormField is empty
                      if (value!.isEmpty) {
                        return 'Please provide the name of the product.';
                      }
                      // if TextFormField length is not within 3-24
                      else if (value.length < 3 || value.length > 24) {
                        return 'Please provide name of product in the range 3-24';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      productName = value;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  // Image Url TextFormField
                  TextFormField(
                    //TextEditingController added here to listen to the value of the text String literals
                    controller: urlController,
                    decoration: InputDecoration(
                      label: const Text('Enter URL of Image'),
                      prefixIcon: IconButton(
                        icon: const Icon(Icons.open_in_browser),
                        onPressed: () async {
                          // if user input is empty return Feedback for Invalid
                          if (urlController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                duration: Duration(seconds: 2),
                                content: Text(
                                  'Please Enter a URL to access',
                                ),
                              ),
                            );
                          }
                          // if value does not match declared regular expression
                          else if (!RegExp(urlPattern)
                              .hasMatch(urlController.text)) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                duration: Duration(seconds: 2),
                                content: Text(
                                  'Invalid URL',
                                ),
                              ),
                            );
                          }
                          //once validation done on top, check user's value with flutter default Url validator (some what redundant)
                          // if value can be parse as Uri
                          else if (Uri.parse(urlController.text).isAbsolute) {
                            Uri _url = Uri.parse(urlController.text);
                            // launch url link in app
                            if (!await launchUrl(
                              _url,
                              mode: LaunchMode.inAppWebView,
                            )) {
                              throw 'Could Not Launch $_url';
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                duration: Duration(seconds: 2),
                                content: Text(
                                  'URL cannot be resolve',
                                ),
                              ),
                            );
                          }
                        },
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: MyApp.themeNotifier.value == ThemeMode.light
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: MyApp.themeNotifier.value == ThemeMode.light
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                      errorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                    validator: (value) {
                      //checks if user input is empty
                      if (value!.isEmpty) {
                        return 'Please provide the URL of the image.';
                      }

                      //checks if user input matches with url regular expression
                      else if (!value.isUrl()) {
                        return 'Invalid URL formatting';
                      }
                      else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      productImg = value;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    // Row Shared equally by 2 TextFormField
                    children: [
                      Expanded(
                        // TextFormField for Product Size
                        child: TextFormField(
                          initialValue: selectedProduct.productSizes,
                          decoration: InputDecoration(
                            label: const Text('Enter Size'),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color:
                                MyApp.themeNotifier.value == ThemeMode.light
                                    ? Colors.black
                                    : Colors.white,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color:
                                MyApp.themeNotifier.value == ThemeMode.light
                                    ? Colors.black
                                    : Colors.white,
                              ),
                            ),
                            errorBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            focusedErrorBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                          ),
                          validator: (value) {
                            //checks if user input is empty
                            if (value!.isEmpty) {
                              return 'Please provide the size of the product';
                            }

                            //checks if user input in less than 19 words
                            else if (value.length > 18) {
                              return 'Please provide a valid product size. keep it less than 19 words';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            productSizes = value;
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Expanded(
                        // TextFormField for Product Price
                        child: TextFormField(
                          initialValue: selectedProduct.productPrice.toStringAsFixed(2),
                          decoration: InputDecoration(
                            label: const Text('Enter Price'),
                            hintText: '\$2.50',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color:
                                MyApp.themeNotifier.value == ThemeMode.light
                                    ? Colors.black
                                    : Colors.white,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color:
                                MyApp.themeNotifier.value == ThemeMode.light
                                    ? Colors.black
                                    : Colors.white,
                              ),
                            ),
                            errorBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            focusedErrorBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                          ),
                          keyboardType: TextInputType
                              .number, //opens up keyboard in number only
                          validator: (value) {
                            //checks if user input is empty
                            if (value!.isEmpty) {
                              return 'Please provide a price';
                            }

                            //checks if user input is of a double data type
                            else if (double.tryParse(value) == null) {
                              return 'Invalid price format';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            //change value to double data type from default String data type
                            productPrice = double.parse(value!);
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  //Dropdown Option Field for Product Category
                  DropdownButtonFormField(
                    value: selectedProduct.productCategory,
                    decoration: InputDecoration(
                      label: const Text('Select One Product Category'),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: MyApp.themeNotifier.value == ThemeMode.light
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: MyApp.themeNotifier.value == ThemeMode.light
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                      errorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                    items: const [
                      //list of dropdown items for user to choose
                      DropdownMenuItem(
                        child: Text('Clothes'),
                        value: 'clothes',
                      ),
                      DropdownMenuItem(
                        child: Text('Pants'),
                        value: 'pants',
                      ),
                      DropdownMenuItem(
                        child: Text('Shoes'),
                        value: 'shoes',
                      ),
                      DropdownMenuItem(
                        child: Text('Computer & Games'),
                        value: 'computer&games',
                      ),
                      DropdownMenuItem(
                        child: Text('Grocery'),
                        value: 'grocery',
                      ),
                      DropdownMenuItem(
                        child: Text('Pet Supplies'),
                        value: 'petSupplies',
                      ),
                      DropdownMenuItem(
                        child: Text('Miscellaneous'),
                        value: 'misc',
                      ),
                    ],
                    validator: (value) {
                      //checks if user have selected an option
                      if (value == null) {
                        return 'Please provide the category of the product';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      productCategory = value as String;
                    },
                    onSaved: (value) {
                      productCategory = value as String;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  //Dropdown Option for Product Color
                  DropdownButtonFormField(
                    value: selectedProduct.productColors,
                    decoration: InputDecoration(
                      label: const Text('Select One Product Color'),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: MyApp.themeNotifier.value == ThemeMode.light
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: MyApp.themeNotifier.value == ThemeMode.light
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                      errorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                    items: [
                      // show a list of dropdown item for product colors
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
                            const SizedBox(
                              width: 10.0,
                            ),
                            const Text('White'),
                          ],
                        ),
                        value: Colors.white.value,
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
                            const SizedBox(
                              width: 10.0,
                            ),
                            const Text('Black'),
                          ],
                        ),
                        value: Colors.black.value,
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
                            const SizedBox(
                              width: 10.0,
                            ),
                            const Text('Grey'),
                          ],
                        ),
                        value: Colors.grey.value,
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
                            const SizedBox(
                              width: 10.0,
                            ),
                            const Text('Yellow'),
                          ],
                        ),
                        value: Colors.yellow.value,
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
                            const SizedBox(
                              width: 10.0,
                            ),
                            const Text('Green'),
                          ],
                        ),
                        value: Colors.green.value,
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
                            const SizedBox(
                              width: 10.0,
                            ),
                            const Text('Blue'),
                          ],
                        ),
                        value: Colors.blue.value,
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
                            const SizedBox(
                              width: 10.0,
                            ),
                            const Text('Purple'),
                          ],
                        ),
                        value: Colors.purple.value,
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
                            const SizedBox(
                              width: 10.0,
                            ),
                            const Text('Red'),
                          ],
                        ),
                        value: Colors.red.value,
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
                            const SizedBox(
                              width: 10.0,
                            ),
                            const Text('Orange'),
                          ],
                        ),
                        value: Colors.orange.value,
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
                            const SizedBox(
                              width: 10.0,
                            ),
                            const Text('Brown'),
                          ],
                        ),
                        value: Colors.brown.value,
                      ),
                    ],
                    validator: (value) {
                      //checks if user have selected an option in Dropdown Field
                      if (value == null) {
                        return 'Please provide the color of the product';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      productColors = value as int? ;
                    },
                    onSaved: (value) {
                      productColors = value as int? ;
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),

                  //TextFormField for Product details
                  SizedBox(
                    height: 200,
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        initialValue: selectedProduct.productDetails,
                        maxLines:
                        null, // do a line break whenever the line reaches the max width and height of sized box
                        maxLength:
                        512, // amount of characters this field allows is 512 characters
                        decoration: InputDecoration(
                          label: const Text('Enter Product Details'),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color:
                              MyApp.themeNotifier.value == ThemeMode.light
                                  ? Colors.black
                                  : Colors.white,
                            ),
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
                          //checks if user input is empty
                          if (value!.isEmpty) {
                            return 'Please provide the detail of the product';
                          }

                          //checks if user input is more than 512 characters (redundancy)
                          else if (value.length > 512) {
                            return 'Do Not Exceed the word limit';
                          }

                          //checks if user input is less than 10 characters
                          else if (value.length < 10) {
                            return 'Details is way too short!';
                          } else {
                            return null;
                          }
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
