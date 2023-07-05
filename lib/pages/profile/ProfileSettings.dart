import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:country_calling_code_picker/picker.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:nix/widgets/avatar.dart';
import 'package:fluttermoji/fluttermoji.dart';

class ProfileSettings extends StatefulWidget {
  @override
  _ProfileSettingsState createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {

  final _formKey = GlobalKey<FormState>();
  DateTime date = DateTime(1900, 01, 01);
  final _listGenderText = ["Male", "Female"];
  var _tabTextIndexSexSelected = 0;
  final _listIconTabToggle = [Icons.man, Icons.woman,];
  Country? _selectedCountry;

  @override
  void initState() {
    initCountry();
    super.initState();
  }

  void initCountry() async {
    final country = await getDefaultCountry(context);
    setState(() {
      _selectedCountry = country;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final country = _selectedCountry;
    
    return 
      Column(   
      children: [
        Container(
          height: screenHeight * 0.3,
          child: Stack(
            children: [
              Container(
                width: screenWidth,
                height:screenHeight*0.2,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/profile_background.jpg'),
                    fit: BoxFit.cover))
              ),
              Align(
              alignment: Alignment.bottomCenter,
                child: Container(  
                  width: 200,
                  height:200,
                  margin: const EdgeInsets.all(2),
                  child: FluttermojiCircleAvatar(
                    backgroundColor: Colors.grey[200],
                    radius: 100,
                  ), 
              )),
              Align(
              alignment: Alignment(0.7, 0.9),
                child: Container(
                height: 35,
                child: ElevatedButton.icon(
                  icon: Icon(Icons.edit),
                  label: Text("Customize"),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(13, 42, 106, 1)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0), 
                      ),
                    ), 
                  ),
                  onPressed: () => Navigator.push(context,
                       MaterialPageRoute(builder: (context) => AvatarCustomization())),
                ),
                )
              ),
            ]
         )
        ),
    
        // parte del form
        Expanded (
        child:Container( 
          margin: const EdgeInsets.all(8),
          //width: double.infinity,
          //height: screenHeight*0.3,
          child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget> [
                Padding(
                  padding: const EdgeInsets.all(20),
                    child: 
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Name:',
                        labelStyle: TextStyle(fontSize: 20.0),
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Name required';
                        }
                          return null;
                    },),),
      
                Padding(
                  padding: const EdgeInsets.all(20),
                    child:
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Last Name:',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
                      ),
                      validator: (value) {
                         if (value!.trim().isEmpty) {
                           return 'Last name required';
                         }
                         return null;
                    },),),   
      
                Padding(
                  padding: const EdgeInsets.all(20),
                    child:
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Nickame:',
                        labelStyle: TextStyle(fontSize: 20.0),
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
                      ),),), 
      
                Padding(
                padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      
                      ElevatedButton(
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(13, 42, 106, 1)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0), 
                          ),
                        ), 
                        ) ,
                        child: const Text('Select your date of birthday:'),
                          onPressed: () async {
                            DateTime? newDate = await showDatePicker(
                              context: context,
                              initialDate: date,
                              firstDate: DateTime(1900), 
                              lastDate: DateTime(2100),
                            );
                            if (newDate == null) return;
                            setState(() => date = newDate);
                          }
                      ),
      
                      Text('${date.day}/${date.month}/${date.year}',
                        style: const TextStyle(
                          fontSize: 20)),
      
                    ],),),
      
                Padding(
                  padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("Select your sex : ", 
                        style: TextStyle(fontSize: 16)),
                        FlutterToggleTab(
                          width: 60,
                          borderRadius: 20,
                          selectedIndex: _tabTextIndexSexSelected,
                          selectedBackgroundColors: const [Color.fromRGBO(13, 42, 106, 1),  Colors.greenAccent],
                          selectedTextStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                          unSelectedTextStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                          labels: _listGenderText,
                          icons: _listIconTabToggle,
                          selectedLabelIndex: (index) {
                            setState(() {
                             _tabTextIndexSexSelected = index;
                            });
                          },
                          marginSelected:
                          const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                        ),
                        ])),
      
                Padding(   //SISTEMARE (NON serve avere un doppio scroll view)
                  padding: const EdgeInsets.all(0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const Text("Select your country : ", style: TextStyle(fontSize: 20)),
                          country == null
                          ? Container()
                          : Column(
                          children: <Widget>[
                            Image.asset(
                              country.flag,
                              package: countryCodePackageName,
                              width: 100,
                            ),
                          const SizedBox(height: 10),
                          Text('${country.callingCode} ${country.name} (${country.countryCode})', textAlign: TextAlign.center, style: const TextStyle(fontSize: 18)),
                          ],),
                          const SizedBox(height: 10),
                            MaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0), // Imposta il raggio dei bordi
                              ),
                              color: Color.fromRGBO(13, 42, 106, 1),
                                textColor: Colors.white,
                                onPressed: _onPressedShowDialog,
                              child: const Text('Select Country')),],),),),
      
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(13, 42, 106, 1)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0), 
                      ),
                    ), ),
                      onPressed: () {
                       // Validate returns true if the form is valid, or false otherwise.
                        if (_formKey.currentState!.validate()) {
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.
                          ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                          );
                        }
                        else{
                          final snackBar= SnackBar(
                            elevation:0,
                            backgroundColor: Colors.transparent,
                            behavior: SnackBarBehavior.floating,
                            
                            content: AwesomeSnackbarContent(
                              title: 'Warning', 
                              message: 'Remember to fill in all requied fields ', 
                              contentType: ContentType.failure,
                              ),
                            );
                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(snackBar);
    
                        }
                      },
                      child: const Text('Save'),
                    ),),
      
                    
      
      
              ],
      
            ),
      
          ),
          
        ))
        )
      
        ],);

       
  }
  void _onPressedShowDialog() async {
    final country = await showCountryPickerDialog(context,
    );
    if (country != null) {
      setState(() {
        _selectedCountry = country;
      });
    }
  }
}