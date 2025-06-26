import 'package:flutter/material.dart';
import 'package:material_guide_app/bottom_sheet.dart';
import 'package:material_guide_app/expansion_panel.dart';
import 'package:material_guide_app/modal_bottom_sheet.dart';
import 'package:material_guide_app/persistent_bottom_sheet.dart';
import 'package:material_guide_app/snack_bar_demo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Widget Examples'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildDemoCard(
            context,
            title: 'Bottom Sheet Demo',
            description: 'Ví dụ về Bottom Sheet cơ bản',
            icon: Icons.arrow_upward,
            color: Colors.blue,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const BottomSheetDemo()),
            ),
          ),
          const SizedBox(height: 16),
          _buildDemoCard(
            context,
            title: 'Modal Bottom Sheet',
            description: 'Ví dụ về Modal Bottom Sheet với nhiều tính năng',
            icon: Icons.notifications,
            color: Colors.orange,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ModalBottomDemo()),
            ),
          ),
          const SizedBox(height: 16),
          _buildDemoCard(
            context,
            title: 'Persistent Bottom Sheet',
            description: 'Ví dụ về Persistent Bottom Sheet với giỏ hàng',
            icon: Icons.shopping_cart,
            color: Colors.green,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => PersistentBottomSheetDemo()),
            ),
          ),
          const SizedBox(height: 16),
          _buildDemoCard(
            context,
            title: 'Expansion Panel',
            description: 'Ví dụ về Expansion Panel với thông tin cá nhân',
            icon: Icons.expand_more,
            color: Colors.purple,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ExpansionPanelDemo()),
            ),
          ),
          const SizedBox(height: 16),
          _buildDemoCard(
            context,
            title: 'Snack Bar',
            description: 'Ví dụ về các loại Snack Bar khác nhau',
            icon: Icons.message,
            color: Colors.red,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SnackBarDemo()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDemoCard(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: Colors.grey[400], size: 16),
            ],
          ),
        ),
      ),
    );
  }
}
