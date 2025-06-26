import 'package:flutter/material.dart';

class FormControlDemo extends StatefulWidget {
  const FormControlDemo({super.key});

  @override
  State<StatefulWidget> createState() {
    return _FormControlSate();
  }
}

class _FormControlSate extends State<FormControlDemo> {
  String? selectedValue;
  bool isChecked = false;
  bool isSwitch = false;
  String selectedItem = 'A';
  bool isChoiceChip = false;
  Set<String> selected = {'A'};
  List<String> options = ['Nam', 'Nữ', 'Khác'];
  String? selectedOption;
  List<String> optionsCheckbox = ['Flutter', 'React Native', 'Swift', 'Kotlin'];
  List<String> selectedCheckbox = [];
  double _currentValue = 50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("form demo")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TextField
            Padding(
              padding: EdgeInsets.only(bottom: 16.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Họ và tên',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  print("Họ và tên : $value");
                },
              ),
            ),

            // Checkbox
            Padding(
              padding: EdgeInsets.only(bottom: 16.0),
              child: Row(
                children: [
                  Checkbox(
                    value: isChecked,
                    onChanged: (bool? newValue) {
                      setState(() {
                        isChecked = newValue!;
                        print('Check box: $newValue');
                      });
                    },
                  ),
                  Text('Checkbox'),
                ],
              ),
            ),

            //Checkbox List Group
            Padding(
              padding: EdgeInsets.only(bottom: 16.0),
              child: Container(
                height: 200, // Chiều cao cố định
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: optionsCheckbox.map((e) {
                      return CheckboxListTile(
                        title: Text(e),
                        value: selectedCheckbox.contains(e),
                        onChanged: (bool? value) {
                          setState(() {
                            if (value == true) {
                              selectedCheckbox.add(e);
                            } else {
                              selectedCheckbox.remove(e);
                            }
                            print("Check box group: $selectedCheckbox");
                          });
                        },
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),

            // Single Radio
            Padding(
              padding: EdgeInsets.only(bottom: 16.0),
              child: Row(
                children: [
                  Radio(
                    value: 'nam',
                    groupValue: selectedValue,
                    onChanged: (String? value) {
                      setState(() {
                        selectedValue = value;
                        print("radio: $value");
                      });
                    },
                  ),
                  Text('Nam'),
                ],
              ),
            ),

            // Radio List Group
            Padding(
              padding: EdgeInsets.only(bottom: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Giới tính:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  ...options.map((option) {
                    return RadioListTile<String>(
                      title: Text(option),
                      value: option,
                      groupValue: selectedOption,
                      onChanged: (String? value) {
                        setState(() {
                          selectedOption = value;
                          print('Giới tính $selectedOption');
                        });
                      },
                    );
                  }).toList(),
                ],
              ),
            ),

            // Switch
            Padding(
              padding: EdgeInsets.only(bottom: 16.0),
              child: Row(
                children: [
                  Switch(
                    value: isSwitch,
                    onChanged: (bool value) {
                      setState(() {
                        isSwitch = value;
                        print("switch: $value");
                      });
                    },
                  ),
                  Text('Switch'),
                ],
              ),
            ),

            // Dropdown
            Padding(
              padding: EdgeInsets.only(bottom: 16.0),
              child: Row(
                children: [
                  Text('Dropdown: '),
                  DropdownButton<String>(
                    value: selectedItem,
                    items: ['A', 'B', 'C'].map((item) {
                      return DropdownMenuItem(value: item, child: Text(item));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedItem = value!;
                        print("dropdown: $value");
                      });
                    },
                  ),
                ],
              ),
            ),

            // Choice Chip
            Padding(
              padding: EdgeInsets.only(bottom: 16.0),
              child: ChoiceChip(
                label: Text("Choice Chip"),
                selected: isChoiceChip,
                onSelected: (bool selected) {
                  setState(() {
                    isChoiceChip = selected;
                    print("choice chip $isChoiceChip");
                  });
                },
              ),
            ),

            // Segmented Button
            Padding(
              padding: EdgeInsets.only(bottom: 16.0),
              child: SegmentedButton<String>(
                segments: [
                  ButtonSegment(value: 'A', label: Text('A')),
                  ButtonSegment(value: 'B', label: Text('B')),
                  ButtonSegment(value: 'C', label: Text('C')),
                ],
                selected: selected,
                onSelectionChanged: (newSelection) {
                  setState(() {
                    selected = newSelection;
                    print("Segment $selected");
                  });
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: Slider(
                value: _currentValue,
                min: 0,
                max: 100,
                divisions: 10,
                onChanged: (double value) {
                  setState(() {
                    _currentValue = value;
                    print("slider value: $_currentValue");
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
