import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'dart:convert';

class Digimon extends StatelessWidget {
  final String apiUrl = "https://digimon-api.vercel.app/api/digimon";

  const Digimon({super.key});

  Future<List<dynamic>> _fecthListQuotes() async {
    var result = await http.get(Uri.parse(apiUrl));
    return json.decode(result.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Digimon List'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _fecthListQuotes(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                          radius: 50.0,
                          backgroundColor: Colors.black,
                          child: CircleAvatar(
                            backgroundImage:
                                NetworkImage(snapshot.data[index]['img']),
                            backgroundColor: Colors.blue,
                            radius: 30.0,
                          )),
                      title: Text(
                        snapshot.data[index]['name'],
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        // ignore: prefer_interpolation_to_compose_strings
                        snapshot.data[index]['level'],
                        style: const TextStyle(fontStyle: FontStyle.italic),
                      ),
                      trailing: Flexible(
                        child: SizedBox(
                          width: 120,
                        ),
                      ),
                    ),
                  );
                });
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
