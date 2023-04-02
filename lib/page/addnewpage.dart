import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sub_mgmt/main.dart';
import 'package:sub_mgmt/page/model/user.dart';
import 'package:sub_mgmt/page/sortablepage.dart';

class AddNewPage extends StatefulWidget {
  const AddNewPage({Key? key}) : super(key: key);

  @override
  State<AddNewPage> createState() => _AddNewPageState();
}

class _AddNewPageState extends State<AddNewPage> {
  final controllerName = TextEditingController();
  final controllerPhone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 8,
          toolbarHeight: 70,
          title: Text(
            "Add New",
            style: TextStyle(
                fontFamily: GoogleFonts.rubik().fontFamily,
                ),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                gradient: LinearGradient(
                    colors: [Colors.blue, Colors.blueAccent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter
                ),
            ),
          ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: <Widget>[
          TextField(
            controller: controllerName,
            decoration: decoration('Name'),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: controllerPhone,
            decoration: decoration('Phone'),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
              child: Text('Create'),
              onPressed: () {
                final user = User(
                  name: controllerName.text,
                  phone: int.parse(controllerPhone.text)
                );
                MemberListState.counter=0;
                createUser(user);
                Navigator.pop(context);
              }
          )
        ],
      ),
    );
  }
  
  InputDecoration decoration(String label) => InputDecoration(
    labelText: label,
    border: OutlineInputBorder(),
  );
  Future createUser(User user) async {
    final docUser = FirebaseFirestore.instance.collection('users').doc();

    final json = user.toJson();
    await docUser.set(json);
  }

  // Future createUser({required String name}) async {
  //   final docUser = FirebaseFirestore.instance.collection('users').doc();
  //
  //   final user = User(
  //     id: docUser.id,
  //     sr: 10,
  //     fullName: name,
  //     phoneNumber: 9237461,
  //   );
  //   final json = user.toJson();
  //
  //   await docUser.set(json);
  // }
}
