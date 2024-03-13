import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/presentation/home/store/theme/theme_store.dart';
import 'package:boilerplate/utils/device/device_utils.dart';
import 'package:flutter/material.dart';

class SearchProjectModal extends StatefulWidget {
  const SearchProjectModal({super.key});

  @override
  State<SearchProjectModal> createState() => _SearchProjectModalState();
}

class _SearchProjectModalState extends State<SearchProjectModal> {
  ThemeStore _themeStore = getIt<ThemeStore>();
  TextEditingController _searchController = TextEditingController();
  List<String> _recentSearches = [
    "Recent Search 1",
    "Recent Search 2",
    "Recent Search 3",
    "Recent Search 4",
    "Recent Search 5"
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _themeStore.darkMode ? Color(0xff2E3239) : Colors.white,
        border: Border(
            top: BorderSide(
                color:
                    _themeStore.darkMode ? Colors.grey : Colors.transparent)),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      width: DeviceUtils.getScaledWidth(context, 1),
      height: DeviceUtils.getScaledHeight(context, 0.93),
      child: Container(
        padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search for projects",
                prefixIcon: Icon(Icons.search,
                    color: _themeStore.darkMode ? Colors.white : null),
              ),
              onChanged: (value) {
                // Handle search text change
              },
              onSubmitted: (value) {},
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _recentSearches.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Container(
                      padding: EdgeInsets.only(bottom: 14, left: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.history,
                              size: 22,
                              color:
                                  _themeStore.darkMode ? Colors.white : null),
                          const SizedBox(width: 10),
                          Text(_recentSearches[index])
                        ],
                      ),
                    ),
                    onTap: () {
                      // Handle recent search item tap
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
