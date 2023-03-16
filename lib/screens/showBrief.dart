import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ShowBriefPage extends StatefulWidget {
  const ShowBriefPage({super.key});

  @override
  State<ShowBriefPage> createState() => _ShowBriefPageState();
}

class _ShowBriefPageState extends State<ShowBriefPage> {
  String _title = "";
  String _body = "";
  String _deadline = "";
  String _technology = "";

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
    _title = arguments['title'];
    _body = arguments['body'];
    _deadline = arguments['deadline'];
    _technology = arguments['technology'];

    return Scaffold(
        appBar: AppBar(title: Text(_title)),
        body: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("images/project-task-list.jpg"),
              SizedBox(height: 15),
              Container(
                padding: EdgeInsets.all(30),
                child: Column(
                  children: [
                    Text(
                      _title,
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      _body,
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(212, 192, 237, 1),
                          borderRadius: BorderRadius.circular(
                              10.0), // Add border radius here
                        ),
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Text(
                              "Deadline: $_deadline",
                              style: TextStyle(fontSize: 14.0),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              "Technology: $_technology",
                              style: TextStyle(fontSize: 14.0),
                            ),
                          ],
                        ))
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
