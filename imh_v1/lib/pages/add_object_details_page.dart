// Object 추가 페이지

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/object_bloc/object_bloc.dart';
import '../blocs/object_bloc/object_event.dart';
import '../blocs/object_bloc/object_state.dart';

class AddObjectDetailsPage extends StatelessWidget {
  final String object;

  AddObjectDetailsPage({required this.object});

  @override
  Widget build(BuildContext context) {
    // Form key for validation
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: Text('오브젝트 생성'),
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            }
          )
        ]
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Image placeholder with upload button
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
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: '오브젝트 설명',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),

              // Start date picker
              TextFormField(
                
              )
            ]
          )
        )
      )
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<ObjectBloc>().add(AddObjectEvent(object));
        },
        child: Icon(Icons.save),
      ),
    );
  }
}