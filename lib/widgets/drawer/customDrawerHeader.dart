import 'package:flutter/material.dart';

class CustomDrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      height: 90,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          // Icon(
          //   Icons.person,
          //   color: Colors.white,
          //   size: 35,
          // ),
          Image.asset('assets/images/logo.png'),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 10),
              child: Text(
                "Movie App",
                style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 20),
              ),
            ),
          )
        ],
      ),
    );
  }
}
