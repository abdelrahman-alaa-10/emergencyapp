import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import '../credentials.dart';
import 'package:logger/logger.dart';
import '../logoutput.dart';
import 'dart:io';

final File logFile = File('app.log');

final logger = Logger(
  printer: PrettyPrinter(),
  output: FileLogOutput(logFile),
);
class VideoCall extends StatefulWidget 
{
  const VideoCall({super.key});

  @override
  State<VideoCall> createState() => _VideoCallState();
}

class _VideoCallState extends State<VideoCall> 
{
  static const String appId = Credentials.appID;
  static const String token = Credentials.token;
  static const String channelName = Credentials.channelName;

  var rtcEngine = createAgoraRtcEngine();
  
  @override
  void initState() 
  {
    super.initState();
    initializeAgora();
  }

  Future<void> initializeAgora() async 
  {
    await rtcEngine.initialize(const RtcEngineContext(appId: appId));
    await rtcEngine.enableVideo();
    rtcEngine.registerEventHandler(RtcEngineEventHandler(
      onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
        logger.i('joinChannelSuccess ${connection.channelId} ${connection.localUid}');
      },
      onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
        logger.i('userJoined $remoteUid');
      },
      onUserOffline: (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {
        logger.i('userOffline $remoteUid');
      },
    ));
    await rtcEngine.joinChannel(token: token, channelId: channelName, uid: 0, options: ChannelMediaOptions());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Call'),
      ),
      body: Stack(
        children: 
        [
          _renderLocalPreview(),
          _renderRemoteVideo(),
        ],
      ),
    );
  }

  Widget _renderLocalPreview() {
    return AgoraVideoView(
      controller: VideoViewController(
        rtcEngine: rtcEngine,
        canvas: const VideoCanvas(uid: 0),
      ),
    );
  }

  Widget _renderRemoteVideo() {
    return AgoraVideoView(
      controller: VideoViewController.remote(
        rtcEngine: rtcEngine,
        canvas: const VideoCanvas(uid: 1),
        connection: const RtcConnection(channelId: channelName),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    rtcEngine.leaveChannel();
    rtcEngine.release();
  }
}
