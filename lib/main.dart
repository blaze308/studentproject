import 'package:flutter/material.dart';
import 'package:studentproject/db/mongodb.dart';
import 'package:studentproject/db/product_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDatabase.connect();
  runApp(const MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 60,
        elevation: 0.5,
        title: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 215, 3, 227),
                    Color.fromARGB(255, 250, 20, 84),
                  ],
                ),
              ),
              child: const Text(
                "DP",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20, top: 5),
              child: Text(
                "Mark Appollo Hot Trends",
                style: TextStyle(
                    color: Colors.black87, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
      body: FutureBuilder(
          future: MongoDatabase.getData(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator.adaptive());
            } else {
              if (snapshot.hasData) {
                return Container(
                    child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15, top: 15),
                              child: Container(
                                  height: 100,
                                  width: double.maxFinite,
                                  decoration: BoxDecoration(
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Colors.black26,
                                            blurRadius: 1)
                                      ],
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Image.network(
                                          Product.fromJson(snapshot.data[index])
                                              .image!,
                                          fit: BoxFit.cover,
                                          width: 120,
                                          height: 100,
                                        ),
                                      ),
                                      Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                width: 200,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5, right: 5),
                                                  child: Text(
                                                    Product.fromJson(snapshot
                                                            .data[index])
                                                        .title
                                                        .toString(),
                                                    softWrap: true,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 20),
                                                  child: Text(
                                                    "GHC ${Product.fromJson(snapshot.data[index]).price}",
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color.fromARGB(
                                                            255, 199, 69, 71)),
                                                  ))
                                            ],
                                          ))
                                    ],
                                  )));
                        }));
              } else {
                return const Center(child: Text("data not found"));
              }
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openDialog();
        },
        backgroundColor: const Color.fromARGB(255, 229, 143, 91),
        child: const Icon(Icons.add, size: 45),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Future openDialog() => showDialog(
        context: context,
        builder: (context) => Dialog(
          insetPadding: const EdgeInsets.all(20),
          alignment: Alignment.center,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
                height: 550,
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      // title TextFormField
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r"^[a-z A-Z]+$").hasMatch(value)) {
                            return "enter correct title";
                          } else {
                            return null;
                            // ^[0-9]*$
                            // ^[0-9]*$
                          }
                        },
                        controller: titleController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                            fillColor: Color.fromARGB(255, 242, 244, 243),
                            filled: true,
                            contentPadding: EdgeInsets.all(10),
                            border: UnderlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            hintText: "Title*",
                            hintStyle: TextStyle(fontWeight: FontWeight.w500)),
                      ),
                      const SizedBox(height: 20),
                      //price
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty ||
                              // r'^-?[0-9]+$'
                              !RegExp(r"^[0-9]").hasMatch(value)) {
                            return "enter valid integer";
                          } else {
                            return null;
                          }
                        },
                        controller: priceController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                            fillColor: Color.fromARGB(255, 242, 244, 243),
                            filled: true,
                            contentPadding: EdgeInsets.all(10),
                            border: UnderlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            hintText: "Price*",
                            hintStyle: TextStyle(fontWeight: FontWeight.w500)),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty ||
                              // r'^-?[0-9]+$'
                              !RegExp(r"^[a-z A-Z]+$").hasMatch(value)) {
                            return "enter correct description";
                          } else {
                            return null;
                          }
                        },
                        maxLines: 7,
                        controller: descController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                            fillColor: Color.fromARGB(255, 242, 244, 243),
                            filled: true,
                            contentPadding: EdgeInsets.all(10),
                            border: UnderlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            hintText: "Description*",
                            hintStyle: TextStyle(fontWeight: FontWeight.w500)),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: FloatingActionButton(
                          backgroundColor:
                              const Color.fromARGB(255, 247, 113, 100),
                          onPressed: () {},
                          child: const Icon(Icons.add, size: 40),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                          ".jpg, .png and .gif are supported formats. \n Each photo must be 5 MB or less",
                          maxLines: 2),
                      const SizedBox(height: 25),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateColor.resolveWith(
                                  (states) => const Color.fromARGB(
                                      255, 248, 180, 179))),
                          onPressed: () {},
                          child: const Text("Post"),
                        ),
                      )
                    ],
                  ),
                )),
          ),
        ),
      );
}
