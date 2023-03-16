import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../routes.dart';

class DashboardBriefsPage extends StatefulWidget {
  const DashboardBriefsPage({super.key});

  @override
  State<DashboardBriefsPage> createState() => _DashboardBriefsPageState();
}

class _DashboardBriefsPageState extends State<DashboardBriefsPage> {
  final dio = Dio();

  List<dynamic> briefs = [];

  Future<void> fetchData() async {
    try {
      final response = await dio.get('http://192.168.10.234:3000/briefs');
      setState(() {
        briefs = response.data;
      });
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
      appBar: AppBar(title: Text('My briefs')),
      body: Center(
          child: ListView.builder(
        itemCount: briefs.length,
        itemBuilder: (BuildContext context, int index) {
          return SizedBox(
              height: 110,
              child: Card(
                elevation: 4,
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Center(
                  child: ListTile(
                  title: Text(
                    briefs[index]['title'] +
                                    '  (' +
                                    briefs[index]['deadline'] + ')',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Text(
                    briefs[index]['body'],
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  trailing: Icon(
                    Icons.book_rounded,
                    color: Colors.grey[800],
                  ),
                  onTap: () {
                    // handle onTap event
                  },
                ),
                )
                
              )
            );
        },
      )),
      floatingActionButton: Row(
        children: [
          Icon(Icons.add),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.addBrief, arguments: briefs.length);
            },
            child: Row(
              children: [
                SizedBox(
                    width: 8), // add some spacing between the icon and text
                Text('add brief'),
                Icon(Icons.add),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
