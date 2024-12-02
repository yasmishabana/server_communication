import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:server_communication/direct_call/direct_with_api/itemdetailspage.dart';
import 'package:server_communication/direct_call/model/catproductmodel.dart';
import 'package:http/http.dart' as http;

class CateProduct extends StatefulWidget {
  int catid;

  CateProduct({required this.catid});

  @override
  State<CateProduct> createState() => _ItemDetailsPageState();
}

class _ItemDetailsPageState extends State<CateProduct> {
  // Future<List<CategoryProductModel>> fetchCatProduuct(int itemid) async {
  //   final response = await http.post(

  //       Uri.parse(' http://192.168.245.32:8080/TestProject/getproduct.jsp'),
  //       body: {"itemid": itemid.toString()});
  //   if (response.statusCode == 200) {
  //     return CategoryProductModel.fromJson(
  //         jsonDecode(response.body) as Map<String, dynamic>);
  //   } else {
  //     throw Exception('Failed to load album');
  //   }
  // }

  Future<List<CategoryProductModel>> fetchCatProduct(int itemid) async {
    log("itemid===========${widget.catid}");
    try {
      log("fetchCatProduct called");
      final response = await http.post(
          Uri.parse('http://192.168.245.32:8080/TestProject/getproduct.jsp'),
          body: {"itemid": itemid.toString()});

      log("Response status: ${response.statusCode}");

      if (response.statusCode == 200) {
        final List<dynamic> parsed = json.decode(response.body);
        log("Parsed data: $parsed");

        return parsed
            .map<CategoryProductModel>(
                (json) => CategoryProductModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      log("Error: $e");
      throw Exception('Failed to fetch data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    log("id == ${widget.catid}");
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Item Details",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: FutureBuilder<List<CategoryProductModel>>(
        future: fetchCatProduct(widget.catid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            log("length == ${snapshot.data!.length}");
            return GridView.builder(
              // ignore: prefer_const_constructors
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              
                crossAxisCount: 2, // number of items in each row
                mainAxisSpacing: 4.0, // spacing between rows
                crossAxisSpacing: 2.0, // spacing between columns

              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (_, index) => Container(
             //  height: 400,
                margin:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                //  padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                 // color: const Color(0xff97FFFF),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return ItemDetailsPage(
                                id: snapshot.data![index].id,
                                itemname: snapshot.data![index].title,
                                image:snapshot.data![index].image,
                                description: snapshot.data![index].description,
                              );
                            },
                          ));
                  },
                  child: Column(
                    children: [
                      Container(
                        height: 150,
                        width: 240,
                        decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                                image: NetworkImage(
                                    "http://192.168.245.32:8080/TestProject/image/${snapshot.data![index].image}"),
                                fit: BoxFit.fill)),
                      ),
                     // SizedBox(height: 4,),
                      Text(
                        snapshot.data![index].title,
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Text(snapshot.data![index].description),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),

      //body:
      //  FutureBuilder<MapdataModel>(
      //       future: fetchAlbum(widget.catid),
      //       builder: (context, snapshot) {
      //         if (snapshot.hasData) {

      //            return:   ListView.builder(
      //          itemCount: snapshot.data!.length,
      //          itemBuilder: (_, index) => Container(
      //            child: Container(
      //       margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      //       padding: const EdgeInsets.all(20.0),
      //       decoration: BoxDecoration(
      //  color: const Color(0xff97FFFF),
      //  borderRadius: BorderRadius.circular(15.0),
      //       ),
      //       child: Column(
      //  mainAxisAlignment: MainAxisAlignment.start,
      //  crossAxisAlignment: CrossAxisAlignment.start,
      //  children: [
      //    Text(
      //      snapshot.data![index].title,
      //      style: const TextStyle(
      //        fontSize: 18.0,
      //        fontWeight: FontWeight.bold,
      //      ),
      //    ),
      //    const SizedBox(height: 10),
      //    Text(snapshot.data![index].body),
      //  ],
      //       ),
      //            ),
      //          ),
      //        );
      // Column(
      //   children: [
      //     Container(
      //       height:MediaQuery.of(context).size.width/1.5,
      //       decoration: BoxDecoration(image: DecorationImage(image:NetworkImage("http://192.168.245.32:8080/TestProject/image/" +widget.image ),fit:BoxFit.fill
      //       )),
      //     ),
      //     SizedBox(height: 20,),
      //     Text(
      //       // "Item Details",
      //       widget.itemname,
      //       style: const TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.bold),
      //     ),
      //     const SizedBox(
      //       height: 10,
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: Text(
      //         widget.description,
      //         // "A laptop, sometimes called a notebook computer by manufacturers, is a battery- or AC-powered personal computer (PC) smaller than a briefcase. A laptop can be easily transported and used in temporary spaces such as on airplanes, in libraries, temporary offices and at meetings.",
      //       ),
      //     )
      //   ],
      // );
      //  }
      //  (snapshot.hasError) {
      //                 return Text('${snapshot.error}');
      //  } CircularProgressIndicator(
      //                 color: Colors.purple,
      //               );},
    );
  }
}
