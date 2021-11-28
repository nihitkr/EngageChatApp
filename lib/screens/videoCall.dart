// ignore_for_file: prefer_final_fields, file_names

import 'dart:convert';

import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class VideoCall extends StatefulWidget {
  String channelName = "test";
  VideoCall({required this.channelName});
  @override
  State<VideoCall> createState() => _VideoCallState();
}

class _VideoCallState extends State<VideoCall> {
  late final AgoraClient _client;
  bool _loading = true;
  String tempToken = "";

  @override
  void initState() {
    getToken();
    super.initState();
  }

  Future<void> getToken() async {
    String link =
        "https://agora-node-tokenserver.nihitkr1.repl.co/access_token/?channelName=${widget.channelName}";

    Response _response = await get(Uri.parse(link));
    Map data = jsonDecode(_response.body);
    print(data["token"]);
    setState(() {
      tempToken = data["token"];
    });

    _client = AgoraClient(
        agoraConnectionData: AgoraConnectionData(
            appId: "7647357631c643838727d3b05894d89f",
            channelName: widget.channelName,
            tempToken:
                "0067647357631c643838727d3b05894d89fIACVPljiAgvixM9tbmXklQzbpfGX9H0czb7r1WOaLhS+oYamEDYAAAAAEAAUYhZwkgSlYQEAAQCOBKVh"),
        enabledPermission: [
          Permission.microphone,
          Permission.camera,
        ]);

    Future.delayed(Duration(seconds: 1)).then((value) {
      setState(() => _loading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: [
                  AgoraVideoViewer(
                    client: _client,
                  ),
                  AgoraVideoButtons(client: _client),
                ],
              ),
      ),
    );
  }
}
