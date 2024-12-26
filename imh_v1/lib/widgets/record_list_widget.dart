import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/record_model.dart';

class RecordListWidget extends StatefulWidget {
  @override
  _RecordListWidgetState createState() => _RecordListWidgetState();
}

class _RecordListWidgetState extends State<RecordListWidget> {
  late Box<RecordModel> _recordBox;

  @override
  void initState() {
    super.initState();
    _recordBox = Hive.box<RecordModel>('records_box');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('레코드 리스트')),
      body: Column(  // Use Column here to allow Expanded widget usage
        children: [
          ValueListenableBuilder(
            valueListenable: _recordBox.listenable(),
            builder: (context, Box<RecordModel> box, _) {
              if (!box.isOpen || box.values.isEmpty) {
                return Center(
                  child: Text('기록을 로드할 수 없습니다.'),
                );
              }

              // Assuming _selectedDay is defined somewhere in the widget
              // final records = box.values
              //     .where((record) => isSameDay(record.date, _selectedDay)) // Ensure `isSameDay` and `_selectedDay` are defined
              //     .toList();

              // if (records.isEmpty) {
              //   return Center(
              //     child: Text('이 날짜에 기록이 없습니다.'),
              //   );
              // }

              final records = box.values.toList();

              return ListView.builder(
                itemCount: records.length,
                itemBuilder: (context, index) {
                  final record = records[index];
                  return ListTile(
                    title: Text(record.title),
                    subtitle: Text(record.description ?? ''),
                    onTap: () {
                      // 기록 상세 페이지로 이동 (필요 시 추가 구현)
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}