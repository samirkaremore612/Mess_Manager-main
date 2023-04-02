import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sub_mgmt/page/addnewpage.dart';
import 'package:sub_mgmt/page/data/users.dart';
import 'package:sub_mgmt/page/model/user.dart';

import 'editpage.dart';

class MemberList extends StatefulWidget {
  const MemberList({Key? key}) : super(key: key);

  @override
  State<MemberList> createState() => MemberListState();
}

class MemberListState extends State<MemberList> {
  // Sorting functionalities
  // late List<User> users;
  // int? sortColumnIndex;
  // bool isAscending = false;
  static int counter = 1;

  // Reading data from firebase
  CollectionReference _referenceMembers =
      FirebaseFirestore.instance.collection('users');
  late Stream<QuerySnapshot> _streamMembers;
  List<int> selectedIndex = [];
  List<String> selectedDocID = [];

  @override
  void initState() {
    super.initState();
    // users = List.of(allUsers);
    _streamMembers = _referenceMembers.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: _streamMembers,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }

            if (snapshot.connectionState == ConnectionState.active) {
              QuerySnapshot querySnapshot = snapshot.data;
              List<QueryDocumentSnapshot> listQueryDocumentSnapshot =
                  querySnapshot.docs;
              counter = 0;
              return ScrollableWidget(
                child: Column(
                  children: [
                    DataTable(
                      columns: const [
                        DataColumn(
                          label: Text(
                            'Sr',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Name',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Phone',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            '',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                      rows: listQueryDocumentSnapshot
                          .map((element) => DataRow(
                                selected: selectedDocID.contains(element.id),
                                // selected: selectedIndex.contains(listQueryDocumentSnapshot.indexOf(element)),
                                onSelectChanged: (isSelected) => setState(() {
                                  final isAdding =
                                      isSelected != null && isSelected;

                                  // isAdding ? selectedIndex.add(listQueryDocumentSnapshot.indexOf(element))
                                  //     : selectedIndex.remove(listQueryDocumentSnapshot.indexOf(element));
                                  if (isAdding) {
                                    // selectedIndex.add(listQueryDocumentSnapshot.indexOf(element));
                                    selectedDocID.add(element.id);
                                  } else {
                                    // selectedIndex.remove(listQueryDocumentSnapshot.indexOf(element));
                                    selectedDocID.remove(element.id);
                                  }
                                }),
                                cells: <DataCell>[
                                  DataCell(Text((++counter).toString())),
                                  DataCell(Text(element['Name'])),
                                  DataCell(Text(element['Phone'].toString())),
                                  DataCell(IconButton(
                                    splashRadius: 22,
                                    color: Colors.black38,
                                    icon: Icon(Icons.edit),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => EditPage(
                                                  element.id,
                                                  element['Name'],
                                                  element['Phone'])));
                                    },
                                  ))
                                ],
                              ))
                          .toList(),
                      columnSpacing: 52,
                    ),
                    SizedBox(height: 80),
                  ],
                ),
              );
            }

            return Center(child: CircularProgressIndicator());
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: FloatingActionButton(
                onPressed: () {
                  if (selectedDocID.isNotEmpty) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Delete"),
                            content: Text("Delete Data?"),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("No")),
                              TextButton(
                                  onPressed: () {
                                    for (var i in selectedDocID) {
                                      final docUser = FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(i);
                                      docUser.delete();
                                    }
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Yes"))
                            ],
                          );
                        });
                  }
                },
                tooltip: 'Delete',
                elevation: 4.0,
                child: Icon(Icons.delete),
              ),
            ),
            FloatingActionButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddNewPage()));
              },
              tooltip: 'Add',
              elevation: 4.0,
              child: Icon(Icons.add),
            )
          ],
        ),
      ),
    );
  }

  // IGNORE
  // Widget buildDataTable() {
  //   final columns = ['Sr', 'Full Name', 'Phone Number'];
  //   return DataTable(
  //     sortAscending: isAscending,
  //     columns: getColumns(columns),
  //     rows: getRows(users),
  //     sortColumnIndex: sortColumnIndex,
  //   );
  // }
  //
  // List<DataColumn> getColumns(List<String> columns) => columns
  //     .map((String column) => DataColumn(
  //           label: Text(column,
  //               style: TextStyle(
  //                 fontWeight: FontWeight.bold,
  //               )),
  //           onSort: onSort,
  //         ))
  //     .toList();
  //
  // List<DataRow> getRows(List<User> users) => users.map((User user) {
  //       final cells = [user.sr, user.fullName, user.phoneNumber];
  //       return DataRow(
  //           cells: getCells(cells),
  //       );
  //     }).toList();
  //
  // List<DataCell> getCells(List<dynamic> cells) =>
  //     cells.map((data) => DataCell(
  //         Text('$data'),
  //       showEditIcon: true,
  //     ),
  //     ).toList();
  //
  // void onSort(int columnIndex, bool ascending) {
  //   if (columnIndex == 0){
  //     users.sort((user1, user2) =>
  //     compareNum(ascending, user1.sr, user2.sr));
  //   }
  //   else if(columnIndex == 1){
  //     users.sort((user1, user2) =>
  //         compareString(ascending, user1.fullName, user2.fullName));
  //   } else if(columnIndex == 2){
  //     users.sort((user1, user2) =>
  //         compareString(ascending, '${user1.phoneNumber}', '${user2.phoneNumber}'));
  //   }
  //
  //
  //   setState(() {
  //     sortColumnIndex = columnIndex;
  //     isAscending = ascending;
  //   });
  // }
  //
  // int compareString(bool ascending, String value1, String value2) =>
  //     ascending ? value1.compareTo(value2) : value2.compareTo(value1);
  //
  // int compareNum(bool ascending, int value1, int value2) =>
  //     ascending ? value1.compareTo(value2) : value2.compareTo(value1);
}

class ScrollableWidget extends StatelessWidget {
  final Widget child;
  const ScrollableWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: child,
      ),
    );
  }
}
