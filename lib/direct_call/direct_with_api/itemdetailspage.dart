import 'dart:developer';
import 'package:flutter/material.dart';

class ItemDetailsPage extends StatefulWidget {
  String id;
  String itemname;
  String description;
  String image;
  ItemDetailsPage({required this.id, required this.itemname,required this.description,required this.image});

  @override
  State<ItemDetailsPage> createState() => _ItemDetailsPageState();
}

class _ItemDetailsPageState extends State<ItemDetailsPage> {

  // Future<MapdataModel> fetchAlbum(int itemid) async {
  //   final response = await http.post(
  //       Uri.parse('http://192.168.29.72:8080/fluttercodeexample/mapdata.jsp'),
  //       body: {"itemid": itemid.toString()});
  //   if (response.statusCode == 200) {
  //     return MapdataModel.fromJson(
  //         jsonDecode(response.body) as Map<String, dynamic>);
  //   } else {
  //     throw Exception('Failed to load album');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    log("id == " + widget.id.toString());
    log("itemname = " + widget.itemname.toString());
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
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
         // child: FutureBuilder<MapdataModel>(
          //  future: fetchAlbum(id),
           // builder: (context, snapshot) {
            //  if (snapshot.hasData) {
                child:  Column(
                  children: [
                    Container(
                      height:MediaQuery.of(context).size.width/1.5,
                      decoration: BoxDecoration(image: DecorationImage(image:NetworkImage("http://192.168.245.32:8080/TestProject/image/" +widget.image ),fit:BoxFit.fill 
                      )),
                    ),
                    SizedBox(height: 20,),
                    Text(
                      // "Item Details",
                      widget.itemname,
                      style: const TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.description,
                        // "A laptop, sometimes called a notebook computer by manufacturers, is a battery- or AC-powered personal computer (PC) smaller than a briefcase. A laptop can be easily transported and used in temporary spaces such as on airplanes, in libraries, temporary offices and at meetings.",
                      ),
                    )
                  ],
                ),
             // } 
//  (snapshot.hasError) {
//                 return Text('${snapshot.error}');
//               }
//  CircularProgressIndicator(
//                 color: Colors.purple,
//               );},
//           ),
        ),
      )),
    );
  }
}
