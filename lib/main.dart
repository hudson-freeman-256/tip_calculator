import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: TipCalculator() ,
  ));
}

class TipCalculator extends StatefulWidget {
  const TipCalculator({Key? key}) : super(key: key);

  @override
  _TipCalculatorState createState() => _TipCalculatorState();
}

class _TipCalculatorState extends State<TipCalculator> {

  int _tipPercentage = 0;
  int _personCounter = 1;
  double _billAmount = 0.0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
        alignment: Alignment.center,
        color: Colors.white,
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(20.0),
          children: [
            Container(
              width: 150.0,
              height: 150.0,
              decoration: BoxDecoration(
                color: Colors.purpleAccent.shade100.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20.0)
              ),
               child: Center(
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Text("Total Per Person",style: TextStyle(
                       color: Colors.purple,
                       fontSize: 15,
                       fontWeight: FontWeight.bold
                     ),),
                     Padding(
                       padding: const EdgeInsets.all(10.0),
                       child: Text(" \$ ${calculateTotalPerPerson(_billAmount, _personCounter, _tipPercentage)}",style: TextStyle(
                           color: Colors.purple,
                           fontSize: 35,
                       ),),
                     )

                   ],
                 ),
               ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                  color: Colors.purpleAccent.shade100.withOpacity(0.3),
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.circular(12.0)
              ),
              child: Column(
               children: [
                 TextField(
                   keyboardType: TextInputType.numberWithOptions(decimal: true),
                   style: TextStyle(color: Colors.purple),
                   decoration: InputDecoration(
                     prefixText: "Bill Amount ",
                   ),
                     onChanged: (String value) {

                     try{
                       _billAmount = double.parse(value);


                     }catch(Exception){
                       _billAmount = 0.0;
                     }
                     },

                 )
                 ,Row(
                   mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                   children: [
                     Text("Split",style: TextStyle(
                       color: Colors.grey.shade700
                     ),),
                     Row(
                       children: [
                            InkWell(
                              onTap: (){
                                setState(() {

                                  if(_personCounter > 1){
                                     _personCounter--;
                                  }else{

                                  }


                                });
                              } ,
                              child:Container(
                                height: 40.0,
                                width: 40.0,
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7)
                                  ,color: Colors.purple.withOpacity(0.1)
                                ),
                                child: Center(
                                  child: Text("-",style: TextStyle(
                                    color: Colors.purpleAccent,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25.0
                                  ),),
                                ),
                                
                              ) ,

                            ),
                         Text("$_personCounter",style: TextStyle(
                           color: Colors.purpleAccent,
                           fontSize: 20
                         ),),
                         InkWell(
                           onTap: (){
                             setState(() {
                                  _personCounter++;
                             });
                           } ,
                           child:Container(
                             height: 40.0,
                             width: 40.0,
                             margin: EdgeInsets.all(10),
                             decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(7)
                                 ,color: Colors.purple.withOpacity(0.1)
                             ),
                             child: Center(
                               child: Text("+",style: TextStyle(
                                   color: Colors.purpleAccent,
                                   fontWeight: FontWeight.bold,
                                   fontSize: 25.0
                               ),),
                             ),

                           ) ,
                         ),
                       ],
                     ),
                   ],
                 ),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Text("Tip",style: TextStyle(
                         color: Colors.grey.shade700
                     ),),
                     Padding(
                       padding: const EdgeInsets.all(18.0),
                       child: Text("\$ ${ calculateTotalTip(_billAmount, _personCounter, _tipPercentage)}",style: TextStyle(
                         color: Colors.purple,fontSize: 17.0
                       ),),
                     )
                   ],
                 ),
                 Column(
                   children: [
                     Text("$_tipPercentage %",style: TextStyle(
                       color: Colors.purple,
                       fontSize: 17,
                       fontWeight: FontWeight.bold
                     ),),
                     Slider(
                         min: 0,
                         max: 100,
                         activeColor: Colors.purple,
                         inactiveColor: Colors.grey,
                         divisions: 10,
                         value: _tipPercentage.toDouble(), onChanged: (double newValue){
                       setState(() {
                         _tipPercentage = newValue.round();
                       });
                     })
                   ],
                 )
               ],
              ),


            )
          ],
        ),
      )
    );
  }
     calculateTotalPerPerson(double billAmount, int splitBy, int tipPercentage ){

    var totalPerPerson = (calculateTotalTip(billAmount, splitBy, tipPercentage) + billAmount)/splitBy;
    return totalPerPerson;
     }

     calculateTotalTip(double billAmount,int splitBy,int tipPercentage){
           double totalTip = 0.0;

           if(billAmount < 0 || billAmount.toString().isEmpty){

           }else{
             totalTip = (billAmount * tipPercentage) /100;
           }

           return totalTip ;
     }
}





