import 'package:flutter/material.dart';

class Item {
  String title;
  String body;
  bool isExpanded;
  IconData icon;

  Item(
      {required this.title,
      required this.body,
      required this.icon,
      this.isExpanded = false});
}

class ExpansionPanelDemo extends StatefulWidget {
  const ExpansionPanelDemo({super.key});

  @override
  State<ExpansionPanelDemo> createState() => _ExpansionPanelDemoState();
}

class _ExpansionPanelDemoState extends State<ExpansionPanelDemo> {
  final List<Item> _items = [
    Item(
      title: 'Thông tin cá nhân',
      body:
          'Họ tên: Nguyễn Văn A\nTuổi: 25\nĐịa chỉ: Hà Nội\nSố điện thoại: 0123456789',
      icon: Icons.person,
    ),
    Item(
      title: 'Học vấn',
      body:
          'Đại học: XYZ University\nChuyên ngành: Công nghệ thông tin\nTốt nghiệp: 2020',
      icon: Icons.school,
    ),
    Item(
      title: 'Kinh nghiệm làm việc',
      body:
          '2020-2021: Công ty ABC\n2021-2023: Công ty XYZ\n2023-nay: Công ty DEF',
      icon: Icons.work,
    ),
    Item(
      title: 'Kỹ năng',
      body:
          '- Lập trình Flutter/Dart\n- React Native\n- JavaScript/TypeScript\n- Node.js',
      icon: Icons.code,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hồ sơ cá nhân'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                for (var item in _items) {
                  item.isExpanded = false;
                }
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ExpansionPanelList(
            elevation: 3,
            expandedHeaderPadding: const EdgeInsets.all(8),
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                _items[index].isExpanded = !isExpanded;
              });
            },
            children: _items.map<ExpansionPanel>((Item item) {
              return ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    leading: Icon(item.icon),
                    title: Text(
                      item.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
                body: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.body,
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Chỉnh sửa ${item.title}'),
                                  duration: const Duration(seconds: 1),
                                ),
                              );
                            },
                            child: const Text('Chỉnh sửa'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                isExpanded: !item.isExpanded,
              );
            }).toList(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            for (var item in _items) {
              item.isExpanded = !item.isExpanded;
            }
          });
        },
        tooltip: 'Mở rộng tất cả',
        child: const Icon(Icons.expand),
      ),
    );
  }
}
