import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../routes.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                    briefs[index]['technology'],
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_right_alt_rounded,
                    color: Colors.grey[800],
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                              context,
                              Routes.showBrief,
                              arguments: {
                                'title': briefs[index]['title'],
                                'body': briefs[index]['body'],
                                'deadline': briefs[index]['deadline'],
                                'technology': briefs[index]['technology']
                              },
                            );
                  },
                ),
                )
              )
            );
        },
      )),
    );
  }
}
