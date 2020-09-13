import 'package:flutter/material.dart';
import 'package:movie_app/widgets/customDrawerHeader.dart';
import 'package:movie_app/widgets/pageSection.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          CustomDrawerHeader(),
          PageSection(),
        ],
      ),
    );
  }
}
