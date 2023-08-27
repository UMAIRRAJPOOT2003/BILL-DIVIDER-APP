import 'package:flutter/material.dart';

class billsplit extends StatefulWidget {
  const billsplit({super.key});

  @override
  State<billsplit> createState() => _billsplitState();
}

class _billsplitState extends State<billsplit> {
  int _tippercentage=0;
  int _personcounter=0;
  int _percentagecounter=1;
  double _billamount=0.0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Container(
            margin:EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1),
            alignment:Alignment.center,
            color:Colors.white,
            child:ListView(
                scrollDirection:Axis.vertical,
                children:<Widget>[
                  Container_myfunctionfirst(),
                  SizedBox(height: 20),
                  Container_myfunctionsecond(),

                ]
            )
        )
    );
    // );return const Placeholder();
  }

  Container_myfunctionfirst()
  {
    return Container(
        width:100,
        height:200,
        decoration:BoxDecoration(
          //border:Border.all(color:Colors.blue.shade500,),
          color:Colors.purple.shade50,
          borderRadius:BorderRadius.circular(2.2),
        ),
        child:Column(
            mainAxisAlignment:MainAxisAlignment.center,
            children:<Widget>[
              Text(" Total per person",style:TextStyle(color:Colors.purple,fontWeight:FontWeight.bold,
                fontSize:15.0,),
              ),
              Text("\$ ${calculatetotalperperson(_billamount,_personcounter,_tippercentage)}",style:TextStyle(color:Colors.purple,fontSize:34.9,
                fontWeight:FontWeight.bold,),
              )
            ]

        )
    );
  }

  Container_myfunctionsecond()
  {
    return Container(

        margin:EdgeInsets.only(top:20.0),
        //padding:EdgeInsets.all(12.0),
        decoration:BoxDecoration(
          color:Colors.transparent,

          borderRadius:BorderRadius.circular(12.0),
        ),
        child:Column(
            children:<Widget>[
              TextField(
                  keyboardType: TextInputType.numberWithOptions(decimal:true),
                  style:TextStyle(
                      color:Colors.grey),
                  decoration:InputDecoration(
                    prefixText: "BILL AMOUNT",
                    prefixIcon: Icon(Icons.attach_money),
                  ),
                  onChanged:(String value )//the value will is the amount that we give input to our app
                  {
                    try{
                      _billamount=double.parse(value);//if user enter a string value as input then this try block will change and praise that string value into double value
                    }catch(exception) {//this catch blockwill executed when try block throw exception due to any reason
                      _billamount=0.0;
                    }
                  }



              ),
              Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween,

                  children:<Widget>[
                    Text("Split",style:TextStyle(color:Colors.grey.shade700),),
                    Row(
                        children:<Widget>[
                          InkWell(
                            onTap:(){
                              setState(() {
                                if(_personcounter>=1)
                                {
                                  _personcounter--;

                                }
                                else{
                                  //do nothing
                                }
                              });
                            },
                            child:Container(
                              width:40,
                              height:40,
                              margin:EdgeInsets.all(10.0),
                              decoration:BoxDecoration(
                                border:Border.all(color:Colors.blue.shade500,),
                                borderRadius:BorderRadius.circular(7.0),
                                color:Colors.purple.withOpacity(0.1),//with opacity is ued to give color shade to anything that is not present in colors.shade property
                              ),
                              child:Center(
                                child:Text("-",style:TextStyle(color:Colors.purple,fontWeight:FontWeight.bold,fontSize:17.0),
                                ),
                              ),
                            ),
                          ),
                          Text("$_personcounter",style:TextStyle(
                            color:Colors.purple,fontSize:17.0,fontWeight:FontWeight.bold,
                          ),
                          ),
                          InkWell(
                            onTap:()
                            {
                              setState(() {
                                _personcounter++;
                              });

                            },
                            child:Container(
                              width:40,
                              height:40,
                              margin:EdgeInsets.all(10.0),
                              decoration:BoxDecoration(
                                border:Border.all(color:Colors.blue.shade500,),
                                color:Colors.purple.withOpacity(0.1),
                                borderRadius:BorderRadius.circular(7.0),
                              ),
                              child:Center(child:Text("+",style:TextStyle(
                                color:Colors.purple,fontWeight:FontWeight.bold,
                                fontSize:17.0,
                              ),
                              ),
                              ),
                            ),

                          )
                        ]
                    )
                  ]
              ),
              SizedBox(height: 20),
              Row(

                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                  children:<Widget>[
                    Text("TIP",style:TextStyle(color:Colors.grey.shade700),
                    ),



                    Row(
                      children:<Widget>[

                        Text("\$ ${(calculatetotaltip(_billamount,_personcounter,_tippercentage)).toStringAsFixed(3)}",style:TextStyle(color:Colors.purple,fontWeight:FontWeight.bold,
                          fontSize:17.0,),
                        ),

                      ],


                    ),
                  ]
              ),

              //slider starting
              Column(
                  children:<Widget>[
                    Text("$_tippercentage%",style:TextStyle(color:Colors.purple,fontSize:17.0,
                      fontWeight:FontWeight.bold,),
                    ),
                    Slider(
                        min:0,//minimum value that slider will show
                        max:100, //maximum value that slider will show
                        activeColor:Colors.purple,//to specify color of slider
                        divisions:10,//to mark divisions on slide bar
                        value:_tippercentage.toDouble(),
                        onChanged:(double newValue){
                          setState(() {//to change value on slider with moving
                            _tippercentage=newValue.round();
                          });
                        })
                  ]
              )


            ]
        )
    );

  }








  calculatetotalperperson(double billamount, int splitby,int tippercentage)
  {
    var totalperperson=(calculatetotaltip(billamount,splitby,tippercentage)+billamount)/splitby;
    return totalperperson.toStringAsFixed(3);//to remove overflow or under flow error. this instruction mean that it will control over flow or underflow till 3 digits
  }
  calculatetotaltip(double billamount,int splitby,int tippercentage)
  {
    double totaltip=0.0;
    if(billamount<0||billamount.toString().isEmpty||billamount==null)
    {
      print("ERROR!! NO BILL");
    }
    else
    {
      totaltip=(billamount*tippercentage)/100;
    }
    return totaltip;
  }
}