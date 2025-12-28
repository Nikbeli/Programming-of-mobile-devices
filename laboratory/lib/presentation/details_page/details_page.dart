import 'package:pmd/components/extensions/local_context_x.dart';
import 'package:pmd/models/card_data.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final CardData data;

  const DetailsPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('House ${data.name}'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.network(
                  data.image,
                  height: 250,
                  width: 250,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "${context.locale.detailsTitle} ${data.name}",
              style: const TextStyle(fontSize: 20, color: Colors.blue),
            ),
            Text(
              "${context.locale.detailsLocation}: ${data.location}.",
              style: TextStyle(fontSize: 18),
            ),
            Text(
              "${context.locale.detailsDescription}: ${data.description}.",
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
