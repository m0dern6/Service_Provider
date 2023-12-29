import 'package:flutter/material.dart';

class Searching extends StatelessWidget {
  const Searching({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      margin: const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'I need help with',
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 15,
          ),
          TextField(
            decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 5),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
                labelText: 'Enter your search term',
                labelStyle: const TextStyle(fontSize: 15),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.green,
                  size: 20,
                )),
          ),
        ],
      ),
    );
  }
}
