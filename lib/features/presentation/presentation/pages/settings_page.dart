import 'package:apollo/features/db_helper/constants.dart';
import 'package:apollo/features/presentation/presentation/pages/home_page.dart';
import 'package:apollo/features/presentation/presentation/widgets/gradientText.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}
enum Topics {
  bbc('BBC', "https://www.bbc.com"),
  science('Science News', "https://www.sciencenews.org/");


  const Topics(this.label, this.link);
  final String label;
  final String link;
}
class _SettingsPageState extends State<SettingsPage> {
  
  final TextEditingController topicController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("Return to Home", style: TextStyle(color: Color.fromARGB(255, 45, 45, 45), fontWeight: FontWeight.bold, fontSize: 15),)),
      backgroundColor: Colors.white,
      body: Column(
        children: 
        [
            Center(
              child: GradientText('Choose the news site you would like to see!',style: const TextStyle(fontSize: 20),gradient: LinearGradient(colors: [Color.fromARGB(255, 243, 255, 25),Color.fromARGB(255, 243, 33, 33),]),
                    )),
                    SizedBox(height:20,),
                    DropdownMenu<Topics>(
                      initialSelection: Topics.bbc,
                      controller: topicController,
                      requestFocusOnTap: true,
                      label: const Text('Topic'),
                      onSelected: (Topics? topic) {
                        setState(() {
                          curtopic = topic!.link;
                        });
                      },
                      dropdownMenuEntries: Topics.values
                          .map<DropdownMenuEntry<Topics>>(
                              (Topics topic) {
                        return DropdownMenuEntry<Topics>(
                          value: topic,
                          label: topic.label,
                        );
                      }).toList(),
                    ),
                    GestureDetector(
              onTap:() {Navigator.push(context,MaterialPageRoute(builder: (context) => HomePage()));},
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
                Text("Return", style: TextStyle(fontSize: 15),),
              ],
                        ),
                    ),
                    ),
            ),
            ]
            )
    );
  }
}