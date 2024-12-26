import 'package:flutter/material.dart';
import '../widgets/item_selection_bottom_sheet.dart';
import '../widgets/calendar_widget.dart';
import '../widgets/record_list_widget.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'In My Hands',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CalendarWidget(),
            ),
            // Removed Expanded widget here
            SingleChildScrollView(
              child: Column(
                children: [
                  // RecordListWidget(),
                ],
              ),
            ),
          ],
        )
      ),
      // body: CalendarWidget(), // 캘린더 컴포넌트를 표시
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.pushNamed(context, '/add-event');
          // 아이템 목록 바텀시트를 호출
          showModalBottomSheet(
            context: context, 
            builder: (BuildContext context) {
              return ItemSelectionBottomSheet(heightFactor: 0.9);
            }
          );
        },
        child: Icon(Icons.add)
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: '캘린더'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: '알림'),
        ],
      ),
    );
  }
}