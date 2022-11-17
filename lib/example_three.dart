import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:user_api/Models/UserModel.dart';

class ExampleThree extends StatefulWidget {
  const ExampleThree({Key? key}) : super(key: key);

  @override
  State<ExampleThree> createState() => _ExampleThreeState();
}

class _ExampleThreeState extends State<ExampleThree> {
List<UserModel> userlist =[];
Future<List<UserModel>> getUseApi () async{
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
   var data =jsonDecode(response.body.toString());
   if(response.statusCode==200){
     for(Map i in data){
       userlist.add(UserModel.fromJson(i));
     }
     return userlist;
   }

   else{
     return userlist;
   }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
    body: FutureBuilder(
      future: getUseApi(),
        builder: (context,AsyncSnapshot<List<UserModel>> snapshot){
        if(!snapshot.hasData){
          return CircularProgressIndicator();
        }
        else{
          return ListView.builder(
              itemCount: userlist.length,
              itemBuilder: (context,index){
                return Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  elevation: 2,

                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        ReusableRow(title:'Name' ,value : snapshot.data![index].name.toString(), ),
                        ReusableRow(title:'UserName' ,value : snapshot.data![index].username.toString(), ),
                        ReusableRow(title:'Email' ,value : snapshot.data![index].email.toString(), ),
                        ReusableRow(title:'Address' ,value : snapshot.data![index].address!.geo!.lat.toString() ),


                      ],
                    ),
                  ),
                );
              });
        }
        }),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String title ,value;
  ReusableRow({Key? key,required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value),
        ],
      ),
    ) ;
  }
}
