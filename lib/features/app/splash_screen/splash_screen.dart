import 'package:apollo/features/presentation/presentation/widgets/gradientText.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
   final Widget child;
  const SplashScreen({super.key, required this.child});
 

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

@override
  void initState()
  {
    super.initState();
    Future.delayed(const Duration(seconds: 3), 
                  (){
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => widget.child), 
                      (route) => false);
                    }
                  );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 300,),
            GradientText('Apollo',style: const TextStyle(fontSize: 40),gradient: LinearGradient(colors: [Color.fromARGB(255, 243, 255, 25),Color.fromARGB(255, 243, 33, 33),]),
),
            Text("World News, at your fingertips", style: TextStyle(color: Color.fromARGB(255,255,119,119), fontSize: 15))
          ],
        ),
    ));
  }
}