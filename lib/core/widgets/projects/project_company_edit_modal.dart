import 'package:boilerplate/utils/device/device_utils.dart';

import 'package:flutter/material.dart';

class ProjectCompanyEditModal extends StatefulWidget {
  const ProjectCompanyEditModal({super.key});

  @override
  State<ProjectCompanyEditModal> createState() =>
      _ProjectCompanyEditModalState();
}

class _ProjectCompanyEditModalState extends State<ProjectCompanyEditModal> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      width: DeviceUtils.getScaledWidth(context, 1),
      height: DeviceUtils.getScaledHeight(context, 0.8),
      child: Center(child: Text("hello")),
    );
  }
}
