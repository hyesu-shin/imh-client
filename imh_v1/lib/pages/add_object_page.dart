// Object 추가 페이지

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/object_bloc/object_bloc.dart';
import '../blocs/object_bloc/object_event.dart';
import '../models/object_model.dart';

class AddObjectPage extends StatefulWidget {
  @override
  _AddObjectPageState createState() => _AddObjectPageState();
}

class _AddObjectPageState extends State<AddObjectPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  bool _isRegistrationMode = true; // 등록 모드

  // Dynamic key-value pair list
  List<Map<String, String>> _dynamicFields = [];

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _startDateController.dispose();
    super.dispose();
  }

  void _addDynamicField() {
    setState(() {
      _dynamicFields.add({'option': '', 'key1': '', 'key2': ''});
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
        endDate: _endDateController.text,
        dynamicFields: _dynamicFields,
      );

      // Dispatch the event to add the object
      context.read<ObjectBloc>().add(AddObjectEvent(newObject));

      // Clear the form after submission
      _nameController.clear();
      _descriptionController.clear();
      _startDateController.clear();
      _endDateController.clear();
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
                        '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}';
                  }
                },
              ),
              SizedBox(height: 16),

               // End date picker
              TextFormField(
                controller: _endDateController,
                readOnly: true,
                enabled: !_isRegistrationMode, // 등록 모드에서는 비활성화
                decoration: InputDecoration(
                  labelText: '종료일',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                onTap: !_isRegistrationMode ? () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (selectedDate != null) {
                    _startDateController.text =
                        '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}';
                  }
                } : null,
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
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelText: '옵션 선택',
                            border: OutlineInputBorder(),
                          ),
                          items: [
                            DropdownMenuItem(value: '실', child: Text('실')),
                            DropdownMenuItem(value: '바늘', child: Text('바늘')),
                            DropdownMenuItem(value: '기타', child: Text('기타')),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _dynamicFields[index]['option'] = value ?? '';
                            });
                          },
                        ),
                      ),
                      SizedBox(width: 8),
                       if (field['option'] == '실' || field['option'] == '바늘') ...[
                        Expanded(
                          child: TextFormField(
                            initialValue: field['key1'],
                            decoration: InputDecoration(
                              labelText:
                                  field['option'] == '실' ? '실 이름' : '바늘 이름',
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (value) {
                              _dynamicFields[index]['key1'] = value;
                            },
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: TextFormField(
                            initialValue: field['key2'],
                            decoration: InputDecoration(
                              labelText:
                                  field['option'] == '실' ? '색' : '사이즈',
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (value) {
                              _dynamicFields[index]['key2'] = value;
                            },
                          ),
                        ),
                      ] else ...[
                        Expanded(
                          child: TextFormField(
                            initialValue: field['key1'],
                            decoration: InputDecoration(
                              labelText: '부자재',
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (value) {
                              _dynamicFields[index]['key1'] = value;
                            },
                          ),
                        ),
                      ],
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