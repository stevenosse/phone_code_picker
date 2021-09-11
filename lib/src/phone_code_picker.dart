import 'package:flutter/material.dart';
import 'country.dart';
import 'country_list.dart';

class PhoneCodePicker extends StatefulWidget {
  final Color primaryColor;
  final Function(Country counter) onSelected;

  const PhoneCodePicker(
      {Key? key,
      this.primaryColor = Colors.blueAccent,
      required this.onSelected})
      : super(key: key);

  @override
  _PhoneCodePickerState createState() => _PhoneCodePickerState();
}

class _PhoneCodePickerState extends State<PhoneCodePicker> {
  final _searchTextController = TextEditingController();

  final List<Country> _filterCountry = [];

  @override
  void initState() {
    super.initState();

    _filterCountry.addAll(countries);
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      child: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                decoration: BoxDecoration(
                    color: widget.primaryColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4)),
                width: 60,
                height: 8,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: widget.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(24),
            ),
            child: TextField(
              controller: _searchTextController,
              style: TextStyle(color: widget.primaryColor, fontSize: 14),
              onChanged: _onSearch,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search here..',
                  hintStyle: TextStyle(
                      color: widget.primaryColor.withOpacity(0.5),
                      fontSize: 14)),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (_, i) => ListTile(
                onTap: () {
                  Navigator.pop(context);
                  widget.onSelected(_filterCountry[i]);
                },
                leading: CircleAvatar(
                  backgroundColor: widget.primaryColor,
                  child: Text(
                    _filterCountry[i].code,
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ),
                title: Text(
                  _filterCountry[i].name,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                trailing: Text(
                  _filterCountry[i].dialCode,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              itemCount: _filterCountry.length,
            ),
          ),
        ],
      ),
    );
  }

  void _onSearch(String key) {
    _filterCountry.clear();

    countries.forEach((element) {
      if (element.name.toLowerCase().contains(key.toLowerCase()) ||
          element.code.toLowerCase().contains(key.toLowerCase()))
        _filterCountry.add(element);
    });

    setState(() {});
  }
}
