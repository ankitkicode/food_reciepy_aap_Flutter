// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls, non_constant_identifier_names, prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_reciepy/screens/recipyview.dart';
import 'package:http/http.dart';

import 'model.dart';

class SearchPage extends StatefulWidget {
  String quary;
  SearchPage(this.quary);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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
    getResponse(widget.quary);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
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
                    color: Colors.white60),
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                      controller: newSearch,
                      style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 53, 52, 52)),
                      decoration: InputDecoration(
                        hintText: "Search Any City Name..",
                        border: InputBorder.none,
                        fillColor: Colors.blue,
                        hintStyle: TextStyle(fontSize: 18, color: Color.fromARGB(255, 43, 42, 42)),
                      ),
                    )),
                    GestureDetector(
                      onTap: () {
                        if ((newSearch.text.isEmpty)) {
                          print("blank");
                        } else {
                          Navigator.pushReplacement(
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
                          color: Colors.teal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Container(
              //     padding: EdgeInsets.only(left: 10, right: 10),
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Text(
              //           "What do you went to cook today?",
              //           style: TextStyle(
              //               fontSize: 30,
              //               color: Colors.white,
              //               fontFamily: "monument"),
              //         ),
              //         Text(
              //           " let's cook somthing new!",
              //           style: TextStyle(
              //               fontSize: 15,
              //               fontFamily: "monument",
              //               color: Colors.white),
              //         ),
              //       ],
              //     )),
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RecipyView(
                                          recipeList[index].appurl)));
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
