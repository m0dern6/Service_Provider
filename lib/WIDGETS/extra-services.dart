import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExtraService extends StatelessWidget {
  const ExtraService({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchExtraServices(),
        builder: (context, AsyncSnapshot services) {
          if (services.hasData) {
            return SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children:
                        List<Widget>.generate(services.data.length, (index) {
                      return Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.green),
                            borderRadius: BorderRadius.circular(25)),
                        child: Text(
                          services.data[index]['name']['first'] +
                              ' ' +
                              services.data[index]['name']['last'],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      );
                    })),
              ),
            );
          } else if (services.hasError) {
            return SliverFillRemaining(
              child: Center(
                child: Text('Error: ${services.error}'),
              ),
            );
          } else if (services.connectionState == ConnectionState.waiting) {
            return const SliverFillRemaining(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return const SliverFillRemaining(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }

  Future<List<dynamic>> fetchExtraServices() async {
    final response =
        await http.get(Uri.parse('https://randomuser.me/api/?results=19'));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return data['results'];
    } else {
      throw Exception('Failed to load extra services services');
    }
  }
}
