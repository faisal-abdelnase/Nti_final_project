import 'package:flutter/material.dart';
import 'package:nti_final_project/core/widgets/custom_top_appbar.dart';
import 'package:nti_final_project/core/widgets/custom_bottom_navbar.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomTopAppBar(),
      bottomNavigationBar: CustomBottomNavBar(),
      body: Column(children: [Text('Chats Screen')]),
    );
  }
}
