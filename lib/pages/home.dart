import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../modules/logout/logout_cubit.dart';
import '../widgets/logout_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //int? _id;
  String? _name;
  // String? _phone;
  // String? _email;
  String? _token;

  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        //_id = pref.getInt('id');
        _name = prefs.getString('name');
        _token = prefs.getString('token');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () {
              context.read<LogoutCubit>().logout('$_token');
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Text('ID: $_id'),
            Text('Name: $_name'),
            Text('Token: $_token'),
          ],
        ),
      ),
    );

  }
}
