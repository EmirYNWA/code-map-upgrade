import 'package:code_map/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../models/popular_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<PopularDietsModel> popularDiets = [];
  String currentCategory = "Funkcionalno";

  Color backColor = Colors.white;

  void _getInitialInfo() {
    popularDiets = PopularDietsModel.getPopularDiets();
  }

  @override
  Widget build(BuildContext context) {
    _getInitialInfo();
    return Scaffold(
      drawer: const SideMenu(),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blue, Colors.green],
            ),
          ),
        ),
        title: const Text("Code <map>"),
      ),
      backgroundColor: backColor,
      body: ListView(
        children: [
          _searchField(),
          const SizedBox(height: 40,),
          _categoriesSection(),
          const SizedBox(height: 40,),
          _languagesFrameworksSection(currentCategory),
          const SizedBox(height: 40,),
          _popularModelSection(),
          const SizedBox(height: 40,),
        ],
      ),
    );
  }

  Column _popularModelSection() {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                'Popular',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600
                ),
              ),
            ),
            const SizedBox(height: 15,),
            ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 25,),
              itemCount: popularDiets.length,
              shrinkWrap: true,
              padding: const EdgeInsets.only(left: 20, right: 20),
              itemBuilder: (context, index) {
                return Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: popularDiets[index].boxIsSelected ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: popularDiets[index].boxIsSelected ? [
                      BoxShadow(
                        color: const Color(0xff1D1617).withOpacity(0.07),
                        offset: const Offset(0, 10),
                        blurRadius: 40,
                        spreadRadius: 0
                      )
                    ] : []
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SvgPicture.asset(
                        popularDiets[index].iconPath,
                        width: 65,
                        height: 65,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            popularDiets[index].name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '${popularDiets[index].level} | ${popularDiets[index].duration} | ${popularDiets[index].calorie}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Color(0xff7B6F72),
                              fontSize: 13,
                            ),
                          )
                        ],
                      ),
                      GestureDetector(
                        onTap: (){
                          setState(() {

                          });
                        },
                        child: SvgPicture.asset(
                          'assets/icons/button.svg',
                          width: 30,
                          height: 30,
                        ),
                      )
                    ],
                  ),
                );
              },
            )
          ],
        );
  }

  Column _languagesFrameworksSection(String category) {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                'Jezici i framework-ovi',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 15,),
            SizedBox(
              height: 240,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('Tehnologije').snapshots(),
                builder: (context, snapshot) {
                  List<Container> techWidgets = [];
                  if (snapshot.hasData) {
                    final technologies = snapshot.data?.docs.reversed.toList();
                    for (var tech in technologies!) {
                      try {
                        if (tech['kategorija'] == currentCategory) {
                          final techWidget = Container(
                            width: 210,
                            decoration: BoxDecoration(
                              color: Color(int.parse(tech['color']))
                                  .withOpacity(0.7),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                //SvgPicture.asset(diets[index].iconPath),
                                Image.asset(
                                  tech['slika'], width: 100, height: 100,),
                                Column(
                                  children: [
                                    Text(
                                      tech['naziv'],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                          fontSize: 16
                                      ),
                                    ),
                                    const Text(
                                      'To be added', // change the text
                                      style: TextStyle(
                                          color: Color(0xff7B6F72),
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 45,
                                  width: 130,
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                        colors: [ // colors should be upgraded
                                          Color(0xff9DCEFF),
                                          Color(0xff92A3FD),
                                        ]
                                    ),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'View',
                                      style: TextStyle(
                                        // colors should be upgraded
                                        //color: diets[index].viewIsSelected ? Colors.white : const Color(0xffC58BF2),
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );

                          techWidgets.add(techWidget);
                        }
                      }
                      catch (error) {}
                    }
                  }
                  return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(left: 0, right: 20),
                    itemCount: techWidgets.length,
                    separatorBuilder: (context, index) =>
                    const SizedBox(width: 2,),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 20,
                            right: 20
                        ),
                        child: techWidgets[index],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        );
  }

  Column _categoriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            'Kategorije',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 15,),
        SizedBox(
          height: 120,
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('Kategorije').snapshots(),
            builder: (context, snapshot) {
              List<GestureDetector> categoryWidgets = [];
              if (snapshot.hasData) {
                final categories = snapshot.data?.docs.reversed.toList();
                for (var cat in categories!) {
                  final categoryWidget = GestureDetector(
                    onTap: () {
                      print(cat['name'] + ' clicked!');
                      currentCategory = cat['name'];
                      setState(() {});
                    },
                    child: Container(
                      width: 100,
                      decoration: BoxDecoration(
                        color: Color(int.parse(cat['boxColor'])).withOpacity(0.7),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const SizedBox(width: 25,),
                          Container(
                            width: 50,
                            height: 50,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(cat['iconPath']),
                            ),
                          ),
                          Text(
                            cat['name'],
                            style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                                fontSize: 14
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                  categoryWidgets.add(categoryWidget);
                }
              }
              return ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 20, right: 20),
                itemCount: categoryWidgets.length,
                separatorBuilder: (context, index) =>
                const SizedBox(width: 5,),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: categoryWidgets[index],
                  );
                },
              );

            },
          ),
        ),
      ],
    );
  }

  Container _searchField() {
    return Container(
          margin: const EdgeInsets.only(top: 40, left: 20, right: 20),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: const Color(0xff1D1617).withOpacity(0.11),
                blurRadius: 40,
                spreadRadius: 0.0,
              )
            ]
          ),
          child: TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.all(15),
              hintText: 'Pretraži...',
              hintStyle: const TextStyle(
                color: Color(0xffDDDADA),
                fontSize: 14
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.all(12),
                child: SvgPicture.asset('assets/icons/Search.svg'),
              ),
              suffixIcon: SizedBox(
                width: 100,
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const VerticalDivider(
                        color:  Colors.black,
                        indent: 10,
                        endIndent: 10,
                        thickness: 0.1,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: SvgPicture.asset('assets/icons/Filter.svg'),
                      ),
                    ],
                  ),
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        );
  }

  }

