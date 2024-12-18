import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/object_model.dart';
import '../pages/add_object_page.dart';
import '../pages/add_record_page.dart';

class ItemSelectionBottomSheet extends StatelessWidget {
  // 높이를 부모 컨테이너에 종속적으로 설정할 수 있도록 heightFactor 추가
  final double heightFactor;

  ItemSelectionBottomSheet({required this.heightFactor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * heightFactor,
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            spreadRadius: 5.0,
            offset: Offset(0, -3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('아이템을 선택하세요', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: Hive.box<ObjectModel>('objects_box').listenable(),
              builder: (context, Box<ObjectModel> box, _) {
                final objects = box.values.toList();

                return ListView.builder(
                  itemCount: objects.length,
                  itemBuilder: (context, index) {
                    final object = objects[index];
                    return ListTile(
                      title: Text(object.name),
                      onTap: () {
                        Navigator.pop(context); // 바텀시트 닫기
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddRecordPage(objectId: object.id, objectName: object.name),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
          SizedBox(height: 16), // 버튼과 리스트 간의 간격
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddObjectPage(),
                  ),
                );
              },
              child: Text('새 아이템 추가'),
            )
          )
        ],
      ),
    );
  }
}
