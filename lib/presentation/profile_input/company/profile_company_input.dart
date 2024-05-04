import 'package:boilerplate/domain/usecase/profile/create_profile_company_usecase.dart';
import 'package:boilerplate/domain/usecase/profile/get_profile_uc.dart';
import 'package:boilerplate/domain/usecase/profile/profile_company.dart';
import 'package:boilerplate/domain/usecase/profile/profile_test_uc.dart';
import 'package:boilerplate/presentation/welcome/welcome_company.dart';
import 'package:flutter/material.dart';
import 'package:boilerplate/presentation/home/store/theme/theme_store.dart';
import 'package:boilerplate/di/service_locator.dart';

class ProfileCompanyInput extends StatefulWidget {
  const ProfileCompanyInput({super.key});

  @override
  State<ProfileCompanyInput> createState() => _ProfileCompanyInputState();
}

class _ProfileCompanyInputState extends State<ProfileCompanyInput> {
  final _companyNameController = TextEditingController();
  final _companyWebsiteController = TextEditingController();
  final _companyDescriptionController = TextEditingController();
  final CreateProfileCompanyUC _createProfileCompanyUC =
      getIt<CreateProfileCompanyUC>();
  final GetProfileUseCase _getProfileUseCase = getIt<GetProfileUseCase>();
  Color textColor = Color(0xFF6C6C6C);
  Color textFieldColor = Color(0xFF6C6C6C);
  final ThemeStore _themeStore = getIt<ThemeStore>();
  String selected = "";
  List checkListItems = [
    {
      "id": 0,
      "value": false,
      "title": "It's just me",
      "size": 0,
    },
    {
      "id": 1,
      "value": false,
      "title": "2-9 employees",
      "size": 1,
    },
    {
      "id": 2,
      "value": false,
      "title": "10-99 employees",
      "size": 2,
    },
    {
      "id": 3,
      "value": false,
      "title": "100-1000 employees",
      "size": 3,
    },
    {
      "id": 4,
      "value": false,
      "title": "More than 1000 employees",
      "size": 4,
    },
  ];

  @override
  void initState() {
    super.initState();
    textColor = _themeStore.darkMode ? Colors.white : Color(0xFF6C6C6C);
  }

  void handleCreateProfile() async{
    _createProfileCompanyUC.call(
        params: CreateProfileCompanyParams(
            companyName: _companyNameController.text,
            size: checkListItems
                .firstWhere((element) => element["value"] == true)["size"],
            website: _companyWebsiteController.text,
            description: _companyDescriptionController.text));
    _getProfileUseCase.call(params: null);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 50),
                      child: const Text(
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                          "Welcome to Student Hub"),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: const Text(
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.normal),
                          textAlign: TextAlign.left,
                          "Tell us about your company and you will be on your way connect with high-skilled students"),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: const Text(
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.normal),
                          textAlign: TextAlign.left,
                          "How many people are in your company?"),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: List.generate(
                        checkListItems.length,
                        (index) => CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.all(0),
                          checkboxShape: CircleBorder(),
                          dense: true,
                          title: Text(
                            checkListItems[index]["title"],
                            style: const TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          value: checkListItems[index]["value"],
                          onChanged: (value) {
                            setState(() {
                              for (var element in checkListItems) {
                                element["value"] = false;
                              }
                              checkListItems[index]["value"] = value;
                              selected =
                                  "${checkListItems[index]["id"]}, ${checkListItems[index]["title"]}, ${checkListItems[index]["value"]}";
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    const Text(
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.normal),
                        textAlign: TextAlign.left,
                        "Company name"),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: _companyNameController,
                      onTapOutside: (event) => FocusScope.of(context).unfocus(),
                      maxLines: 1,
                      style: TextStyle(
                        color: textFieldColor,
                      ),
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.all(16),
                        enabledBorder: const OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 0.0),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 0.0),
                        ),
                        errorBorder: const OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.red, width: 0.0),
                        ),
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        hintStyle: TextStyle(
                          //fontFamily: "GGX88Reg_Light",

                          color: Color(0xFFc6c6c6),
                        ),
                      ),
                      onChanged: (value) {},
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    const Text(
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.normal),
                        textAlign: TextAlign.left,
                        "Website"),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: _companyWebsiteController,
                      onTapOutside: (event) => FocusScope.of(context).unfocus(),
                      maxLines: 1,
                      style: TextStyle(
                        color: textFieldColor,
                      ),
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.all(16),
                        enabledBorder: const OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 0.0),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 0.0),
                        ),
                        errorBorder: const OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.red, width: 0.0),
                        ),
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        hintStyle: TextStyle(
                          //fontFamily: "GGX88Reg_Light",

                          color: Color(0xFFc6c6c6),
                        ),
                      ),
                      onChanged: (value) {},
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    const Text(
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.normal),
                        textAlign: TextAlign.left,
                        "Description"),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: _companyDescriptionController,
                      onTapOutside: (event) => FocusScope.of(context).unfocus(),
                      maxLines: 2,
                      style: TextStyle(
                        color: textFieldColor,
                      ),
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.all(16),
                        enabledBorder: const OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 0.0),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 0.0),
                        ),
                        errorBorder: const OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.red, width: 0.0),
                        ),
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        hintStyle: TextStyle(
                          //fontFamily: "GGX88Reg_Light",

                          color: Color(0xFFc6c6c6),
                        ),
                      ),
                      onChanged: (value) {},
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(left: 170, bottom: 20),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5))),
                          onPressed: () {
                            handleCreateProfile();
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context) {
                              return const WelcomeCompany();
                            }));
                          },
                          child: const Text(
                              style: TextStyle(fontSize: 16), "Continue")),
                    ),
                  ],
                ))));
  }
}
