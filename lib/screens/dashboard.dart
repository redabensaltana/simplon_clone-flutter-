import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../routes.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final dio = Dio();

  List<dynamic> students = [];

  Future<void> fetchData() async {
    try {
      final response = await dio.get('http://192.168.10.234:3000/users');
      var data =
          response.data.where((user) => user['role'] == 'student').toList();
      setState(() {
        students = data;
      });
      print(students);
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My students: ' + students.length.toString())),
      body: Center(
          child: Padding(
              padding: EdgeInsets.only(top: 20),
              child: ListView.builder(
                itemCount: students.length,
                itemBuilder: (BuildContext context, int index) {
                  return SizedBox(
                      height: 110,
                      child: Card(
                          elevation: 4,
                          margin:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Center(
                            child: ListTile(
                              title: Text(
                                students[index]['email'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              subtitle: Text(
                                students[index]['fname'] +
                                    ' ' +
                                    students[index]['lname'],
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              trailing: Icon(
                                Icons.man,
                                color: Colors.grey[800],
                              ),
                              onTap: () {
                                // handle onTap event
                              },
                            ),
                          )));
                },
              ))),
      floatingActionButton: Row(
        children: [
          Icon(Icons.add),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.dashboardBriefs);
            },
            child: Row(
              children: [
                SizedBox(
                    width: 8), // add some spacing between the icon and text
                Text('show briefs'),
                Icon(Icons.book),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
