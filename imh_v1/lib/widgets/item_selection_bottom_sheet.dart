import 'package:flutter/material.dart';
import '../pages/add_object_details_page.dart';

class ItemSelectionBottomSheet extends StatelessWidget {
  final List<String> items = ['아이템 1', '아이템 2', '아이템 3'];

  // 높이를 부모 컨테이너에 종속적으로 설정할 수 있도록 heightFactor 추가
  final double heightFactor;

  ItemSelectionBottomSheet({required this.heightFactor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * heightFactor,
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
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
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(items[index]),
                  onTap: () {
                    // 아이템 선택 시 동작
                    Navigator.pop(context); // 바텀시트 닫기
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddItemDetailsPage(item: items[index]),
                      ),
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
                    builder: (context) => AddObjectDetailsPage(),
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

// 페이지 이동용 예시 페이지
class AddItemDetailsPage extends StatelessWidget {
  final String item;

  AddItemDetailsPage({required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$item 세부 정보')),
      body: Center(child: Text('$item 정보를 추가하세요.')),
    );
  }
}

// Object 추가 페이지
// class AddObjectDetailsPage extends StatelessWidget {
//   final String object;

//   AddObjectDetailsPage({required this.object});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('$object 세부 정보')),
//       body: Center(child: Text('$object 정보를 추가하세요.')),
//     );
//   }
// }