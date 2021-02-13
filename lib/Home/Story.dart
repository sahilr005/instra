import 'package:flutter/material.dart';

class StoryView extends StatefulWidget {
  @override
  _StoryViewState createState() => _StoryViewState();
}

class _StoryViewState extends State<StoryView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 7, bottom: 0),
      height: MediaQuery.of(context).size.height * .11,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 1,
        itemBuilder: (context, index) {
          return Row(
            children: [
              SizedBox(width: 10),
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      // gradient: LinearGradient(
                      //     colors: [Colors.black, Colors.redAccent]),
                      border: Border.all(
                        color: Colors.blue,
                      ),
                      borderRadius: BorderRadius.circular(34),
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width * .18,
                      decoration: BoxDecoration(
                          // gradient: LinearGradient(
                          //     begin: Alignment.topRight,
                          //     end: Alignment.bottomLeft,
                          //     colors: [Colors.blue, Colors.red]),
                          shape: BoxShape.circle,
                          color: Colors.white24,
                          border: Border.all(
                            width: 1,
                          )),
                      child: Image.asset('assets/logo.jpg'),
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    'Story',
                    style: TextStyle(fontSize: 12, color: Colors.blueGrey),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
  
}

