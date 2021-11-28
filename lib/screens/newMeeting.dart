// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, file_names

import 'package:engage_stream_api/pages/videoCall.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';
import 'package:uuid/uuid.dart';

class NewMeeting extends StatefulWidget {
  NewMeeting({Key? key}) : super(key: key);

  @override
  State<NewMeeting> createState() => _NewMeetingState();
}

class _NewMeetingState extends State<NewMeeting> {
  @override
  String _meetingCode = "abcd";
  void initState() {
    var uuid = Uuid();
    _meetingCode = uuid.v1().substring(0, 8);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Start New Meeting")),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.fromLTRB(20, 50, 20, 0),
        child: Column(
          children: [
            //Text
            Text(
              "Your meeting is ready",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),

            Card(
              color: Colors.grey[100],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              child: ListTile(
                leading: Icon(Icons.link),
                title: SelectableText(
                  _meetingCode,
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                  ),
                ),
                trailing: Icon(Icons.copy),
              ),
            ),
            Divider(
              thickness: 1,
              height: 40,
              indent: 40,
              endIndent: 40,
            ),
            SizedBox(height: 20),

            //Start Meeting Icon
            ElevatedButton.icon(
              onPressed: () {
                Get.to(VideoCall(channelName: _meetingCode));
              },
              icon: Icon(Icons.video_call_outlined),
              label: Text("Start Meeting"),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(350, 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
              ),
            ),
            SizedBox(height: 20),

            //Share invite Button
            OutlinedButton.icon(
              onPressed: () {
                Share.share("Meeting Code: $_meetingCode");
              },
              icon: Icon(Icons.share),
              label: Text("Share Invite"),
              style: OutlinedButton.styleFrom(
                fixedSize: Size(350, 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
              ),
            ),
            SizedBox(height: 100),

            //Image
            SizedBox(
              height: 200,
              width: 200,
              child: Image.asset(
                "assets/newMeetIcon.png",
                fit: BoxFit.contain,
              ),
            ),

            //
          ],
        ),
      ),
    );
  }
}
