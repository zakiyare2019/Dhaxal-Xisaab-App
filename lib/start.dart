import 'package:flutter/material.dart';
// import 'package:inheritance/controller/global_state.dart';
// import 'package:inheritance/model/constants/constants.dart';
// import 'package:inheritance/view/forms/child/spouse_0_child_1.dart';

// import 'forms/child/spouse_0_child_0.dart';
// import 'forms/spouse_child/spouse_1_child_1.dart';
// import 'forms/spouse_child/spouse_1_child_0.dart';

// TO-DO: "Please enter name" toaster
class StartPage extends StatefulWidget {
   
   @override
   _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
   //in second sprint we will get them inside the Answer list.
   int answer1 = -1;
   int answer2 = -1;

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       resizeToAvoidBottomInset: false,
       backgroundColor: Colors.red[300],
       appBar: buildAppBar(),
       body: Padding(
         padding: const EdgeInsets.all(16.0),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: (<Widget>[
             Container(
               child: buildQuestion("Heritage name:"),
             ),
             buildSpace(),
             buildTextInput(context),
             buildSpace(),
             buildQuestion("Was the legator married when he died?"),
             buildRadioButton1("Yes", 1, answer1),
             buildRadioButton1("No", 0, answer1),
             buildSpace(),
             buildQuestion(
                 "Did the inheritor have descendants (children, grandchildren, adopted children, etc.)?"),
             buildRadioButton2("Yes", 1, answer2),
             buildRadioButton2("No", 0, answer2),
             buildSpace(),
             buildSpace(),
             Align(
               alignment: Alignment.bottomCenter,
               child: Container(
                 child: SizedBox(
                   height: MediaQuery.of(context).size.height * 0.1,
                   width: MediaQuery.of(context).size.width,
                   child: buildElevatedButton(context, answer1, answer2),
                 ),
               ),
             ),
           ]),
         ),
       ),
     );
   }

   Container buildRadioButton1(String text, int val, int group) {
     return Container(
       width: 150,
       child: Row(
         children: <Widget>[
           Radio(
               value: val,
               groupValue: group,
               onChanged: (value) {
                //  answer1 = value;
                //  GlobalState.instance.answers.hasSpouse = value;
                //  setState(() {});
               }),
           Text(
             text,
             style: TextStyle(fontSize: 16),
           ),
         ],
       ),
     );
   }

   Container buildRadioButton2(String text, int val, int group) {
     return Container(
       width: 150,
       child: Row(
         children: <Widget>[
           Radio(
               value: val,
               groupValue: group,
               onChanged: (value) {
                //  answer2 = value;
                //  GlobalState.instance.answers.hasChild = value;
                //  setState(() {});
               }),
           Text(
             text,
             style: TextStyle(fontSize: 16),
           ),
         ],
       ),
     );
   }

   SizedBox buildSpace() => SizedBox(
         height: 5,
       );

   Container buildTextInput(BuildContext context) {
     return Container(
       height: MediaQuery.of(context).size.height * 0.1,
       child: TextField(
        //  onChanged: (text) {
        //    GlobalState.instance.answers.name = text;
        //  },
         decoration: InputDecoration(
           hintText: "Enter the name of the inheritor...",
           hintStyle: TextStyle(fontWeight: FontWeight.normal),
           border: OutlineInputBorder(
             borderRadius: BorderRadius.circular(10),
           ),
           focusedBorder: OutlineInputBorder(
             borderRadius: BorderRadius.circular(10),
           ),
         ),
       ),
     );
   }

   Text buildQuestion(String text) {
     return Text(
       text,
       style: TextStyle(
         fontSize: 20,
         fontWeight: FontWeight.bold,
         color: Colors.red[300],
       ),
     );
   }

   AppBar buildAppBar() {
     return AppBar(
       title: Text("Inheritance Calculator"),
      //  backgroundColor: AppColors.mainColor,
       actions: <Widget>[
         IconButton(
           icon: Icon(
             //Step: 1
             Icons.looks_one,
             color: Colors.white,
           ),
           onPressed: () {
             //maybe toasting "Step: You are at 1" is a good idea.
           },
         )
       ],
     );
   }
}

Widget buildElevatedButton(BuildContext context, int answer1, int answer2) {
   return ElevatedButton(
     child: Text('NEXT STEP'),
     onPressed: () {
      //  GlobalState.instance.deads[GlobalState.instance.answers.name] =
      //      GlobalState.instance.answers.childCount;
      //  var route;
      //  if (answer1 == 1 && answer2 == 1) {
      //    route = Spouse1Child1();
      //  } else if (answer1 == 1 && answer2 == 0) {route = Spouse1Child0();
      //  } else if (answer1 == 0 && answer2 == 1) {
      //    route = Spouse0Child1();
      //  } else {
      //    route = Spouse0Child0();
      //  }

      //  Navigator.push(
      //    context,
      //    //switch case?
      //   //  MaterialPageRoute(builder: (context) => route),
      //  );
     },
     style: ElevatedButton.styleFrom(
         shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.all(
             Radius.circular(50),
           ),
         ),
         padding: EdgeInsets.symmetric(vertical: 5),
         primary: Colors.white,
         onPrimary: Colors.red[400],
         textStyle:TextStyle(
             color: Colors.red[400],
             fontSize: 20,
             fontWeight: FontWeight.bold)),
   );
}