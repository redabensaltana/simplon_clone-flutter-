import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
import 'package:dio/dio.dart';
import '../routes.dart';

class AddBrief extends StatefulWidget {
  const AddBrief({super.key});

  @override
  State<AddBrief> createState() => _AddBriefState();
}

class _AddBriefState extends State<AddBrief> {
  late int _lastid;

  final _formKey = GlobalKey<FormState>();
  final dio = Dio();
  String _title = "";
  String _body = "";
  String _technology = "";
  DateTime _date = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2010),
      lastDate: DateTime(2100),
    );
    if (selected != null) {
      setState(() {
        _date = selected;
      });
    }
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        _lastid = _lastid + 1;
        await dio.post('http://192.168.10.234:3000/briefs', data: {
          "id": (_lastid).toString(),
          "title": _title,
          "body": _body,
          "technology": _technology,
          "deadline": _date.toString().substring(0, 10)
        });
        Navigator.pushNamed(context, Routes.dashboardBriefs);
        return;
      } catch (e) {
        print(e);
        return;
      }
    }
    // print(_lastid);
    // print(_date.toString());
  }

  @override
  Widget build(BuildContext context) {
    _lastid = (ModalRoute.of(context)?.settings.arguments as int?)!;
    // _lastid = _lastid + 1;
    return Scaffold(
      appBar: AppBar(title: Text('Add brief')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter your email title.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _title = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Body'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter your body.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _body = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Technology'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter your technologies.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _technology = value!;
                },
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 30),
                  Text(
                    'Selected date: ' + _date.toString().substring(0, 10),
                    style: TextStyle(fontSize: 15),
                  ),
                  ElevatedButton(
                    onPressed: () => _selectDate(context),
                    child: Icon(Icons.date_range_rounded),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                child: Text('add'),
                onPressed: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
