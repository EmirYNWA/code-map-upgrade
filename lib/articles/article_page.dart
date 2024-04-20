import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_map/home_page.dart';
import '../webCompiler/webView.dart';

const TextStyle tStyle = TextStyle(
  fontFamily: 'Poppins',
  color: Colors.black,
  fontSize: 14,
);

class MainArticle extends StatefulWidget {
  const MainArticle({Key? key, required this.currentTech, required this.imageUrl}) : super(key: key);
  final String currentTech;
  final String imageUrl;

  @override
  State<MainArticle> createState() => _MainArticleState();
}

class _MainArticleState extends State<MainArticle> {

  @override
  void initState() {
    super.initState();
    currentTech = widget.currentTech;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('Tekst').snapshots(),
          builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Dogodila se greška: ${snapshot.error}');
          } else {
            final technologiesText = snapshot.data?.docs.reversed.toList();
            for (var txt in technologiesText!) {
                if (txt['tech'] == currentTech) {
                  try {
                    return DefaultTabController(
                        length: 3,
                      child: Scaffold(
                              appBar: AppBar(
                                flexibleSpace: Container(
                                  decoration: BoxDecoration(
                                    color: Color(int.parse(txt['color'])),
                                  ),
                                ),
                                leading: IconButton(
                                  icon: Icon(Icons.arrow_back),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => HomePage()),
                                    );
                                  },
                                ),
                                title: Text(
                                  txt['tech'],
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                bottom: const TabBar(
                                  tabs: [
                                    Tab(
                                      child: Text(
                                        'Tekst',
                                        style: tStyle,
                                      ),
                                    ),
                                    Tab(child: Text(
                                      'Zadaci',
                                      style: tStyle,
                                    ),),
                                    Tab(child: Text(
                                      'Kompajler',
                                      style: tStyle,
                                    ),),
                                  ],
                                ),
                              ),
                              body: TabBarView(
                              children: [
                                    SingleChildScrollView(
                                    padding: const EdgeInsets.all(12.0),
                                            child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            children: [
                                            textSection(txt, 'intro'),
                                            Image.asset(
                                            widget.imageUrl, width: 200, height: 200,),
                                            textSection(txt, 'history'),
                                            textSection(txt, 'interface'),
                                            textSection(txt, 'syntax'),
                                            textSection(txt, 'extensions'),
                                            textSection(txt, 'use'),
                                            textSection(txt, 'popularity'),
                                            textSection(txt, 'pros_cons'),
                                            textSection(txt, 'enumeration_des'),
                                            ListCard(txt, 'enumeration', 'color'),
                                            textSection(txt, 'implementation'),
                                            textSection(txt, 'enumeration_des2'),
                                            ListCard(txt, 'enumeration2', 'color'),
                                            ]
                                           )
                                      ),
                                    const Center(
                                       child: Text('Sadržaj drugog taba'),
                                    ),
                                WebViewCompiler(currentTech),
                               ],
                              ),
                             ),
                        );

                  }catch(e){}
                }}
            return const Text('Nema podataka za trenutnu tehnologiju');
           }
          },
    );
  }

  SingleChildScrollView ListCard(QueryDocumentSnapshot<Object?> txt, String textDoc, String color) {
    return SingleChildScrollView(
                                 child: Column(
                                   children: [
                                     ListView.builder(
                                            shrinkWrap: true,
                                            physics: const NeverScrollableScrollPhysics(),
                                            itemCount: txt[textDoc].length ~/ 2,
                                            itemBuilder: (context, index) {
                                              final evenIndex = index * 2;
                                              final oddIndex = evenIndex + 1;
                                              try {
                                                return Card(
                                                  color: Color(
                                                      int.parse(txt[color])),
                                                  elevation: 2,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(0.0),
                                                  ),
                                                  child: ExpansionTile(
                                                    title: Text(
                                                        txt[textDoc][evenIndex]
                                                            .replaceAll(
                                                            "\\n", "\n"),
                                                        style: const TextStyle(
                                                            fontFamily: 'Poppins',
                                                            color: Colors.black,
                                                            fontSize: 14,
                                                            fontWeight: FontWeight
                                                                .w600
                                                        )
                                                    ),
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.all(10.0),
                                                        child: Text(
                                                            txt[textDoc][oddIndex]
                                                                .replaceAll(
                                                                "\\n", "\n"),
                                                            style: tStyle,
                                                            textAlign: TextAlign.justify
                                                          ),
                                                      )
                                                    ],
                                                  ),
                                                );
                                              }
                                              catch (e) {} // try-catch za card
                                            },
                                          ),
                                   ],
                                 ),
                               );
  }

  SizedBox textSection(QueryDocumentSnapshot<Object?> txt, String textDoc) {
    return SizedBox(
      height: (txt[textDoc] != null && txt[textDoc].isNotEmpty)
          ? null : 0.0,
      child: Text((){
        try { return txt[textDoc].replaceAll("\\n", "\n").replaceAll("\\t", "\t");
        } catch (e) { return ''; }
        }(),
        style: tStyle,
        textAlign: TextAlign.justify,
      ),
    );
  }
}


/*body: SingleChildScrollView(
                          padding: const EdgeInsets.all(12.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch, // bolje nego 'start'
                                  children: [
                                    textSection(text, 'intro'),
                                    Image.asset(
                                      urlImage, width: 200, height: 200,),
                                    textSection(text, 'history'),
                                    textSection(text, 'interface'),
                                    textSection(text, 'syntax'),
                                    textSection(text, 'extensions'),
                                    textSection(text, 'use'),
                                    textSection(text, 'popularity'),
                                    textSection(text, 'pros_cons'),
                                    textSection(text, 'enumeration_des'),
                                    ListCard(text, 'enumeration', 'color'),
                                    textSection(text, 'implementation'),
                                    textSection(text, 'enumeration_des2'),
                                    ListCard(text, 'enumeration2', 'color'),
                                  ]
                              )
                          ),
                        );*/