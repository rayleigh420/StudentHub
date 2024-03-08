import 'package:flutter/material.dart';

class WelcomeCompany extends StatelessWidget {
  const WelcomeCompany({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
        child: Column(
          children: [
            Center(
              heightFactor: 4,
              child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Icon(Icons.business_center, color: Colors.white, size: 50),
                  ]),
            ),
            Container(
              margin: const EdgeInsets.all(0),
              child: const Text(
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                  "Welcome, Hai!"),
            ),
            Container(
              margin: const EdgeInsets.all(0),
              child: const Text(
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                  "Let's start with your first project post"),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(left: 70, right: 70),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                  onPressed: () {},
                  child: const Text(
                      style: TextStyle(fontSize: 16), "Get Started!")),
            ),
          ],
        ),
      ),
    ));
  }
}
