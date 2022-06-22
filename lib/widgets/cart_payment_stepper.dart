import 'package:boogle_mobile/widgets/purchase_completion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../providers/cart_list.dart';

class CartPaymentStepper extends StatefulWidget {

  @override
  State<CartPaymentStepper> createState() => _CartPaymentStepperState();
}

class _CartPaymentStepperState extends State<CartPaymentStepper> {
  int _index = 0;
  bool isCompleted = false;

  @override
  Widget build(BuildContext context) {

    CartList allCartProduct = Provider.of<CartList>(context);


    return isCompleted ? PurchaseCompletion()
        :Stepper(
      physics: AlwaysScrollableScrollPhysics() ,
      type: StepperType.horizontal,
      steps: getPaymentSteps(allCartProduct),
      currentStep: _index,
      onStepContinue: (){
        final isLastStep = _index == getPaymentSteps(allCartProduct).length-1;
        if(isLastStep){
          setState(() => isCompleted = true);
          allCartProduct.clearCartUponCompletion();
          print("Completed");
        }else{
          setState(() => _index +=1);
        }
      },
      onStepCancel: _index == 0 ? null :() => setState(() => _index -=1 ),

      controlsBuilder: (BuildContext context, ControlsDetails details){
        final isLastStep = _index == getPaymentSteps(allCartProduct).length-1;

        return Container(
          margin: EdgeInsets.only(top:30.0),
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
    );
  }

  List<Step> getPaymentSteps(allCartProduct) => [
    Step(
      state: _index >0 ?  StepState.complete: StepState.indexed,
      isActive: _index >= 0,
      title: Text('Address', style: TextStyle( fontSize: 12, fontWeight: FontWeight.bold),),
      content: Container(

      ),
    ),
    Step(
      state: _index >1 ?  StepState.complete: StepState.indexed,
      isActive: _index >= 1,
      title: Text('Payment', style: TextStyle( fontSize: 12, fontWeight: FontWeight.bold),),
      content: Container(

      ),
    ),
    Step(

      state: _index >2 ?  StepState.complete: StepState.indexed,
      isActive: _index >= 2,
      title: Text('Checkout',
        style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold
        ),
      ),

      content: Container(
        // no margin needed Stepper has default margin
        padding: EdgeInsets.symmetric(vertical: 5.0),
        decoration: BoxDecoration(
          border: Border.all()
        ),
        child: Column(
          children: [

            SizedBox(
              width: double.infinity,
              height: 375,
              child: ListView.builder(

              itemBuilder: (BuildContext context, int i){
                Product cartProduct =  allCartProduct.getMyCartList()[i];

                Size size = MediaQuery.of(context).size;

                return Container(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 10.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                child: Image.network(
                                  cartProduct.productImg,
                                  width: size.width* 0.45,
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
                                          cartProduct.productName,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                    child: Row(
                                      children: [
                                        Text('\$${cartProduct.productPrice.toStringAsFixed(2)}',)
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
                                              ),
                                            ),
                                            Container(
                                              width: 10,
                                              height: 10,
                                              decoration: BoxDecoration(
                                                color: cartProduct.productColors,
                                                border: Border.all(width: 0.5),
                                                shape: BoxShape.circle,
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.black.withOpacity(0.3),
                                                      blurRadius: 1,
                                                      offset: Offset(3, 3)),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,

                                    children: [Text('X '+'${cartProduct.productCount}',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),],
                                  ),
                                ],
                              ),
                            ),
                          ],),
                      ),

                    ),

                  ),
                );


              },
                  itemCount: allCartProduct.getMyCartList().length,
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: [
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
                        'Total: '+'\$${allCartProduct.getTotalAmount().toStringAsFixed(2) }',
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
    

  ];
  }
