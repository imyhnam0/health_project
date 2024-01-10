import 'package:flutter/material.dart';

class FriendsMenu extends StatelessWidget{
  const FriendsMenu({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(  
      appBar: AppBar(
        title: Text('Friends'),
      ),
      body: Center(
        child: Text('Friends'),
      ),
    );
  }
}