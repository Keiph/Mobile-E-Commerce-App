import 'package:boogle_mobile/widgets/purchase_completion.dart';
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
          print("Completed");
        }else{
          setState(() => _index +=1);
        }
      },
      onStepCancel: _index == 0 ? null :() => setState(() => _index -=1 ),

      controlsBuilder: (BuildContext context, ControlsDetails details){
        final isLastStep = _index == getPaymentSteps(allCartProduct).length-1;

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
      title: Text('Checkout', style: TextStyle( fontSize: 12, fontWeight: FontWeight.bold),),
      content: Column(
        children: [ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int i){
            Product cartProduct =  allCartProduct.getMyCartList()[i];

            Size size = MediaQuery.of(context).size;

            void _decrementValidator() {
              cartProduct.productCount < 2
                  ? cartProduct.productCount
                  : setState(() {
                cartProduct.productCount -= 1;
              });
            }

            return Container(
              child: Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 10.0),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                child: Image.network(
                                  cartProduct.productImg,
                                  width: size.width* 0.45,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Row(
                                  children: [
                                    RatingBar.builder(
                                      ignoreGestures: true,
                                      initialRating: cartProduct.productRating,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemSize: 18.0,
                                      itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: (rating) {},
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children:[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  ClipOval(
                                    child: Material(
                                      color: Colors.black, // Button color
                                      child: InkWell(
                                        splashColor: Colors.red[300], // Splash color
                                        onTap: () {
                                          allCartProduct.removeFromCart(i);
                                        },
                                        child: SizedBox(
                                          width: 32,
                                          height: 32,
                                          child: Icon(Icons.close,color: Colors.white,),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 10.0),
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
                                            color: Colors.grey[300],
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
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 10.0),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      child: Container(
                                        width: 24,
                                        height: 24,
                                        child: Icon(Icons.remove, size: 12,),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5.0),
                                            border: Border.all()),
                                      ),
                                      onTap: _decrementValidator,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      width: 32,
                                      height: 24,
                                      child: Center(
                                        child: Text('${cartProduct.productCount}'),
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5.0),
                                        border: Border.all(),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    GestureDetector(
                                      child: Container(
                                        width: 24,
                                        height: 24,
                                        child: Icon(Icons.add, size: 12,),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5.0),
                                            border: Border.all()),
                                      ),
                                      onTap: () =>
                                          setState(() => cartProduct.productCount += 1),
                                    ),
                                  ],
                                ),
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
      ],
      ),
      ),
    

  ];
  }
