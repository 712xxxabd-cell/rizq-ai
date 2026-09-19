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
        cardColor: const Color(0xFF151F32),
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
  final List<String> ideas = [];
  bool isGenerating = false;
  String aiResult = "";

  void generateIdea(String niche) async {
    setState(() { isGenerating = true; aiResult = ""; });
    await Future.delayed(const Duration(seconds: 2));
    final results = {
      "تصميم": "🎨 فكرة AI: صمم 10 لوجوهات لمتاجر إلكترونية باستخدام الذكاء الاصطناعي وبيع اللوجو بـ 15\$ على خمسات. استخدم Midjourney + Canva. ربح متوقع: 450\$ شهرياً",
      "كتابة": "✍️ فكرة AI: اكتب 20 مقال SEO بـ ChatGPT عن 'الربح من الانترنت' وبيعها لمواقع عربية بـ 8\$ للمقال. ربح متوقع: 640\$ شهرياً",
      "صور": "🖼️ فكرة AI: ولد صور جبال ومناظر طبيعية بالذكاء الاصطناعي وبيعها على Adobe Stock. كل صورة تربح 0.33\$ مدى الحياة",
    };
    setState(() { isGenerating = false; aiResult = results[niche]?? results["تصميم"]!; ideas.add(aiResult); });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: nav == 0? _buildAIHome() : nav == 1? _buildServices() : _buildProfile(),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: const Color(0xFF151F32), border: Border(top: BorderSide(color: Colors.white.withOpacity(0.1)))),
        child: BottomNavigationBar(
          currentIndex: nav, onTap: (i) => setState(() => nav = i),
          backgroundColor: Colors.transparent, selectedItemColor: const Color(0xFF38BDF8), unselectedItemColor: Colors.white38, elevation: 0, type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.auto_awesome), label: 'AI رزق'),
            BottomNavigationBarItem(icon: Icon(Icons.workspaces), label: 'الخدمات'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'حسابي'),
          ],
        ),
      ),
    );
  }

  Widget _buildAIHome() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [ShaderMask(shaderCallback: (b) => const LinearGradient(colors: [Color(0xFF38BDF8), Color(0xFF8B5CF6)]).createShader(b), child: const Text('رزق AI', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white))), const Spacer(), Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: const Color(0xFF38BDF8).withOpacity(0.2), borderRadius: BorderRadius.circular(20)), child: const Row(children: [Icon(Icons.bolt, size: 14, color: Color(0xFF38BDF8)), SizedBox(width: 4), Text('AI مفعل', style: TextStyle(fontSize: 12, color: Color(0xFF38BDF8)))]))]),
        const SizedBox(height: 8),
        const Text('حول وقتك إلى عمل بمساعدة الذكاء الاصطناعي', style: TextStyle(color: Colors.white54)),
        const SizedBox(height: 24),
        // كرت AI الرئيسي
        Container(
          width: double.infinity, padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF1E293B), Color(0xFF0F172A)], begin: Alignment.topLeft, end: Alignment.bottomRight), borderRadius: BorderRadius.circular(24), border: Border.all(color: const Color(0xFF38BDF8).withOpacity(0.3))),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: const Color(0xFF38BDF8), borderRadius: BorderRadius.circular(10)), child: const Icon(Icons.smart_toy, color: Colors.black, size: 20)), const SizedBox(width: 10), const Text('مساعد رزق الذكي', style: TextStyle(fontWeight: FontWeight.bold))]),
            const SizedBox(height: 12),
            const Text('ماذا تريد أن تفعل اليوم؟', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            if (isGenerating) const Center(child: CircularProgressIndicator(color: Color(0xFF38BDF8))),
            if (aiResult.isNotEmpty) Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.black.withOpacity(0.3), borderRadius: BorderRadius.circular(12)), child: Text(aiResult, style: const TextStyle(height: 1.6))),
            if (!isGenerating && aiResult.isEmpty) Row(children: [
              Expanded(child: _aiButton('تصميم', Icons.brush, () => generateIdea('تصميم'))),
              const SizedBox(width: 10),
              Expanded(child: _aiButton('كتابة', Icons.edit, () => generateIdea('كتابة'))),
            ]),
            const SizedBox(height: 10),
            if (!isGenerating && aiResult.isEmpty) _aiButton('توليد صور جبال', Icons.landscape, () => generateIdea('صور'), full: true),
            if (aiResult.isNotEmpty) SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => setState(() => aiResult = ""), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF38BDF8)), child: const Text('فكرة أخرى ✨', style: TextStyle(color: Colors.black)))),
          ]),
        ),
        const SizedBox(height: 20),
        const Text('أفكار ولدها الذكاء لك', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        if (ideas.isEmpty) Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: const Color(0xFF151F32), borderRadius: BorderRadius.circular(16)), child: const Center(child: Text('لم تولد أي فكرة بعد.. اضغط تصميم أو كتابة فوق', style: TextStyle(color: Colors.white38)))),
       ...ideas.reversed.map((e) => Container(margin: const EdgeInsets.only(bottom: 8), padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: const Color(0xFF151F32), borderRadius: BorderRadius.circular(14)), child: Text(e, style: const TextStyle(fontSize: 13)))),
      ]),
    );
  }

  Widget _aiButton(String t, IconData ic, VoidCallback onTap, {bool full = false}) => InkWell(onTap: onTap, child: Container(padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14), decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF38BDF8), Color(0xFF8B5CF6)]), borderRadius: BorderRadius.circular(12)), child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(ic, size: 18, color: Colors.black), const SizedBox(width: 6), Text(t, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 13))])));

  Widget _buildServices() => ListView(padding: const EdgeInsets.all(16), children: [
    const Text('خدمات مقترحة بالذكاء الاصطناعي', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    const SizedBox(height: 12),
    _serviceCard('تصميم شعار بالذكاء الاصطناعي', '\$10', 'أحمد', '4.9', 'سيولد لك AI 5 شعارات احترافية'),
    _serviceCard('كتابة محتوى تسويقي AI', '\$15', 'سارة', '4.8', 'محتوى جاهز للنشر مولد بالذكاء الاصطناعي'),
    _serviceCard('توليد صور جبال للبيع', '\$5', 'خالد', '4.7', 'صور 4K مولدة بالذكاء الاصطناعي'),
  ]);
  Widget _serviceCard(String title, String price, String name, String rate, String desc) => Container(margin: const EdgeInsets.only(bottom: 12), padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: const Color(0xFF151F32), borderRadius: BorderRadius.circular(16)), child: Row(children: [Container(width: 50, height: 50, decoration: BoxDecoration(color: const Color(0xFF38BDF8).withOpacity(0.2), borderRadius: BorderRadius.circular(12)), child: const Icon(Icons.auto_awesome, color: Color(0xFF38BDF8))), const SizedBox(width: 12), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)), Text(desc, style: const TextStyle(fontSize: 11, color: Colors.white54)), const SizedBox(height: 4), Text('$name • $rate ⭐', style: const TextStyle(fontSize: 11, color: Colors.white38))])), Text(price, style: const TextStyle(color: Color(0xFF38BDF8), fontWeight: FontWeight.bold))]));

  Widget _buildProfile() => const Center(child: Text('حسابي - قريباً ربط مع AI حقيقي', style: TextStyle(color: Colors.white54)));
}
