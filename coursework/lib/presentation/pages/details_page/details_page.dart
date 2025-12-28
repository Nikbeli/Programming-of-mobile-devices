import 'package:candystore/components/extensions/local_context_x.dart';
import 'package:candystore/models/card_data.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final CardData data;

  const DetailsPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sweet ${data.name}')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.network(
                  data.imageUrl,
                  height: 250,
                  width: 250,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text("${context.locale.titleCard}:  ${data.name}",
                style: const TextStyle(fontSize: 24, color: Colors.blue)),
            Text("${context.locale.descriptionCard}:  ${data.description}",
                style: const TextStyle(fontSize: 18, color: Colors.red)),
            Text("${context.locale.manufacturer}: ${data.manufacturer}",
                style: const TextStyle(fontSize: 18, color: Colors.orangeAccent)),
          ],
        ),
      ),
    );
  }
}
