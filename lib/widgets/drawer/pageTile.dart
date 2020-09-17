import 'package:flutter/material.dart';

class PageTile extends StatelessWidget {
  final String label;
  final IconData iconData;
  final VoidCallback onTap;
  final bool highlighted;

  const PageTile({Key key, this.label, this.iconData, this.onTap, this.highlighted});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          Icon(
            iconData,
            color: highlighted ? Theme.of(context).primaryColor : Colors.black54,
          ),
          Container(
            margin: EdgeInsets.only(left: 12),
            child: Text(
              label,
              style: TextStyle(color: highlighted ? Theme.of(context).primaryColor : Colors.black54),
            ),
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}
