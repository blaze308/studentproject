import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:studentproject/alternate.dart';
import 'package:studentproject/cloudinary.dart';
// import 'package:mongo_dart/mongo_dart.dart' as m;
import 'package:studentproject/constants/sizes.dart';
import 'package:studentproject/db/mongodb.dart';
import 'package:studentproject/db/product_model.dart';
import 'package:studentproject/widgets/app_bar_title.dart';

void main() async {
  bool result = await InternetConnectionChecker().hasConnection;
  if (result == true) {
    WidgetsFlutterBinding.ensureInitialized();
    await MongoDatabase.connect();
    runApp(const GetMaterialApp(
      home: MyApp(),
      debugShowCheckedModeBanner: false,
    ));
  } else {
    runApp(const MaterialApp(
      home: Alternate(),
    ));
  }
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

  Future<void> _refreshData() async {
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      MongoDatabase.getData();
      titleController.clear();
      priceController.clear();
      descController.clear();
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    priceController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print("screenheight: " + MediaQuery.of(context).size.height.toString());
    // print("screenwidth: " + MediaQuery.of(context).size.width.toString());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: ScreenSize.toolbarHeight,
        elevation: ScreenSize.toolbarElevation,
        title: const AppBarTitle(),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: FutureBuilder(
            future: MongoDatabase.getData(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator.adaptive());
              } else {
                if (snapshot.hasData) {
                  return SizedBox(
                    height: double.maxFinite,
                    width: double.maxFinite,
                    child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return Padding(
                              padding: EdgeInsets.only(
                                  left: ScreenSize.width10,
                                  right: ScreenSize.width15,
                                  top: ScreenSize.height5,
                                  bottom: ScreenSize.height5),
                              child: GestureDetector(
                                onTap: () => showDialog(
                                    context: context,
                                    builder: (context) => Dialog(
                                          insetPadding: EdgeInsets.only(
                                              top: ScreenSize.height10,
                                              left: ScreenSize.width20,
                                              right: ScreenSize.width20),
                                          alignment: Alignment.center,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      ScreenSize.width20)),
                                          child: SingleChildScrollView(
                                              child: ConstrainedBox(
                                            constraints: const BoxConstraints(),
                                            child: Column(children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(
                                                        ScreenSize.width20),
                                                    topRight: Radius.circular(
                                                        ScreenSize.width20)),
                                                child: Image.network(
                                                    Product.fromJson(snapshot
                                                            .data[index])
                                                        .image!,
                                                    fit: BoxFit.cover,
                                                    width: double.maxFinite,
                                                    height:
                                                        ScreenSize.height250),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(
                                                    ScreenSize.width20),
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: ScreenSize
                                                              .height10),
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                            Product.fromJson(
                                                                    snapshot.data[
                                                                        index])
                                                                .title
                                                                .toString(),
                                                            softWrap: true,
                                                            maxLines: 3,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                fontSize: ScreenSize
                                                                    .fontSize25,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: Text(
                                                        "GHC ${Product.fromJson(snapshot.data[index]).price}",
                                                        style: TextStyle(
                                                            fontSize: ScreenSize
                                                                .fontSize25,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: const Color
                                                                    .fromARGB(
                                                                255,
                                                                199,
                                                                69,
                                                                71)),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: ScreenSize
                                                              .height10),
                                                      child: Text(
                                                          Product.fromJson(
                                                                  snapshot.data[
                                                                      index])
                                                              .description
                                                              .toString(),
                                                          style: TextStyle(
                                                              letterSpacing:
                                                                  ScreenSize
                                                                      .letterSpacing,
                                                              fontSize: ScreenSize
                                                                  .fontSize15)),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ]),
                                          )),
                                        )),
                                child: Container(
                                    height: ScreenSize.height80,
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black26,
                                              blurRadius: ScreenSize.width1)
                                        ],
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(
                                            ScreenSize.width5)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Flexible(
                                          child: Padding(
                                            padding: EdgeInsets.all(
                                                ScreenSize.width5),
                                            child: SizedBox(
                                              child: Image(
                                                width: ScreenSize.width150,
                                                fit: BoxFit.fitWidth,
                                                image: NetworkImage(
                                                  Product.fromJson(
                                                          snapshot.data[index])
                                                      .image!,
                                                  // width: double.maxFinite,
                                                  // height: ScreenSize.height100,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(
                                                left: ScreenSize.width10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                SizedBox(
                                                  width: ScreenSize.width200,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        top: ScreenSize.height5,
                                                        right:
                                                            ScreenSize.width5),
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
                                                    padding: EdgeInsets.only(
                                                        top: ScreenSize
                                                            .height20),
                                                    child: Text(
                                                      "GHC ${Product.fromJson(snapshot.data[index]).price}",
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Color.fromARGB(
                                                              255,
                                                              199,
                                                              69,
                                                              71)),
                                                    ))
                                              ],
                                            ))
                                      ],
                                    )),
                              ));
                        }),
                  );
                } else {
                  return const Center(child: Text("data not found"));
                }
              }
            }),
      ),
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
          insetPadding: EdgeInsets.only(
              left: ScreenSize.width20, right: ScreenSize.width20),
          alignment: Alignment.center,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(ScreenSize.width20)),
          child: Padding(
            padding: EdgeInsets.all(ScreenSize.width20),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: ConstrainedBox(
                  constraints: const BoxConstraints(),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: ScreenSize.height20),
                        // title TextFormField
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty ||
                                !RegExp(r"^[a-z A-Z]+$").hasMatch(value)) {
                              return "enter correct title";
                            } else {
                              return null;
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
                              hintStyle:
                                  TextStyle(fontWeight: FontWeight.w500)),
                        ),
                        SizedBox(height: ScreenSize.height20),
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
                              hintStyle:
                                  TextStyle(fontWeight: FontWeight.w500)),
                        ),
                        SizedBox(height: ScreenSize.height20),
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
                              hintStyle:
                                  TextStyle(fontWeight: FontWeight.w500)),
                        ),
                        SizedBox(height: ScreenSize.height20),
                        Padding(
                          padding: EdgeInsets.only(left: ScreenSize.width10),
                          child: FloatingActionButton(
                            backgroundColor:
                                const Color.fromARGB(255, 247, 113, 100),
                            onPressed: () {
                              MyCloudinary().uploadImage();
                            },
                            child: const Icon(Icons.add, size: 40),
                          ),
                        ),
                        SizedBox(height: ScreenSize.height20),
                        const Text(
                            ".jpg, .png and .gif are supported formats. \n Each photo must be 5 MB or less",
                            maxLines: 2),
                        SizedBox(height: ScreenSize.height25),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                fixedSize: Size(
                                    ScreenSize.width150, ScreenSize.height30),
                                padding: EdgeInsets.only(
                                    left: ScreenSize.width5,
                                    right: ScreenSize.width5),
                                textStyle: TextStyle(
                                    fontSize: ScreenSize.fontSize25,
                                    fontWeight: FontWeight.bold),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        ScreenSize.width20)),
                                backgroundColor:
                                    const Color.fromARGB(255, 248, 180, 179)),
                            onPressed: _insertData,
                            child: const Text("Post"),
                          ),
                        )
                      ],
                    ),
                  )),
            ),
          ),
        ),
      );

  Future<void> _insertData() async {
    final data = Product(
        // id: m.ObjectId(),
        title: titleController.text,
        price: int.parse(priceController.text),
        image: MyCloudinary.response?.secureUrl.toString(),
        description: descController.text);
    await MongoDatabase.insert(data);
  }
}
