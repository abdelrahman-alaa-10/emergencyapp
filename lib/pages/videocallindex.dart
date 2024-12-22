import 'package:flutter/material.dart';
import 'dart:async';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:permission_handler/permission_handler.dart';
import 'videocallwidget.dart';

class IndexPage extends StatefulWidget
{
  const IndexPage({super.key});

  @override
  State<StatefulWidget> createState() => IndexState();
}

class IndexState extends State<IndexPage>
{
  final channelController = TextEditingController();
  bool validateError = false;
  final ClientRoleType clientRole = ClientRoleType.clientRoleBroadcaster;
  
  @override
  void dispose()
  {
    channelController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Agore"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 40),
              Image.network("C:\\Users\\moham\\OneDrive\\Desktop\\Boda\\CUFE\\SBE_3\\Projects\\AT\\emergencyapp\\lib\\pages\\assets\\images\\icons\\heart.png"),
              const SizedBox(height: 20),
              TextField(
                controller: channelController,
                decoration: InputDecoration(
                  errorText: validateError? 'channel name is required': null,
                  border: const UnderlineInputBorder(
                    borderSide: BorderSide(width: 1),
                  ),
                  hintText: 'Channel Name',
                ),
              ),
              // RadioListTile(
              //   title: const Text("broadcaster"),
              //   onChanged: (ClientRoleType? value)
              //   {
              //     setState(() {
              //       clientRole = value;
              //     });
              //   },
              //   value: ClientRoleType.clientRoleBroadcaster,
              //   groupValue: clientRole,
              // ),
              // RadioListTile(
              //   title: const Text('Audience'),
              //   onChanged: (ClientRoleType? value){
              //     setState(() {
              //       clientRole = value; 
              //     });
              //   },
              //   value: ClientRoleType.clientRoleAudience,
              //   groupValue: clientRole,
              // ),
              const SizedBox(height: 20,),
              ElevatedButton(
                onPressed: onJoin,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 40),
                ),
                child: const Text("Join"),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onJoin() async 
  {
    setState(() 
    {
      channelController.text.isEmpty? 
      validateError=true: validateError=false;
    });

    if (channelController.text.isNotEmpty)
    {
      await handleCameraAndMic(Permission.camera);
      await handleCameraAndMic(Permission.microphone);
      
      if(!mounted) return;
      
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => VideoCallWidget(
          channelName: channelController.text,
        ))
      );
    }
  }

  Future<void> handleCameraAndMic(Permission permission) async
  {
    final status = await permission.request();
    logger.i(status.toString());
  }
}