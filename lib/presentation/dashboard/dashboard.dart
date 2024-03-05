import 'package:boilerplate/utils/device/device_utils.dart';
import 'package:flutter/material.dart';

class DashBoardScreen extends StatefulWidget {
  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(18, 10, 20, 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                    style: TextStyle(fontWeight: FontWeight.w600), "Your Job"),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5))),
                    onPressed: () {},
                    child: const Text(
                        style: TextStyle(fontSize: 16), "Post a job")),
              ],
            ),
            Container(
              margin: EdgeInsets.only(
                  top: DeviceUtils.getScaledHeight(context, 0.35)),
              child: Center(
                  child: Column(
                children: [
                  const Text(
                      style: TextStyle(fontWeight: FontWeight.w500),
                      "Welcome Duy!"),
                  const Text(
                      style: TextStyle(fontWeight: FontWeight.w500),
                      "You have no jobs!"),
                ],
              )),
            ),
          ],
        ));
  }
}
