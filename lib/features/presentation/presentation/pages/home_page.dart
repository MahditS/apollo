import 'dart:math' as math;

import 'package:apollo/features/db_helper/constants.dart';
import 'package:apollo/features/presentation/presentation/pages/settings_page.dart';
import 'package:apollo/features/presentation/presentation/widgets/gradientText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:url_launcher/url_launcher.dart';
void main() => runApp(HomePage());

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var links_to_display = [];
  var titles = [];
  var titles_to_display = [];
  var lenght  = 0;
  var pretitles = [];

  @override
  void initState() {
    super.initState();
    links_to_display = [];
    titles = [];
    titles_to_display = [];
    lenght = 0;
    pretitles = [];
    print(curtopic);
    getWebsiteData();
  }

  Future getWebsiteData() async 
  {
    if(curtopic == "https://www.bbc.com"){
    final url = Uri.parse(curtopic);
    final response = await http.get(url);
    dom.Document html = dom.Document.html(response.body);
    var soup = BeautifulSoup(html.data);
    var hyperlinks = soup.findAll("a").toList();
    titles = soup.findAll("h2").toList();
    for(Bs4Element titlle in titles)
    {
     pretitles.add(titlle.innerHtml);
    }
    for(String title in pretitles)
    {
      var newTitle = title.replaceAll("<!-- -->", "").trim();
      var newnewtitle = newTitle.replaceAll('<span role="text">', "");
      var newnewnewtitle = newnewtitle.replaceAll("</span>", "");
      setState(() {
       titles_to_display.add(newnewnewtitle); 
      }); 
    }
    for (var link in hyperlinks)
    {
      var newLink = 'https://www.bbc.com${link["href"]}';
      if(newLink.contains("articles"))
      {
       setState(() {
         links_to_display.add(newLink);
       }); 
      }  
    }
    setState(() {
      titles_to_display= titles_to_display;
    });
    setState(() {
      links_to_display= links_to_display;
    });
    setState(() {
      lenght = titles_to_display.length;
    });
    print(titles_to_display);
    print(links_to_display);
    if(!titles_to_display.isEmpty)
    {
      lenght = titles_to_display.length - 10;
    }
    else
    {
      lenght = titles_to_display.length;
    }
    }
    else if(curtopic == "https://www.sciencenews.org/")
    {
    final url = Uri.parse(curtopic);
    final response = await http.get(url);
    dom.Document html = dom.Document.html(response.body);
    var soup = BeautifulSoup(html.data);
    var hyperlinks = soup.findAll("a").toList();
    // titles = soup.findAll("a").toList();
    // for(Bs4Element titlle in titles)
    // {
    //  if()
    //  String? t = titlle.text;
    //  pretitles.add(t);
    // }
    // for(String title in pretitles)
    // {
    //   var newTitle = title.replaceAll("<!-- -->", "").trim();
    //   var newnewtitle = newTitle.replaceAll('<span role="text">', "");
    //   var newnewnewtitle = newnewtitle.replaceAll("</span>", "");
    //   setState(() {
    //    titles_to_display.add(newnewnewtitle); 
    //   }); 
    // }
    for (var link in hyperlinks)
    {
      var newLink = link["href"];
      if(newLink!.contains("article")){
      setState(() {
         links_to_display.add(newLink);
         titles_to_display.add(link.text);
         titles_to_display = titles_to_display.toSet().toList();
         links_to_display = links_to_display.toSet().toList();
      
        
       }
       
    ); }

    }
       print(links_to_display.length);
       print(titles_to_display.length);
    setState(() {
      titles_to_display= titles_to_display;
    });
    setState(() {
      links_to_display= links_to_display;
    });
    setState(() {
      lenght = titles_to_display.length;
    });
    if(!titles_to_display.isEmpty)
    {
      lenght = titles_to_display.length - 10;
    }
    else
    {
      lenght = titles_to_display.length;
    }
    links_to_display.removeAt(0);
    links_to_display.removeAt(0);
    titles_to_display.removeAt(0);
    titles_to_display.removeAt(0);
    
    print(titles_to_display);
    print(links_to_display);
    }
  }

  Future<void> launch(String url, {bool isNewTab = true}) async {
    await launchUrl(
      Uri.parse(url),
      webOnlyWindowName: isNewTab ? '_blank' : '_self',
    );
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: 
          [
            Center(
              child: GradientText('Top Stories Today',style: const TextStyle(fontSize: 40),gradient: LinearGradient(colors: [Color.fromARGB(255, 243, 255, 25),Color.fromARGB(255, 243, 33, 33),]),
                    ),
            ),
          Expanded(child:         
          ListView.builder
          (
          itemCount: links_to_display.length,
          itemBuilder: (BuildContext context, int index) 
          {
            return GestureDetector(
              onTap:() {launchUrl(Uri.parse(links_to_display[index]));},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                    
                        ),
                        color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20, left:  20, top: 10,bottom: 10),
                          child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.search),
                    Text(titles_to_display[index], style: TextStyle(fontSize: 20, color: Colors.white),),
                  ],
                            ),
                        ),
                        ),
                ],
              ),
            );
          }
          ),
          ),
            GestureDetector(
              onTap:() {Navigator.push(context,MaterialPageRoute(builder: (context) => const SettingsPage()));},
              child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    color: Colors.orange,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.settings),
                Text("Configure App", style: TextStyle(fontSize: 15),),
              ],
                        ),
                    ),
                    ),
            ),
            
          ],
      ),
    );
  
  }
  }