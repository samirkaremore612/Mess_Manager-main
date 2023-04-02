import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sub_mgmt/widget/navigation_drawer.dart';
import 'package:intl/intl.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

import '../globals.dart';

class NotifsPage extends StatefulWidget {
  const NotifsPage({Key? key}) : super(key: key);

  @override
  State<NotifsPage> createState() => _NotifsPageState();
}

class _NotifsPageState extends State<NotifsPage> {


  final df = new DateFormat('dd-MM-yyyy');

  @override
  Widget build(BuildContext context) {

    print(df.format(DateTime.now()));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(

        drawer: NavigationDrawerWidget(),
        body:PaginateFirestore(
          query:FirebaseFirestore.instance.collection("users").where('Expiry Date',isEqualTo: '${df.format(DateTime.now())}'),
          itemBuilderType:PaginateBuilderType.listView ,

          itemBuilder:(context, dynamic ds, int index){
            return Padding(
              padding: const EdgeInsets.fromLTRB(10,20 , 10, 10),
              child: Container(
                height: 50,
                child: Card(
                  shadowColor: Colors.white,
                  elevation: 40,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                        Text("${ds[index]['Name']}",style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold),),

                      ],
                    ),
                  ),
                ),
              ),
            );
          } ,
        )
      ),
    );
  }
}