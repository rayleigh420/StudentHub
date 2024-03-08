import 'package:flutter/material.dart';
import 'package:boilerplate/presentation/home/store/theme/theme_store.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:dotted_border/dotted_border.dart';

class ResumeUpload extends StatefulWidget {
  const ResumeUpload({super.key});

  @override
  State<ResumeUpload> createState() => _ResumeUploadState();
}

class _ResumeUploadState extends State<ResumeUpload> {

  Color textColor = Color(0xFF6C6C6C);
  Color textFieldColor = Color(0xFF6C6C6C);
  final ThemeStore _themeStore = getIt<ThemeStore>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  //PickerFileResume
  String? _fileName;
  String? _saveAsFileName;
  List<PlatformFile>? _paths;
  String? _directoryPath;
  String? _extension;
  bool _isLoading = false;
  bool _lockParentWindow = false;
  bool _userAborted = false;
  //PickerFileTranscript
  String? _fileName1;
  String? _saveAsFileName1;
  List<PlatformFile>? _paths1;
  String? _directoryPath1;
  String? _extension1;
  bool _isLoading1 = false;
  bool _lockParentWindow1 = false;
  bool _userAborted1 = false;


  FileType _pickingType = FileType.any;
 

  @override
  void initState() {
    super.initState();
    textColor = _themeStore.darkMode ? Colors.white : Color(0xFF6C6C6C);
  }
   void _pickFiles() async {
    _resetState();
    try {
      _directoryPath = null;
      _paths = (await FilePicker.platform.pickFiles(
        compressionQuality: 30,
        type: _pickingType,
        allowMultiple: false,
        onFileLoading: (FilePickerStatus status) => print(status),
        allowedExtensions: (_extension?.isNotEmpty ?? false)
            ? _extension?.replaceAll(' ', '').split(',')
            : null,
       
        lockParentWindow: _lockParentWindow,
      ))
          ?.files;
    } on PlatformException catch (e) {
      _logException('Unsupported operation' + e.toString());
    } catch (e) {
        _logException(e.toString());
    }
    if (!mounted) return;
    setState(() {
      _isLoading = false;
      _fileName =
          _paths != null ? _paths!.map((e) => e.name).toString() : '...';
      _userAborted = _paths == null;
    });
  }
  void _pickFiles1() async {
    _resetState1();
    try {
      _directoryPath1 = null;
      _paths1 = (await FilePicker.platform.pickFiles(
        compressionQuality: 30,
        type: _pickingType,
        allowMultiple: false,
        onFileLoading: (FilePickerStatus status) => print(status),
        allowedExtensions: (_extension?.isNotEmpty ?? false)
            ? _extension?.replaceAll(' ', '').split(',')
            : null,
       
        lockParentWindow: _lockParentWindow1,
      ))
          ?.files;
    } on PlatformException catch (e) {
      _logException('Unsupported operation' + e.toString());
    } catch (e) {
        _logException(e.toString());
    }
    if (!mounted) return;
    setState(() {
      _isLoading1 = false;
      _fileName1 =
          _paths1 != null ? _paths1!.map((e) => e.name).toString() : '...';
      _userAborted1 = _paths == null;
    });
  }
   void _resetState() {
    if (!mounted) {
      return;
    }
    setState(() {
      _isLoading = true;
      _directoryPath = null;
      _fileName = null;
      _paths = null;
      _saveAsFileName = null;
      _userAborted = false;
    });
  }
  void _resetState1() {
    if (!mounted) {
      return;
    }
    setState(() {
      _isLoading1 = true;
      _directoryPath1 = null;
      _fileName1 = null;
      _paths1 = null;
      _saveAsFileName1 = null;
      _userAborted1 = false;
    });
  }
   void _logException(String message) {
    print(message);
    _scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
    _scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 50),
                  child: const Text(
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                      "CV & Transcript"),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: const Text(
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.normal),
                      textAlign: TextAlign.left,
                      "Tell us about your company and you will be on your way connect with real-world project"),
                ),
              
                SizedBox(
                  height: 40,
                ),
               

                const Text(
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                    textAlign: TextAlign.left,
                    "Resume/CV(*)"),
                SizedBox(
                  height: 10,
                ),
                        DottedBorder(
                    dashPattern: [8, 4],
                    strokeWidth: 2,
                    radius: Radius.circular(15),
                    color: Colors.white,
                    
                    child: Container(
                      margin: const EdgeInsets.only(left: 70, right: 70, bottom: 30, top: 30),
                      height: 40,
                      width: 200,

                      child: _fileName != null
                          ? InkWell(
                              onTap: () => _pickFiles(),
                            child: Text(_fileName!.toString()
                            )
                            )
                          :
                       FloatingActionButton.extended(
                                onPressed: () => _pickFiles(),
                                label:
                                    Text('Choose files to upload'),
                                icon: const Icon(Icons.description)),
                     
                    ),
                    ),

              
                SizedBox(
                  height: 40,
                ),
                const Text(
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                    textAlign: TextAlign.left,
                    "Transcript(*)"),
                SizedBox(
                  height: 10,
                ),
                 DottedBorder(
                    dashPattern: [8, 4],
                    strokeWidth: 2,
                    radius: Radius.circular(15),
                    color: Colors.white,
                    
                    child: Container(
                      margin: const EdgeInsets.only(left: 70, right: 70, bottom: 30, top: 30),
                      height: 40,
                      width: 200,

                      child: _fileName1 != null
                          ? InkWell(
                              onTap: () => _pickFiles1(),
                            child:
                             Text(_fileName1!.toString()
                             )
                             )
                          :
                       FloatingActionButton.extended(
                                onPressed: () => _pickFiles1(),
                                label:
                                    Text('Choose files to upload'),
                                icon: const Icon(Icons.description)),
                     
                    ),
                    ),
               
                SizedBox(
                  height: 120,
                ),
              
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(left: 170, bottom: 20),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5))),
                      onPressed: () {},
                      child: const Text(
                          style: TextStyle(fontSize: 16), "Continue")),
                ),
              ],
            )));
  }
}
