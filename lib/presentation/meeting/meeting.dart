import 'package:boilerplate/utils/device/device_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class MeetingScreen extends StatefulWidget {
  const MeetingScreen({super.key});

  @override
  State<MeetingScreen> createState() => _MeetingScreenState();
}

class _MeetingScreenState extends State<MeetingScreen> {
  late RTCVideoRenderer _localRenderer;
  late RTCVideoRenderer _remoteRenderer;

  @override
  void initState() {
    super.initState();
    _initRenderers();
  }

  void _initRenderers() async {
    _localRenderer = RTCVideoRenderer();
    _remoteRenderer = RTCVideoRenderer();
    await _localRenderer.initialize();
    await _remoteRenderer.initialize();
  }

  @override
  void dispose() {
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    super.dispose();
  }

  final img = kIsWeb
      ? AssetImage('/images/company.png')
      : AssetImage('assets/images/company.png');
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Meeting'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey)),
                width: DeviceUtils.getScaledWidth(context, 0.9),
                height: DeviceUtils.getScaledHeight(context, 0.37),
                child: Stack(
                  children: [
                    RTCVideoView(_localRenderer),
                    Positioned(
                      top: 10,
                      right: 16,
                      child: Container(
                        width: 17,
                        height: 17,
                        child: Icon(Icons.mic),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Image(
                          image: img,
                          width: DeviceUtils.getScaledWidth(context, 0.3),
                          height: DeviceUtils.getScaledHeight(context, 0.3)),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Text('You'),
                    )
                  ],
                )),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              width: DeviceUtils.getScaledWidth(context, 0.9),
              height: DeviceUtils.getScaledHeight(context, 0.37),
              child: Stack(
                children: [
                  RTCVideoView(_localRenderer),
                  Positioned(
                    top: 10,
                    right: 16,
                    child: Container(
                      width: 17,
                      height: 17,
                      child: Icon(Icons.mic),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Image(
                        image: img,
                        width: DeviceUtils.getScaledWidth(context, 0.3),
                        height: DeviceUtils.getScaledHeight(context, 0.3)),
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    child: Text('Me'),
                  )
                ],
              ),
            ),
            const Spacer(),
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildControlButton(
                    icon: Icons.mic,
                    onPressed: () {},
                  ),
                  _buildControlButton(
                    icon: Icons.videocam,
                    onPressed: () {},
                  ),
                  _buildControlButton(
                    icon: Icons.call_end,
                    onPressed: () {},
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }

  Widget _buildControlButton({required IconData icon, Function()? onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black.withOpacity(0.3),
        ),
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }
}
