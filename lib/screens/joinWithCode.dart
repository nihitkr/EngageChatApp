// ignore_for_file: prefer_const_constructors, file_names

import 'package:engage_stream_api/pages/videoCall.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JoinWithCode extends StatelessWidget {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Join a meeting"),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.fromLTRB(20, 100, 20, 0),
          child: Column(
            children: [
              //Text
              Text(
                "Enter Meeting Code below",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),

              //Textbox
              Card(
                color: Colors.grey[100],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                child: TextField(
                  controller: _controller,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Example: abc-def-ghi",
                  ),
                ),
              ),
              SizedBox(height: 20),

              //Join Button
              ElevatedButton.icon(
                onPressed: () {
                  Get.to(VideoCall(channelName: _controller.text.trim()));
                },
                icon: Icon(Icons.video_call),
                label: Text("JOIN"),
                style: OutlinedButton.styleFrom(
                  fixedSize: Size(150, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              SizedBox(height: 60),

              SizedBox(
                //Image
                height: 400,
                width: 400,
                child: Image.asset(
                  "assets/connectIcon.png",
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ));
  }
}
