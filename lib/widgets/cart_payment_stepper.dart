import 'package:boogle_mobile/constants.dart';
import 'package:boogle_mobile/services/auth_service.dart';
import 'package:boogle_mobile/services/firestore_service.dart';
import 'package:boogle_mobile/widgets/purchase_completion.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:boogle_mobile/main.dart';
import 'package:boogle_mobile/models/product.dart';
import 'package:boogle_mobile/providers/cart_list.dart';

import '../models/orders.dart';

class CartPaymentStepper extends StatefulWidget {
  @override
  State<CartPaymentStepper> createState() => _CartPaymentStepperState();
}

class _CartPaymentStepperState extends State<CartPaymentStepper> {
  //initialise a list of GlobalKey FormState for the different Stepper List
  //content that requires form controls
  List<GlobalKey<FormState>> formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>()
  ];

  FirestoreService fsService = FirestoreService();


  // initialise yourCountry with Singapore
  String yourCountry = 'Singapore';
  // initialise addresses as nullable
  String? address1, address2;
  // initialise postalCode as nullable
  int? postalCode;
  //
  int totalItem = 0;
  //
  double amount = 0;
  // initialise _index = 0
  int _index = 0;
  // initialise paidBy = "Cash on Delivery"
  String paidBy = 'Cash On Delivery';
  // initialise isCompleted = false
  bool isCompleted = false;

  //set country name to the country selected
  void _onCountryChange(country) {
    //TODO : manipulate the selected country code here
    if (kDebugMode) {
      print('Country selected: ' + country.name);
    }
    setState(() {
      yourCountry = country.name.toString();
    });
  }

  //changes the radioBtn to active/inactive accordingly
  void _handlePaymentChange(value) {
    setState(() {
      paidBy = value;
    });
  }



  @override
  Widget build(BuildContext context) {
    //if isCompleted == true returns a separate widget else return Stepper Widget
    return isCompleted
        ? const PurchaseCompletion()
        : StreamBuilder<List<Product>>(
          stream: fsService.getUserCartItems(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else{
            return Stepper(
                physics: const AlwaysScrollableScrollPhysics(),
                type: StepperType.horizontal,
                steps: getPaymentSteps(),
                currentStep: _index,
                onStepContinue: () {
                  //if isLastStep when user press on continue button set isCompleted
                  // = true and runs the separate Widget
                  final isLastStep = _index == getPaymentSteps().length - 1;
                  if (isLastStep) {
                    if (kDebugMode) {
                      print(yourCountry);
                      print(postalCode);
                      print(address1);
                      print(address2);
                      print(paidBy);
                      print('Completed');
                    }

                    fsService.addToOrder(postalCode,address1,paidBy,amount,totalItem,DateTime.now(), DateTime.now().add(Duration(days: 3)));

                    NotificationApi.showNotification()
                    setState(() => isCompleted = true);

                    //Successfully purchase the list of Product and thus remove
                    //items from CartList  upon calling the clearCart method

                  } else {
                    //if is not the last step we check if validation is cleared
                    if (formKeys[_index].currentState!.validate()) {
                      // if validation is good save the value at each given stepper
                      formKeys[_index].currentState!.save();
                      // move on to the next step
                      setState(() => _index += 1);
                    }
                  }
                },
                onStepCancel:
                    // if it is the first step show return nothing, else set state
                    // of _index decrement by 1 to go to the previous Step
                    _index == 0 ? null : () => setState(() => _index -= 1),

                // controlsBuilder allows us to modify the default button build by the Stepper Widget
                controlsBuilder: (BuildContext context, ControlsDetails details) {
                  final isLastStep = _index == getPaymentSteps().length - 1;

                  return Container(
                    margin: const EdgeInsets.only(top: 30.0),
                    child: Row(
                      children: [
                        // checks if the stepper is not at the first step
                        // if it is at the first step do not show the back button
                        if (_index != 0)
                          Expanded(
                            child: ElevatedButton(
                              child: const Text('Back'),
                              onPressed: details.onStepCancel,
                            ),
                          ),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: ElevatedButton(
                            child: Text(!isLastStep ? 'Next' : 'Checkout'),
                            onPressed: details.onStepContinue,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );}
          }
        );
  }

  List<Step> getPaymentSteps() => [
        Step(
          state: _index > 0 ? StepState.complete : StepState.indexed,
          isActive: _index >= 0,
          title: const Text(
            'Address',
            style: TextStyleConst.kSmallBold,
          ),

          //UI of the first Step
          content: Form(
            //uses one out of the 2 GlobalKey initialise at the top of the code
            key: formKeys[0],
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: MyApp.themeNotifier.value == ThemeMode.light
                          ? Colors.black
                          : Colors.white,
                    ),
                  ),

                  //Dropdown Selector for Country
                  child: CountryCodePicker(
                    textStyle: TextStyle(
                      color: MyApp.themeNotifier.value == ThemeMode.light
                          ? Colors.black
                          : Colors.white,
                    ),
                    dialogBackgroundColor:
                        MyApp.themeNotifier.value == ThemeMode.light
                            ? Colors.white
                            : const Color(0xff424242),
                    onChanged: (country) => _onCountryChange(country),
                    initialSelection: yourCountry,
                    showCountryOnly: true,
                    showOnlyCountryWhenClosed: true,
                    favorite: const ['SG'],
                    alignLeft: true,
                    showDropDownButton: true,
                  ),
                ),
                const SizedBox(height: 30),

                //Postal Code TextFormField
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    label: const Text('Postal Code'),
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
                    //check if value is empty
                    if (value!.isEmpty) {
                      return 'Please provide your postal code!';
                    }
                    // check if value is 6 digit
                    else if (value.length < 6 || value.length > 6) {
                      return 'Please provide SG postal code only!';
                    }
                    //check if value is of a int data type
                    else if (int.tryParse(value) == null) {
                      return 'Invalid Postal Code, Numbers only!';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    // set data type to integer data type
                    postalCode = int.tryParse(value!);
                  },
                ),
                const SizedBox(
                  height: 30,
                ),

                // Address 1 TextFormField
                TextFormField(
                  decoration: InputDecoration(
                    label: const Text('Address Line 1'),
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
                    //check if value is empty
                    if (value!.isEmpty) {
                      return 'Please provide your address!';
                    }
                    //check if value is less than 12
                    else if (value.length < 12) {
                      return 'Too short to be a real address!';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    address1 = value;
                  },
                ),
                const SizedBox(
                  height: 30,
                ),

                //Address Line 2 TextFormField
                TextFormField(
                  //optional TextForm
                  decoration: InputDecoration(
                    label: const Text('Address Line 2 (Optional)'),
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
                  ),

                  onSaved: (value) {
                    address2 = value;
                  },
                ),
              ],
            ),
          ),
        ),
        Step(
          state: _index > 1 ? StepState.complete : StepState.indexed,
          isActive: _index >= 1,
          title: const Text(
            'Payment',
            style: TextStyleConst.kSmallBold,
          ),
          //2nd Step UI Screens
          content: Form(
            key: formKeys[1],
            child: Card(
              elevation: 5,
              child: Column(
                children: [
                  RadioListTile(
                    value: 'Cash On Delivery',
                    groupValue: paidBy,
                    title: const Text('Cash On Delivery'),
                    onChanged: _handlePaymentChange,
                  ),
                  RadioListTile(
                    value: 'Credit/Debit Card',
                    groupValue: paidBy,
                    title: Row(
                      children: [
                        const Expanded(child: Text('Credit/Debit Card')),
                        Row(
                          children: [
                            Image.asset('images/mastercard.png', width: 30),
                            const SizedBox(width: 5.0),
                            Image.asset('images/visa.png', width: 30),
                          ],
                        ),
                      ],
                    ),
                    onChanged: _handlePaymentChange,
                  ),

                  //if Credit/Debit is selected Show Container with TextFormField
                  paidBy == 'Credit/Debit Card'
                      ? Container(
                          width: double.infinity,
                          height: 250,
                          padding: const EdgeInsets.all(10.0),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 30.0,
                              horizontal: 20.0,
                            ),
                            child: Column(
                              children: [
                                TextField(
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    label: const Text('Card Number'),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: MyApp.themeNotifier.value ==
                                                ThemeMode.light
                                            ? Colors.black
                                            : Colors.white,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: MyApp.themeNotifier.value ==
                                                ThemeMode.light
                                            ? Colors.black
                                            : Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: TextField(
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          label: const Text('MM/YY'),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  MyApp.themeNotifier.value ==
                                                          ThemeMode.light
                                                      ? Colors.black
                                                      : Colors.white,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  MyApp.themeNotifier.value ==
                                                          ThemeMode.light
                                                      ? Colors.black
                                                      : Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 100,
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: TextField(
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          label: const Text('CVV'),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  MyApp.themeNotifier.value ==
                                                          ThemeMode.light
                                                      ? Colors.black
                                                      : Colors.white,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  MyApp.themeNotifier.value ==
                                                          ThemeMode.light
                                                      ? Colors.black
                                                      : Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      : Container()
                ],
              ),
            ),
          ),
        ),
        Step(
          //last Step UI
          state: _index > 2 ? StepState.complete : StepState.indexed,
          isActive: _index >= 2,
          title: const Text(
            'Checkout',
            style: TextStyleConst.kSmallBold,
          ),
          content: StreamBuilder<List<Product>>(
              stream: FirestoreService().getUserCartItems(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  if (_index == 2){
                    totalItem = 0;
                    amount = 0;
                  snapshot.data!.forEach((doc) {
                    amount += doc.productPrice * doc.productCount;
                    totalItem += doc.productCount;
                  });
                  }

                  return Container(
                    // no margin needed Stepper has default margin
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: MyApp.themeNotifier.value == ThemeMode.light
                            ? Colors.black
                            : Colors.white,
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 375,
                          child: ListView.builder(
                            itemBuilder: (BuildContext context, int i) {
                              Size size = MediaQuery.of(context).size;

                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.only(
                                              right: 10.0),
                                          child: SizedBox(
                                            width: size.width * 0.4,
                                            height: size.height * 0.15,
                                          ),
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  snapshot.data![i].productImg),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      snapshot
                                                          .data![i].productName,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyleConst
                                                          .kMediumBold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 10.0,
                                                  bottom: 10.0,
                                                ),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      '\$${snapshot.data![i].productPrice.toStringAsFixed(2)}',
                                                      style: TextStyleConst
                                                          .kMediumBold,
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 10.0),
                                                child: Row(
                                                  children: [
                                                    Stack(
                                                      alignment:
                                                          Alignment.center,
                                                      children: [
                                                        Container(
                                                          width: 15,
                                                          height: 15,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            shape:
                                                                BoxShape.circle,
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.3),
                                                                blurRadius: 1,
                                                                offset:
                                                                    const Offset(
                                                                        3, 3),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 10,
                                                          height: 10,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(snapshot
                                                                .data![i]
                                                                .productColors),
                                                            border: Border.all(
                                                                width: 0.5),
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    'X '
                                                    '${snapshot.data![i].productCount}',
                                                    style: TextStyleConst
                                                        .kLargeBold,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemCount: snapshot.data!.length,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: const [
                                  Text(
                                    '+ \$30.00 delivery fee',
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    'Total: '
                                    '\$2',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }
              }),
        ),
      ];
}
