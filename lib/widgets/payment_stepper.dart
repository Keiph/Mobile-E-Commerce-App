import 'package:boogle_mobile/widgets/purchase_completion.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import '../main.dart';
import '../models/product.dart';

class PaymentStepper extends StatefulWidget {
  @override
  State<PaymentStepper> createState() => _PaymentStepperState();
}

class _PaymentStepperState extends State<PaymentStepper> {
  List<GlobalKey<FormState>> formKeys = [GlobalKey<FormState>(), GlobalKey<FormState>()];

  String yourCountry = 'Singapore';
  String? address1, address2;
  int? postalCode;
  int _index = 0;
  String selectedRadioBtn = 'Cash On Delivery';
  bool isCompleted = false;


  void _onCountryChange(country) {
    //TODO : manipulate the selected country code here
    print("Country selected: " + country.name);
    setState(() {
      yourCountry = country.name.toString();
    });
  }
  void _handlePaymentChange(value){
    setState(() {
      selectedRadioBtn = value;
    });
  }


  @override
  Widget build(BuildContext context) {
    Product purchaseProduct = ModalRoute.of(context)?.settings.arguments as Product;

    return isCompleted ?PurchaseCompletion()
      :Container(
        child: Stepper(
        physics: AlwaysScrollableScrollPhysics() ,
        type: StepperType.horizontal,
        steps: getPaymentSteps(purchaseProduct),
        currentStep: _index,
        onStepContinue: (){
          final isLastStep = _index == getPaymentSteps(purchaseProduct).length-1;
          if(isLastStep){
            print(yourCountry);
            print(postalCode);
            print(address1);
            print(address2);
            print(selectedRadioBtn);
            setState(() => isCompleted = true);
            print("Completed");

          }else{
            if(formKeys[_index].currentState!.validate()){
              formKeys[_index].currentState!.save();
              setState(() => _index +=1);
            }
      }

    },
        onStepCancel: _index == 0 ? null :() => setState(() => _index -=1 ),

        controlsBuilder: (BuildContext context, ControlsDetails details){
          final isLastStep = _index == getPaymentSteps(purchaseProduct).length-1;
          return Container(
            margin: EdgeInsets.only(top:50.0),
            child: Row(
              children: [
                if (_index != 0)
                  Expanded(
                    child: ElevatedButton(
                      child: Text('Back'),
                      onPressed: details.onStepCancel,),
                  ),
                const SizedBox(width: 12,),

                Expanded(
                  child: ElevatedButton(
                    child: Text(!isLastStep ?'Next' : 'Checkout'),
                    onPressed: details.onStepContinue,),
                ),
              ],
            ),
          );
        },
    ),
      );
  }

  List<Step> getPaymentSteps(purchaseProduct) => [

    Step(

      state: _index >0 ?  StepState.complete: StepState.indexed,
      isActive: _index >= 0,
      title: Text('Address', style: TextStyle( fontSize: 12, fontWeight: FontWeight.bold),),
      content: Container(
        child: Form(
          key: formKeys[0],
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: MyApp.themeNotifier.value == ThemeMode.light? Colors.black: Colors.white),
                ),
                child: CountryCodePicker(
                  textStyle: TextStyle(color: MyApp.themeNotifier.value == ThemeMode.light? Colors.black: Colors.white),
                  dialogBackgroundColor: MyApp.themeNotifier.value == ThemeMode.light? Colors.white: Color(0xff424242),
                  onChanged: (country) => _onCountryChange(country),
                  initialSelection: yourCountry,
                  showCountryOnly: true,
                  showOnlyCountryWhenClosed: true,
                  favorite: ['SG'],
                  alignLeft: true,
                  showDropDownButton: true,
                ),
              ),
              SizedBox(height:30),
              TextFormField(
                keyboardType: TextInputType.number,

                decoration: InputDecoration(label: Text('Postal Code'),
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
                    return 'Please provide your postal code!';
                  else if (value.length <6 || value.length >6)
                    // couldn't use regex to check 6 digits using \d{6} as text input is always in String first!
                    return 'Please provide SG postal code only!';
                  else if (int.tryParse(value) == null)
                    return 'Invalid Postal Code, Numbers only!';
                  else
                    return null;
                },
                onSaved: (value) {
                  postalCode = int.tryParse(value!);
                },
              ),
              SizedBox(height: 30,),
              TextFormField(

                decoration: InputDecoration(label: Text('Address Line 1'),
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
                    return 'Please provide your address!';
                  else if (value.length <12)
                    // couldn't use regex to check 6 digits using \d{6} as text input is always in String first!
                    return 'Too short to be a real address!';
                  else
                    return null;
                },
                onSaved: (value) {
                  address1 = value;
                },
              ),
              SizedBox(height: 30,),

              TextFormField(
                //optional TextForm
                decoration: InputDecoration(label: Text('Address Line 2 (Optional)'),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: MyApp.themeNotifier.value == ThemeMode.light? Colors.black: Colors.white),
                  ),
                  focusedBorder:OutlineInputBorder(
                    borderSide: BorderSide(color: MyApp.themeNotifier.value == ThemeMode.light? Colors.black: Colors.white),
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
    ),
    Step(
      state: _index >1 ?  StepState.complete: StepState.indexed,
      isActive: _index >= 1,
      title: Text('Payment', style: TextStyle( fontSize: 12, fontWeight: FontWeight.bold),),
      content: Container(
        child: Form(
          key: formKeys[1],
          child: Container(
            child: Card(
              elevation: 5,
              child: Column(
                children: [
                  RadioListTile(
                    value: 'Cash On Delivery',
                    groupValue: selectedRadioBtn,
                    title: Text('Cash On Delivery'),
                    onChanged: _handlePaymentChange,
                  ),
                  RadioListTile(
                    value: 'Credit/Debit Card',
                    groupValue: selectedRadioBtn,
                    title: Text('Credit/Debit Card'),
                    onChanged: _handlePaymentChange,
                  ),


                  selectedRadioBtn == 'Credit/Debit Card'
                  ?Container(
                    width: double.infinity,
                    height: 250,
                    padding: EdgeInsets.all(10.0),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
                      child: Column(
                        children: [
                          TextField(
                            decoration: InputDecoration(label: Text('Card Number'),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: MyApp.themeNotifier.value == ThemeMode.light? Colors.black: Colors.white),
                              ),
                              focusedBorder:OutlineInputBorder(
                                borderSide: BorderSide(color: MyApp.themeNotifier.value == ThemeMode.light? Colors.black: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(height: 30,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex:3,
                                child: TextField(
                                  decoration: InputDecoration(label: Text('MM/YY'),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: MyApp.themeNotifier.value == ThemeMode.light? Colors.black: Colors.white),
                                    ),
                                    focusedBorder:OutlineInputBorder(
                                      borderSide: BorderSide(color: MyApp.themeNotifier.value == ThemeMode.light? Colors.black: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 100,),
                              Expanded(
                                flex: 2,
                                child: TextField(
                                  decoration: InputDecoration(label: Text('CVV'),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: MyApp.themeNotifier.value == ThemeMode.light? Colors.black: Colors.white),
                                    ),
                                    focusedBorder:OutlineInputBorder(
                                      borderSide: BorderSide(color: MyApp.themeNotifier.value == ThemeMode.light? Colors.black: Colors.white),
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
                  :Container()
                ],
              ),
            ),
          ),
        ),
      ),
    ),
    Step(

      state: _index >2 ?  StepState.complete: StepState.indexed,
      isActive: _index >= 2,
      title: Text('Checkout', style: TextStyle( fontSize: 12, fontWeight: FontWeight.bold),),
      content: Column(
        children: [Card(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(right:10.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.15,
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(purchaseProduct.productImg),
                      fit: BoxFit.cover,

                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    children:[
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              purchaseProduct.productName,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,

                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: Row(
                          children: [
                            Text('\$${purchaseProduct.productPrice.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),)
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Row(
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: 15,
                                  height: 15,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(0.3),
                                          blurRadius: 1,
                                          offset: Offset(3, 3)),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    color: purchaseProduct.productColors,
                                    border: Border.all(width: 0.5),
                                    shape: BoxShape.circle,

                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,

                        children: [Text('X '+'${purchaseProduct.productCount}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),],
                      ),
                    ],
                  ),
                ),
              ],),
          ),

        ),
          SizedBox(height: 10.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '+ \$30.00 delivery fee',
              ),
            ],
          ),
          SizedBox(height: 5.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Total: '+'\$${(purchaseProduct.productPrice * purchaseProduct.productCount).toStringAsFixed(2)}',
              ),
            ],
          ),

        ],
      ),
    ),

  ];
}
