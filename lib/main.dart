import 'dart:async';
import 'package:flutter/material.dart';

void main() => runApp(const RizqAIApp());

class RizqAIApp extends StatelessWidget {
  const RizqAIApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0B1120),
      ),
      home: const AIHome(),
    );
  }
}

class AIHome extends StatefulWidget {
  const AIHome({super.key});
  @override
  State<AIHome> createState() => _AIHomeState();
}

class _AIHomeState extends State<AIHome> {
  int nav = 0;
  bool isGenerating = false;
  String aiResult = "";
  final List<String> ideas = [];

  void generateIdea(String niche) async {
    setState(() { isGenerating = true; aiResult = ""; });
    await Future.delayed(const Duration(seconds: 2));
    final results = {
      "تصميم": "🎨 فكرة AI: صمم 10 لوجوهات بالذكاء الاصطناعي وبيع اللوجو بـ 15\$. ربح متوقع 450\$ شهرياً",
      "كتابة": "✍️ فكرة AI: اكتب 20 مقال SEO بـ AI وبيعها بـ 8\$ للمقال",
      "صور": "🖼️ فكرة AI: ولد صور جبال بالذكاء الاصطناعي وبيعها على Adobe Stock",
    };
    setState(() { isGenerating = false; aiResult = results[niche]!; ideas.add(aiResult); });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: nav == 0? buildAI() : buildServices()),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: nav, onTap: (i) => setState(() => nav = i),
        backgroundColor: const Color(0xFF151F32),
        selectedItemColor: const Color(0xFF38BDF8), unselectedItemColor: Colors.white38,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.auto_awesome), label: 'AI رزق'),
          BottomNavigationBarItem(icon: Icon(Icons.workspaces), label: 'الخدمات'),
        ],
      ),
    );
  }

  Widget buildAI() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('رزق AI', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        const Text('حول وقتك إلى عمل بمساعدة الذكاء الاصطناعي', style: TextStyle(color: Colors.white54)),
        const SizedBox(height: 24),
        Container(
          width: double.infinity, padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(color: const Color(0xFF151F32), borderRadius: BorderRadius.circular(24), border: Border.all(color: const Color(0xFF38BDF8).withValues(alpha: 0.3))),
          child: Column(children: [
            if (isGenerating) const CircularProgressIndicator(color: Color(0xFF38BDF8)),
            if (aiResult.isNotEmpty) Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.3), borderRadius: BorderRadius.circular(12)), child: Text(aiResult)),
            if (!isGenerating && aiResult.isEmpty) Row(children: [
              Expanded(child: ElevatedButton(onPressed: () => generateIdea('تصميم'), child: const Text('تصميم'))),
              const SizedBox(width: 10),
              Expanded(child: ElevatedButton(onPressed: () => generateIdea('كتابة'), child: const Text('كتابة'))),
            ]),
            const SizedBox(height: 10),
            if (!isGenerating) SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => generateIdea('صور'), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF38BDF8)), child: const Text('توليد صور جبال ⛰️', style: TextStyle(color: Colors.black)))),
            if (aiResult.isNotEmpty) ElevatedButton(onPressed: () => setState(() => aiResult = ""), child: const Text('فكرة أخرى ✨')),
          ]),
        ),
        const SizedBox(height: 20),
       ...ideas.reversed.map((e) => Container(margin: const EdgeInsets.only(bottom: 8), padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: const Color(0xFF151F32), borderRadius: BorderRadius.circular(14)), child: Text(e, style: const TextStyle(fontSize: 13)))),
      ]),
    );
  }

  Widget buildServices() => ListView(padding: const EdgeInsets.all(16), children: const [
    Text('خدمات مقترحة بالذكاء الاصطناعي', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
  ]);
}

