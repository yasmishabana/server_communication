import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:server_communication/direct_call/direct_with_api/category_product.dart';
import 'package:server_communication/direct_call/model/listdatamodel.dart';

class DirectListExample extends StatelessWidget {
  // List<Listmodel> lst = [
  //   Listmodel(
  //       title: "Cyra",
  //       description: "Cyra learnings",
  //       image: "assets/images/download.jpg",
  //       icon: Icons.add),
  //   Listmodel(
  //       title: "Flutter",
  //       description: "Flutter framework",
  //       image: "assets/images/download.jpg",
  //       icon: Icons.add),
  //   Listmodel(
  //       title: "Dart",
  //       description: "Dart programming language",
  //       image: "assets/images/download.jpg",
  //       icon: Icons.add)
  // ]

  // Future<List<ListdataModel>> fetchlistData() async {
  //   try{
  //   log("fetchlistData = " );
  //   final response = await http.get(
  //       Uri.parse('http://192.168.245.32:8080/TestProject/getCategory.jsp'));
  //         log(response.statusCode.toString());
  //   if (response.statusCode == 200) {
  //     final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
  //     log("parsed===="+parsed);
  //     return parsed
  //         .map<ListdataModel>((json) => ListdataModel.fromJson(json))
  //         .toList();
  //   } else {
  //     throw Exception('Failed to load album');
  //   }
  //   }catch(Exception ){

  //   }
  // }
  Future<List<ListdataModel>> fetchlistData() async {
    try {
      log("fetchListData called");
      final response = await http.get(
          Uri.parse('http://192.168.245.32:8080/TestProject/getCategory.jsp'));

      log("Response status: ${response.statusCode}");

      if (response.statusCode == 200) {
        final List<dynamic> parsed = json.decode(response.body);
        log("Parsed data: $parsed");

        return parsed
            .map<ListdataModel>((json) => ListdataModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      log("Error: $e");
      throw Exception('Failed to fetch data: $e');
    }
  }
  //  @override
  // void initState() {

  //  fetchlistData();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "List Api Example",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: FutureBuilder<List<ListdataModel>>(
        future: fetchlistData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            log("length == ${snapshot.data!.length}");
            return ListView.builder(
                itemCount: snapshot.data!.length,
                // lst.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      // height: 100,
                      color: const Color.fromARGB(86, 180, 136, 255),
                      child: Center(
                          child: ListTile(
                        title: Text(
                          // lst[index].title
                          snapshot.data![index].title.toString(),
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          // lst[index].description
                          snapshot.data![index].description.toString(),
                        ),
                        trailing: const Icon(
                          // lst[index].icon
                          Icons.add,
                        ),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return CateProduct(
                                catid: snapshot.data![index].id!);
                          }));
                          // Navigator.push(context, MaterialPageRoute(
                          //   builder: (context) {
                          //     return ItemDetailsPage(
                          //       id: snapshot.data![index].id!,
                          //       itemname: snapshot.data![index].title!,
                          //       image:snapshot.data![index].image!,
                          //       description: snapshot.data![index].description!,
                          //     );
                          //   },
                          // ));
                        },
                        leading: CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.red,
                          backgroundImage: NetworkImage(
                              // lst[index].image,
                              "http://192.168.245.32:8080/TestProject/image/${snapshot.data![index].image!}"
                              // "assets/images/download.jpg",
                              ),
                        ),
                      )),
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

class Listmodel {
  String title;
  String description;
  String image;
  IconData icon;
  Listmodel(
      {required this.title,
      required this.description,
      required this.image,
      required this.icon});
}
