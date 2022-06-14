import 'package:boogle_mobile/widgets/purchase_completion.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/product.dart';

class PaymentStepper extends StatefulWidget {
  @override
  State<PaymentStepper> createState() => _PaymentStepperState();
}

class _PaymentStepperState extends State<PaymentStepper> {
  int _index = 0;
  bool isCompleted = false;

  @override
  Widget build(BuildContext context) {
    Product purchaseProduct = ModalRoute.of(context)?.settings.arguments as Product;
    return isCompleted ?PurchaseCompletion()
      :Stepper(
      physics: AlwaysScrollableScrollPhysics() ,
      type: StepperType.horizontal,
      steps: getPaymentSteps(purchaseProduct),
      currentStep: _index,
      onStepContinue: (){
        final isLastStep = _index == getPaymentSteps(purchaseProduct).length-1;
        if(isLastStep){
          setState(() => isCompleted = true);
          print("Completed");
        }else{
          setState(() => _index +=1);
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
    );
  }

  List<Step> getPaymentSteps(purchaseProduct) => [
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
      title: Text('Checkout', style: TextStyle( fontSize: 12, fontWeight: FontWeight.bold),),
      content: Container(
        child: Row(
          children: [
            Image.network(purchaseProduct.productImg, height: 100,),
            Text(purchaseProduct.productName),
            Text('\$${purchaseProduct.productPrice}'),
            Text('${purchaseProduct.productCount}'),
          ],
        ),
      ),
    ),

  ];
}
