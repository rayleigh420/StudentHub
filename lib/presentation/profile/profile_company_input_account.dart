import 'package:flutter/material.dart';
import 'package:boilerplate/presentation/home/store/theme/theme_store.dart';
import 'package:boilerplate/di/service_locator.dart';
class ProfileCompanyInputAccount extends StatefulWidget {
  const ProfileCompanyInputAccount({super.key});

  @override
  State<ProfileCompanyInputAccount> createState() => _ProfileCompanyInputAccountState();
}


class _ProfileCompanyInputAccountState extends State<ProfileCompanyInputAccount> {
  final _companyNameController = TextEditingController();
  final _companyWebsiteController = TextEditingController();
  final _companyDescriptionController = TextEditingController();
  Color textColor = Color(0xFF6C6C6C);
  Color textFieldColor = Color(0xFF6C6C6C);
  final ThemeStore _themeStore = getIt<ThemeStore>();
  bool checboxValue = true;
  

  @override
  void initState(){
    super.initState();
    textColor = _themeStore.darkMode ? Colors.white : Color(0xFF6C6C6C);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
             Container(
              margin: const EdgeInsets.only(top: 50),
              child: const Text(
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                  "Welcome to Student Hub"),
            ),
                        
            SizedBox(height: 30,),
            const Text(
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                textAlign: TextAlign.left,
                "Company name"),
            SizedBox(height: 10,),
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
              borderSide: const BorderSide(color: Colors.grey, width: 0.0),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey, width: 0.0),
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: 0.0),
            ),
            border: OutlineInputBorder(borderSide: BorderSide.none),
            hintStyle: TextStyle(
              //fontFamily: "GGX88Reg_Light",

              color: Color(0xFFc6c6c6),
            ),
          ),
              onChanged: (value){},
            ),
            SizedBox(height: 20,),
            const Text(
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                textAlign: TextAlign.left,
                "Website"),
            SizedBox(height: 10,),
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
              borderSide: const BorderSide(color: Colors.grey, width: 0.0),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey, width: 0.0),
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: 0.0),
            ),
            border: OutlineInputBorder(borderSide: BorderSide.none),
            hintStyle: TextStyle(
              //fontFamily: "GGX88Reg_Light",

              color: Color(0xFFc6c6c6),
            ),
          ),
              onChanged: (value){},
            ),
            SizedBox(height: 20,),
            const Text(
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                textAlign: TextAlign.left,
                "Description"),
            SizedBox(height: 10,),
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
              borderSide: const BorderSide(color: Colors.grey, width: 0.0),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey, width: 0.0),
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: 0.0),
            ),
            border: OutlineInputBorder(borderSide: BorderSide.none),
            hintStyle: TextStyle(
              //fontFamily: "GGX88Reg_Light",

              color: Color(0xFFc6c6c6),
            ),
          ),
              onChanged: (value){},
            ),
            SizedBox(height: 20,),
             Container(
              margin: const EdgeInsets.only(top: 20),
              child: const Text(
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                  textAlign: TextAlign.left,
                  "How many people are in your company?"),
            ),
      

            SizedBox(height: 10,),
            Container(
              child: CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: EdgeInsets.all(5),
                    checkboxShape: CircleBorder(),
                    dense: true,
                    title: const Text(
                      "It's just me",
                      style: const TextStyle(
                        fontSize: 16.0,
              
                      ),
                    ),
                    value: checboxValue,
                    onChanged: ( bool? value) {
                      setState(() {
                        checboxValue = value!;
                      });
                    },
                  ),
            ),
            SizedBox(height: 90,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 15),
                  child: SizedBox(
                    width: 150,
                    child: ElevatedButton(
                      onPressed: (){},
                      child: const Text("Edit")
                      )
                    ),
                ),
        
                Container(
                  child: SizedBox(
                    width: 150,
                    child: ElevatedButton(
                      onPressed: (){}, 
                      child: const Text("Cancel")
                      )
                    ),
                ),
                


              ],
            ),

            





            

            
            
          ],
        )
      )
    );
  }
}
