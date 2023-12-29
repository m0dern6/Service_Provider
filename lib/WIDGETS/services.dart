import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Service extends StatelessWidget {
  const Service({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
        future: fetchServices(),
        builder: (BuildContext context, AsyncSnapshot service) {
          if (service.hasData) {
            return SliverPadding(
              padding: const EdgeInsets.all(5.0),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    double screenWidth = MediaQuery.of(context).size.width;
                    double itemWidth = (screenWidth / 3);

                    return Container(
                      decoration: BoxDecoration(shape: BoxShape.rectangle),
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        children: [
                          Expanded(
                            child: AspectRatio(
                              aspectRatio: 16 / 9,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: CachedNetworkImage(
                                  width: itemWidth,
                                  fit: BoxFit.cover,
                                  imageUrl: service.data![index]['urls']
                                      ['small'],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Text(
                              service.data![index]['user']['name'],
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  childCount: service.data!.length,
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 0,
                ),
              ),
            );
          } else if (service.hasError) {
            return SliverFillRemaining(
              child: Center(
                child: Text('Error: ${service.error}'),
              ),
            );
          } else if (service.connectionState == ConnectionState.waiting) {
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

  Future<List<dynamic>> fetchServices() async {
    final response = await http.get(Uri.parse(
        'https://api.unsplash.com/photos/random?count=9&client_id=qYp9LDiGNOswHM-SPsAwkzf6kQSxyapKFKNDRIqhrL4'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load services');
    }
  }
}
