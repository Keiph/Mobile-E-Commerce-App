import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class QuantityCounter extends StatefulWidget {

  @override
  State<QuantityCounter> createState() => _QuantityCounterState();
}

class _QuantityCounterState extends State<QuantityCounter> {
  int count = 1;

  void _decrementValidator(){
    count < 2 ? count: setState((){
      count--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          child: Container(
            width: 32,
            height: 32,
            child: Icon(Icons.remove),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all()
            ),
          ),
          onTap: _decrementValidator,
        ),
        SizedBox(
          width: 10,
        ),

        Container(
          width: 64,
          height: 32,
          child: Center(
            child: Text('${count}'),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(
              
            ),
          ),
        ),

        SizedBox(
          width: 10,
        ),

        GestureDetector(
          child: Container(
            width: 32,
            height: 32,
            child: Icon(Icons.add),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all()
            ),
          ),
          onTap: ()=> setState(() => count++),
        ),
      ],
    );
  }
}
