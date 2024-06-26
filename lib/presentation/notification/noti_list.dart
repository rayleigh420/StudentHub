import 'dart:developer';

import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/domain/entity/notification/notification.dart';
import 'package:boilerplate/domain/usecase/proposal/update_proposal.dart';
import 'package:boilerplate/presentation/chat/store/notification_store.dart';
import 'package:boilerplate/presentation/home/store/theme/theme_store.dart';
import 'package:boilerplate/presentation/navigations/bottomNavigationBar.dart';
import 'package:boilerplate/utils/device/device_utils.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class NotiList extends StatefulWidget {
  const NotiList({super.key});

  @override
  State<NotiList> createState() => _NotiListState();
}

class _NotiListState extends State<NotiList> {
  final NotificationStore _notificationStore = getIt<NotificationStore>();
  final ThemeStore _themeStore = getIt<ThemeStore>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // check to see if already called api
    if (_notificationStore.success == false) {
      _notificationStore.getNotifications();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        buildMainContent(),
      ],
    );
  }

  Widget buildMainContent() {
    return Observer(
      builder: (context) {
        // ignore: unnecessary_null_comparison
        return _notificationStore.notifications == null
            ? Center(
                child: CupertinoActivityIndicator(),
              )
            : SafeArea(
                child: Scaffold(
                appBar: AppBar(
                  title: Text(AppLocalizations.of(context)
                      .translate('notification_title')),
                ),
                body: RefreshIndicator(
                  onRefresh: () async {
                    _notificationStore.refreshNoti();
                  },
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Container(
                      margin: EdgeInsets.only(
                          bottom: DeviceUtils.getScaledHeight(context, 0.5)),
                      padding: EdgeInsets.fromLTRB(18, 10, 20, 0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          buildListNoti(),
                        ],
                      ),
                    ),
                  ),
                ),
              ));
      },
    );
  }

  Widget buildListNoti() {
    return Observer(
      builder: (context) {
        if (_notificationStore.doneRefresh == false) {
          return Center(
            child: Text("Refreshing..."),
          );
        } else {
          if (_notificationStore.notifications.isEmpty) {
            return Container(
              alignment: Alignment.topCenter,
              height: MediaQuery.of(context).size.height * 1,
              padding: EdgeInsets.all(20.0),
              child: Text(
                'No notification yet',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          } else {
            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _notificationStore.notifications.length,
              itemBuilder: (_, index) {
                return buildNotiItem(
                    context, _notificationStore.notifications[index]);
              },
            );
          }
        }
      },
    );
  }

  Widget buildNotiItem(BuildContext context, Noti noti) {
    return GestureDetector(
      onTap: () {
        log("dd");
        if (noti.typeNotifyFlag == "3") {
          Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
              builder: (context) => AppBottomNavigationBar(
                    selectedIndex: 1,
                  ),
              maintainState: false));
        } else {
          log("cannot navigate to this page");
        }
      },
      child: Container(
          margin: EdgeInsets.only(top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.circle_notifications_outlined,
                    size: 30,
                    color: _themeStore.darkMode == true
                        ? Colors.white
                        : Colors.black,
                    weight: 300,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: Text(
                    noti.title,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  )),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  margin: EdgeInsets.only(left: 40),
                  child: Text(formatDate(noti.createdAt))),
              SizedBox(
                height: 10,
              ),
              Divider(
                color: Colors.black,
                thickness: 1,
              ),
            ],
          )),
    );
  }
}

String formatDate(DateTime date) {
  return "${date.day}/${date.month}/${date.year}";
}
