import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'رزق AI',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: const Color(0xFF6C5CE7),
        scaffoldBackgroundColor: const Color(0xFF0F0F13),
      ),
      home: const Directionality(
        textDirection: TextDirection.rtl,
        child: MainShell(),
      ),
    );
  }
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});
  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int index = 0;
  final pages = const [HomePage(), AiPage(), ServicesPage(), ProfilePage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('رزق AI')),
      body: IndexedStack(index: index, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (v) => setState(() => index = v),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'الرئيسية'),
          NavigationDestination(icon: Icon(Icons.smart_toy), label: 'AI'),
          NavigationDestination(icon: Icon(Icons.work), label: 'الخدمات'),
          NavigationDestination(icon: Icon(Icons.person), label: 'حسابي'),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  void showIdeas(BuildContext context) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (_) => const Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('أفكار للعمل', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 14),
              Text('• منشورات وإعلانات'),
              SizedBox(height: 8),
              Text('• ولا يوجد ربح مضمون'),
            ]),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return ListView(padding: const EdgeInsets.all(16), children: [
        Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Icon(Icons.auto_awesome, size: 32),
                const SizedBox(height: 12),
                const Text('حول وقتك إلى عمل'),
                const SizedBox(height: 8),
                const Text('أدوات AI جاهزة لتساعدك'),
                const SizedBox(height: 12),
                FilledButton.icon(onPressed: () => showIdeas(context), icon: const Icon(Icons.lightbulb), label: const Text('أفكار للعمل')),
              ]))),
        const SizedBox(height: 20),
        const Text('ماذا تريد أن تفعل؟'),
        const SizedBox(height: 10),
        const Row(children: [
            Expanded(child: Feature(icon: Icons.design_services, title: 'تصميم')),
            SizedBox(width: 12),
            Expanded(child: Feature(icon: Icons.edit, title: 'كتابة')),
          ]),
        const SizedBox(height: 20),
        const Text('خدمات مقترحة'),
        const SizedBox(height: 10),
        const ServiceTile(title: 'تصميم شعار', seller: 'أحمد', price: '\$10'),
        const ServiceTile(title: 'كتابة محتوى', seller: 'سارة', price: '\$15'),
      ]);
  }
}

class Feature extends StatelessWidget {
  final IconData icon; final String title;
  const Feature({super.key, required this.icon, required this.title});
  @override
  Widget build(BuildContext context) {
    return Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(children: [Icon(icon), const SizedBox(height: 8), Text(title)])));
  }
}

class AiPage extends StatefulWidget {
  const AiPage({super.key});
  @override
  State<AiPage> createState() => _AiPageState();
}
class _AiPageState extends State<AiPage> {
  final input = TextEditingController(); bool loading = false; String result = '';
  void generate() {
    final p = input.text.trim();
    if (p.isEmpty) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('اكتب فكرتك أولا'))); return; }
    setState(() => loading = true);
    Future.delayed(const Duration(seconds: 2), () { if (!mounted) return; setState(() { loading = false; result = 'نتيجة مقترحة لـ: $p\n\n1. فكرة إعلان\n2. وصف للخدمة\n3. هاشتاقات'; }); });
  }
  @override
  void dispose() { input.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    return ListView(padding: const EdgeInsets.all(16), children: [
        const Text('AI مساعد رزق', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text('اكتب فكرتك وليس متصلا بخدمة خارجية'),
        const SizedBox(height: 18),
        TextField(controller: input, decoration: const InputDecoration(labelText: 'ماذا تريد أن تنشئ؟', border: OutlineInputBorder())),
        const SizedBox(height: 12),
        FilledButton.icon(onPressed: loading ? null : generate, icon: const Icon(Icons.auto_awesome), label: Text(loading ? 'جاري التفكير...' : 'توليد')),
        if (result.isNotEmpty) ...[const SizedBox(height: 16), Card(child: Padding(padding: const EdgeInsets.all(16), child: Text(result)))]
      ]);
  }
}

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});
  @override
  Widget build(BuildContext context) {
    final data = [
  ('تصميم شعار وهوية بسيطة', 'مصمم'),
  ('تصميم منشور إعلاني', 'مصمم سوشيال'),
  ('كتابة وصف للمنتجات', 'كاتب محتوى'),
  ('ترجمة عربية - إنجليزية', 'مترجم'),
];
    return ListView(padding: const EdgeInsets.all(16), children: [
        const Text('سوق الخدمات', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ...data.map((s) => Card(margin: const EdgeInsets.only(bottom: 8), child: ListTile(title: Text(s.$1), subtitle: Text(s.$2)))),
      ]);
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView(padding: const EdgeInsets.all(16), children: [
        const Center(child: CircleAvatar(radius: 40, child: Icon(Icons.person, size: 40))),
        const SizedBox(height: 12),
        const Center(child: Text('مرحبا بك في رزق AI')),
        const SizedBox(height: 16),
        const Card(child: Column(children: [ListTile(leading: Icon(Icons.settings), title: Text('الإعدادات')), ListTile(leading: Icon(Icons.help), title: Text('المساعدة')), ListTile(leading: Icon(Icons.info), title: Text('عن التطبيق'))])),
      ]);
  }
}

class ServiceTile extends StatelessWidget {
  final String title, seller, price;
  const ServiceTile({super.key, required this.title, required this.seller, required this.price});
  @override
  Widget build(BuildContext context) {
    return Card(margin: const EdgeInsets.only(bottom: 8), child: ListTile(title: Text(title), subtitle: Text(seller), trailing: Text(price)));
  }
}
