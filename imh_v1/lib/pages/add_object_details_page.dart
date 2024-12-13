// Object 추가 페이지

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/object_bloc/object_bloc.dart';
import '../blocs/object_bloc/object_event.dart';
import '../models/object_model.dart';

class AddObjectDetailsPage extends StatefulWidget {
  @override
  _AddObjectDetailsPageState createState() => _AddObjectDetailsPageState();
}

class _AddObjectDetailsPageState extends State<AddObjectDetailsPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _startDateController = TextEditingController();

  // Dynamic key-value pair list
  List<Map<String, String>> _dynamicFields = [];

  String? _selectedOption; // Dropdown value

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _startDateController.dispose();
    super.dispose();
  }

  void _addDynamicField() {
    setState(() {
      _dynamicFields.add({"key": "", "value": ""});
    });
  }

  void _removeDynamicField(int index) {
    setState(() {
      _dynamicFields.removeAt(index);
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Build the object data
      final newObject = ObjectModel(
        name: _nameController.text,
        description: _descriptionController.text,
        startDate: _startDateController.text,
        option: _selectedOption,
        dynamicFields: _dynamicFields,
      );

      // Dispatch the event to add the object
      context.read<ObjectBloc>().add(AddObjectEvent(newObject));

      // Clear the form after submission
      _nameController.clear();
      _descriptionController.clear();
      _startDateController.clear();
      _dynamicFields.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Object added successfully!')),
      );

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('오브젝트 생성'),
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Image placeholder
              GestureDetector(
                onTap: () {
                  // Add functionality to pick an image
                },
                child: Container(
                  height: 120,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.image,
                      size: 50,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Object name field
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: '오브젝트 이름',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '오브젝트 이름을 입력하세요.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Object description field
              TextFormField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: '오브젝트 설명',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),

              // Start date picker
              TextFormField(
                controller: _startDateController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: '시작일',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                onTap: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (selectedDate != null) {
                    _startDateController.text =
                        "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}";
                  }
                },
              ),
              SizedBox(height: 16),

              // Dropdown field
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: '옵션 선택',
                  border: OutlineInputBorder(),
                ),
                items: [
                  DropdownMenuItem(value: '옵션1', child: Text('옵션1')),
                  DropdownMenuItem(value: '옵션2', child: Text('옵션2')),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedOption = value;
                  });
                },
              ),
              SizedBox(height: 16),

              // Dynamic key-value fields
              ..._dynamicFields.asMap().entries.map((entry) {
                final index = entry.key;
                final field = entry.value;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          initialValue: field["key"],
                          decoration: InputDecoration(
                            labelText: '키',
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            _dynamicFields[index]["key"] = value;
                          },
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: TextFormField(
                          initialValue: field["value"],
                          decoration: InputDecoration(
                            labelText: '값',
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            _dynamicFields[index]["value"] = value;
                          },
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.remove_circle_outline),
                        onPressed: () {
                          _removeDynamicField(index);
                        },
                      ),
                    ],
                  ),
                );
              }).toList(),

              // Add more fields button
              TextButton.icon(
                onPressed: _addDynamicField,
                icon: Icon(Icons.add),
                label: Text('옵션 추가하기'),
              ),
              SizedBox(height: 16),

              // Submit button
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('완료'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}