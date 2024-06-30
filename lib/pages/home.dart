import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import '../widgets/bottom_navigation_link.dart';
import '../widgets/home_grid_item.dart';

import '../datasource.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List affectedCountries = [];
  Map worldData = {};

  String statsUrl = 'https://disease.sh/v3/covid-19/all';
  String countriesDataUrl =
      'https://disease.sh/v3/covid-19/countries?sort=cases';

  Future getData() async {
    setState(() {
      affectedCountries = [];
      worldData = {};
    });
    var resultStats = await http.get(Uri.parse(statsUrl));
    var resultCountries = await http.get(Uri.parse(countriesDataUrl));
    setState(() {
      worldData = jsonDecode(resultStats.body);
      affectedCountries = jsonDecode(resultCountries.body);
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: deepColor,
        centerTitle: false,
        title: const Text(
          'Covid Tracker',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: getData,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Notification
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.orange[100],
                ),
                child: Text(
                  DataSource.quote,
                  style: TextStyle(
                    color: Colors.orange[800],
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // worldwide section header
              Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'WorldWide',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(deepColor),
                      ),
                      onPressed: () {},
                      child: const Text(
                        'Regional',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // all stats boxes grid
              worldData.isEmpty
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container(
                      padding: const EdgeInsets.all(10),
                      child: GridView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 2,
                        ),
                        children: [
                          HomeGridItem(
                            title: 'CONFIRMED',
                            number: worldData['cases'],
                            foregroundColor: const Color(0xffC03836),
                            backgroundColor: const Color(0xffF8CDD1),
                          ),
                          HomeGridItem(
                            title: 'ACTIVE',
                            number: worldData['active'],
                            foregroundColor: const Color(0xff3169B5),
                            backgroundColor: const Color(0xffBBDEFC),
                          ),
                          HomeGridItem(
                            title: 'RECOVERED',
                            number: worldData['recovered'],
                            foregroundColor: const Color(0xff437841),
                            backgroundColor: const Color(0xffC8E6C9),
                          ),
                          HomeGridItem(
                            title: 'DEATHS',
                            number: worldData['deaths'],
                            foregroundColor: const Color(0xff484848),
                            backgroundColor: const Color(0xff9E9E9E),
                          ),
                        ],
                      ),
                    ),

              // most Affected countries
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                child: const Text(
                  'Most affected countries',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),

              affectedCountries.isEmpty
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              Image.network(
                                affectedCountries[index]['countryInfo']['flag'],
                                width: 50,
                                height: 50,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                affectedCountries[index]['country'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Deaths: ${affectedCountries[index]['deaths']}',
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),

              const SizedBox(
                height: 20,
              ),

              BottomNavigationLink(
                title: 'FAQ',
                action: () {
                  launchUrl(Uri.parse('https://www.google.com/'));
                },
              ),

              BottomNavigationLink(
                title: 'Donate',
                action: () {
                  launchUrl(Uri.parse('https://www.google.com/'));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
