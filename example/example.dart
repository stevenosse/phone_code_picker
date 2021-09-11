
import 'package:flutter/material.dart';
import 'package:phone_code_picker/phone_code_picker.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  ///variable
  String _selectedCode='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text('Phone code picker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: TextButton(
              onPressed: _pickCode,
              child: Text('Pick phone code'),
            ),
          ),

          ///selected code will set here.
          Text('$_selectedCode'),
        ],
      ),
    );
  }

  void _pickCode(){
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      enableDrag: true,
      ///make sure to set isScrollControlled  true
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(10),
            topLeft: Radius.circular(10),
          )
      ),
      builder: (_) => Container(
        ///make sure to set bottom padding
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewPadding.bottom),
        child: PhoneCodePicker(
          ///set you primary color here to mach your app theme.
          primaryColor: Colors.deepOrange,
          onSelected: (country) {
            setState(() {
              _selectedCode = country.dialCode;
            });
          },
        ),
      ),
    );
  }
}
