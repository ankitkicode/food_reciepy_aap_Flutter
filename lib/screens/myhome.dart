// ignore_for_file: prefer_const_constructors, avoid_print, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, unused_local_variable, empty_statements, non_constant_identifier_names, avoid_function_literals_in_foreach_calls, sort_child_properties_last

// import 'dart:developer';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:food_reciepy/screens/model.dart';
import 'package:food_reciepy/screens/recipyview.dart';
import 'package:food_reciepy/screens/search_page.dart';
import 'package:http/http.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

/// This is a stateful widget that returns a scaffold with a centered text widget saying "welcome".
class _MyHomeState extends State<MyHome> {
  List<RecipeModel> recipeList = <RecipeModel>[];
  bool isLoading = true;

  TextEditingController newSearch = TextEditingController();

// GetResponse

  getResponse(String query) async {
    String url =
        "https://api.edamam.com/search?q=$query&app_id=ba64995d&app_key=4a452c2f1ea06f6c0c11d89e9905513f";

// response dene ke liye code

    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);
    // log(data.toString());

    data["hits"].forEach((element) {
      RecipeModel recipeModel = RecipeModel();
      recipeModel = RecipeModel.fromMap(element["recipe"]);
      recipeList.add(recipeModel);
      setState(() {
        isLoading = false;
      });

      // log(recipeList.toString());
    });

// fatch karne ke liye data code

    recipeList.forEach((Recipe) {
      print(Recipe.applable);
      print(Recipe.appcalories);
      print(Recipe.appShareurl);
      print("object");
    });
  }

  @override
  void initState() {
    super.initState();
    getResponse("Chicken");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromARGB(255, 182, 200, 218),
            Color.fromARGB(255, 219, 162, 54)
          ])),
        ),
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 55,
                padding: EdgeInsets.symmetric(vertical: 3, horizontal: 20),
                margin: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Color.fromARGB(153, 58, 101, 194)),
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                      controller: newSearch,
                      style: TextStyle(fontSize: 18, color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Search Any Recipe Name..",
                        border: InputBorder.none,
                        fillColor: Colors.blue,
                        hintStyle: TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 248, 245, 245)),
                      ),
                    )),
                    GestureDetector(
                      onTap: () {
                        if ((newSearch.text.isEmpty)) {
                          print("blank");
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      SearchPage(newSearch.text)));
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.search_rounded,
                          size: 30,
                          color: Color.fromARGB(255, 237, 240, 240),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "What do you went to cook today?",
                        style: TextStyle(
                            fontSize: 25,
                            color: const Color.fromARGB(255, 43, 42, 42),
                            fontFamily: "monument",
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        " let's cook somthing new!",
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: "monument",
                            color: const Color.fromARGB(255, 116, 114, 114)),
                      ),
                    ],
                  )),
              Container(
                child: isLoading
                    ? CircularProgressIndicator(
                        color: Colors.red,
                      )
                    : ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: recipeList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(context,MaterialPageRoute(builder: (context)=>RecipyView(recipeList[index].appurl)));
                            },
                            child: Card(
                              margin: EdgeInsets.all(10),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      recipeList[index].appImageurl,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: 250,
                                    ),
                                  ),
                                  Positioned(
                                      left: 0,
                                      right: 0,
                                      bottom: 0,
                                      child: Container(
                                          decoration: BoxDecoration(
                                              color:
                                                  Color.fromARGB(141, 0, 0, 0)),
                                          padding: EdgeInsets.all(10),
                                          child: Text(
                                            recipeList[index].applable,
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                            ),
                                          ))),
                                  Positioned(
                                      right: 0,
                                      width: 120,
                                      height: 50,
                                      child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(10),
                                                  bottomLeft:
                                                      Radius.circular(10)),
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255)),
                                          padding: EdgeInsets.all(10),
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons
                                                    .local_fire_department),
                                                Text(
                                                  recipeList[index]
                                                      .appcalories
                                                      .toString()
                                                      .substring(0, 6),
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    color: Color.fromARGB(
                                                        255, 0, 0, 0),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )))
                                ],
                              ),
                              elevation: 0.0,
                            ),
                          );
                        }),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
