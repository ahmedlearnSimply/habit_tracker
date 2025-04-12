import 'package:flutter/material.dart';
import 'package:habit_tracker/core/services/localStorage/AppLocalStorage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(AppLocalStorage.getCachedData(key: AppLocalStorage.kUserName)),
      ),
    );
  }
}
