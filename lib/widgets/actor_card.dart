import 'package:flutter/material.dart';

class ActorCard extends StatelessWidget {
  final String imagePath;
  final String baseUrl;
  final String name;
  final String character;

  const ActorCard({Key key, this.imagePath, this.baseUrl, this.name, this.character});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 5),
              child: Image.network(
                baseUrl + "w500" + imagePath,
                height: 120,
              ),
            ),
            Text(name),
            Expanded(child: Text("(${character})"))
          ],
        ),
      ),
    );
  }
}
