import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:logger/logger.dart';
import '../logoutput.dart';
import 'dart:io';
import 'dart:async';
import '../utils/videocallsettings.dart';

String logFilePath = 'C:\\Users\\moham\\OneDrive\\Desktop\\Boda\\CUFE\\SBE_3\\Projects\\AT\\emergencyapp\\app.log';
final File logFile = File(logFilePath);

final logger = Logger(
  printer: PrettyPrinter(),
  output: FileLogOutput(logFile),
);


class VideoCallWidget extends StatefulWidget 
{
  static const ClientRoleType clientRole = ClientRoleType.clientRoleBroadcaster;
  static const String channelName = Settings.channelName;
  
  const VideoCallWidget(
    {
      super.key,
    });
  
  @override
  State<VideoCallWidget> createState() => VideoCallState();
}


class VideoCallState extends State<VideoCallWidget> 
{
  final users = <int>[];
  final infoStrings = <String>[];
  bool muted = false;
  bool viewPanel = false;
  late RtcEngine rtcEngine; 
  
  @override
  void initState() 
  {
    super.initState();
    initializeAgora();
  }

  Future<void> initializeAgora() async 
  {
    if (Settings.appID.isEmpty)
    {
      setState(() 
      {
        infoStrings.add("App ID is missing");  
      });
      return;
    }
    
    rtcEngine = createAgoraRtcEngine();
    await rtcEngine.enableVideo();
    await rtcEngine.enableAudio();
    await rtcEngine.setChannelProfile(ChannelProfileType.channelProfileLiveBroadcasting);
    await rtcEngine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);

    addAgoraEventHandlers();

    final videoConfig = VideoEncoderConfiguration(
      dimensions: VideoDimensions(width: 1920, height: 1080)
    );
    
    await rtcEngine.setVideoEncoderConfiguration(videoConfig);
    await rtcEngine.joinChannel(
      token: Settings.token,
      channelId: Settings.channelName,
      uid: 0,
      options: ChannelMediaOptions());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Call'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: (){
              setState(() {
                viewPanel = !viewPanel;
              });
            },
            icon: const Icon(Icons.info_outline),
          )
        ],
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Stack(
          children: <Widget>[
            viewRows(),
            panel(),
            toolBar()
          ],
        ),
      ),
    );
  }


   void addAgoraEventHandlers() {
    rtcEngine.registerEventHandler(RtcEngineEventHandler(
      onJoinChannelSuccess: (RtcConnection connection, int elapsed) 
      {
        print('Successfully joined the channel: ${connection.channelId}');
        setState(() 
        {
          final info ="channel joined";
          infoStrings.add(info);
        });
      },
      onLeaveChannel: (RtcConnection connection, RtcStats stats) 
      {
            setState(() {
              infoStrings.add("channel left");
              users.clear();
            });
      },
      onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) 
      {
        setState(() {
          infoStrings.add("user joined");
          users.add(remoteUid);
        });
      },
      onUserOffline: (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) 
      {
        setState(() {
          infoStrings.add("User offline");
          users.remove(remoteUid);
        });
      },
      onFirstRemoteVideoFrame: (RtcConnection connection, int remoteUid, int width, int height, int elapsed)
      {
        setState(() {
          infoStrings.add("remote video recieved");
        });
      }
    ));
  }

  // Display the video of all users
  Widget viewRows()
  {
    final List<Widget> list = [];
    list.add(renderLocalPreview());
    list.addAll(users.map((uid) => renderRemotePreview(uid)));
    
    final views = list;
    return Column(
      children: List.generate(
        views.length,
        (index) => Expanded(child: views[index])
      ),
    );
  }

  Widget toolBar()
  {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RawMaterialButton(
            onPressed: (){
              setState(() {
                muted = !muted;
              });
              rtcEngine.muteLocalAudioStream(muted);
            },
            shape: const CircleBorder(),
            elevation: 2,
            fillColor: muted? Colors.blue:Colors.white,
            padding: const EdgeInsets.all(12),
            child: Icon(muted? Icons.mic_off_rounded :Icons.mic,
              color: muted? Colors.white: Colors.blue,
              size: 20,), 
            ),
          RawMaterialButton(
            onPressed: () => Navigator.pop(context),
            shape: CircleBorder(),
            elevation: 2,
            fillColor: Colors.red,
            padding: const EdgeInsets.all(15),
            child: const Icon(Icons.call_end, color: Colors.white,size: 35,),
          ),
          RawMaterialButton(
            onPressed: (){
              rtcEngine.switchCamera();
            },
            shape: const CircleBorder(),
            elevation: 2,
            fillColor: Colors.white,
            padding: EdgeInsets.all(12),
            child: const Icon(Icons.switch_camera, color: Colors.blue,size: 20,),
          )    
        ],
      ),
    );
  }

  Widget renderLocalPreview() 
  {
    return AgoraVideoView(
      controller: VideoViewController(
        rtcEngine: rtcEngine,
        canvas: const VideoCanvas(uid:0),
      ),
    );
  }

  Widget renderRemotePreview(int uid) {
    return AgoraVideoView(
      controller: VideoViewController.remote(
        rtcEngine: rtcEngine,
        canvas: VideoCanvas(uid: uid),
        connection: const RtcConnection(channelId: Settings.channelName),
      ),
    );
  }

  // What is happening behind the scenene
   panel()
  {
    return Visibility(
      visible: viewPanel,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 40),
        alignment: Alignment.bottomCenter,
        child: FractionallySizedBox(
          heightFactor: 0.5,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 48),
            child: ListView.builder(
              reverse: true,
              itemCount: infoStrings.length,
              itemBuilder: (BuildContext context, int index){
                if (infoStrings.isEmpty){
                  return const Text("NULL");
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)
                          ),
                          child: Text(
                            infoStrings[index],
                            style: const TextStyle(color: Colors.blueGrey),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    
    );
  }

  @override
  void dispose() 
  {
    users.clear();
    rtcEngine.leaveChannel();
    rtcEngine.release();
    super.dispose();
  }
}
