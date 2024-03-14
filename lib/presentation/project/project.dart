import 'package:boilerplate/presentation/browse_project/browse_project_main.dart';
import 'package:boilerplate/presentation/saved_project/saved_project.dart';
import 'package:boilerplate/presentation/search_project_screen/search_project_screen.dart';
import 'package:flutter/material.dart';

const routeHome = "/browse_project";
const routeSearchedProject = "/searched_project";
const routeSavedProject = "/saved_project";

class ProjectScreen extends StatefulWidget {
  ProjectScreen({Key? key}) : super(key: key);

  @override
  _ProjectScreenState createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  final _projectNavigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PopScope(
          canPop: true,
          onPopInvoked: (value) {
            if (_projectNavigatorKey.currentState!.canPop()) {
              print("đụ mẹ");
              _projectNavigatorKey.currentState!.pop();
              return;
            }
            return;
          },
          child: Navigator(
            key: _projectNavigatorKey,
            initialRoute: "/",
            onGenerateRoute: (RouteSettings settings) {
              WidgetBuilder builder;
              switch (settings.name) {
                case '/':
                  builder = (BuildContext context) => BrowseProjectScreen(
                        navigatorKey: _projectNavigatorKey,
                      );
                  break;
                case 'searched_project':
                  builder = (BuildContext context) => SearchProjectScreen();
                  break;
                case 'saved_project':
                  builder = (BuildContext context) => SavedProject();
                  break;
                default:
                  throw Exception('Invalid route: ${settings.name}');
              }
              return MaterialPageRoute(
                builder: builder,
                settings: settings,
              );
            },
          )),
    );
  }
}
