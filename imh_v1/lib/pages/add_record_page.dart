import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/record_bloc/record_bloc.dart';
import '../blocs/record_bloc/record_event.dart';
import '../models/record_model.dart';


class AddRecordPage extends StatefulWidget {
  final String objectId;
  final String objectName;

  AddRecordPage({required this.objectId, required this.objectName});
  
  @override
  _AddRecordPageState createState() => _AddRecordPageState();
}

class _AddRecordPageState extends State<AddRecordPage> {
  final _formKey = GlobalKey<FormState>();
  final _dateController = TextEditingController();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _statusController = TextEditingController();

  @override
  void dispose() {
    _dateController.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    _statusController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      DateTime date;

      try {
        // Only convert if the text is not empty
        date = DateTime.parse(_dateController.text);

      } catch (e) {
        // Handle parsing error (invalid date format)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('날짜 형식이 올바르지 않습니다.')),
        );
        return;
      }

      // Build the record data
      final newRecord = RecordModel(
        date: date,
        objectId: widget.objectId,
        title: _titleController.text,
        description: _descriptionController.text,
        status: _statusController.text,
      );

      // Dispatch the event to add the object
      context.read<RecordBloc>().add(AddRecordEvent(newRecord));

      // Clear the form after submission
      _dateController.clear();
      _titleController.clear();
      _descriptionController.clear();
      _statusController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Record added successfully!')),
      );

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('오늘의 기록'),
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
              // date picker
              TextFormField(
                controller: _dateController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: '날짜',
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
                    _dateController.text =
                        '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}';
                  }
                },
              ),
              SizedBox(height: 16),

              // Object name field
              TextFormField(
                controller: TextEditingController(text: widget.objectName), // object.name을 표시
                decoration: InputDecoration(
                  labelText: '오브젝트 이름',
                  border: OutlineInputBorder(),
                ),
                enabled: false, // 입력 비활성화
                style: TextStyle(color: Colors.grey), // 비활성화 시 텍스트 색상 설정
              ),
              SizedBox(height: 16),

              // Record status field
              TextFormField(
                controller: _statusController,
                decoration: InputDecoration(
                  labelText: '상태',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),

              // Record title field
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: '레코드 제목',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),

              // Object description field
              TextFormField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: '레코드 설명',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),

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