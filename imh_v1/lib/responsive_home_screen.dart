import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

class ResponsiveHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return _buildTabletLayout(); // 태블릿 레이아웃
        } else {
          return HomeScreen(); // 모바일 레이아웃
        }
      },
    );
  }

  // Widget _buildMobileLayout() {
  //   return Scaffold(
  //     appBar: AppBar(title: Text('Mobile View')),
  //     body: SingleChildScrollView(
  //       child: Column(
  //         children: [
  //           Text('모바일 UI'),
  //           // 추가적인 모바일 UI 구성
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _buildTabletLayout() {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.blue.shade100,
              child: Center(
                child: Text(
                  'In My Hands',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
            ),
          ),
          // 오른쪽에 HomeScreen 표시
          Expanded(
            flex: 3,
            child: HomeScreen(), // HomeScreen을 여기에 표시
          ),
        ],
      ),
    );
  }
}
