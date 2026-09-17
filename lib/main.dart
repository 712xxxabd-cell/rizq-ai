import 'package:flutter/material.dart';

void main() => runApp(const RizqAiApp());

class RizqAiApp extends StatelessWidget {
  const RizqAiApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'رزق AI',
        theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
          colorSchemeSeed: const Color(0xFF16A34A),
          scaffoldBackgroundColor: const Color(0xFF0B1220),
        ),
        home: const Directionality(textDirection: TextDirection.rtl, child: MainShell()),
      );
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
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('رزق AI', style: TextStyle(fontWeight: FontWeight.bold)), backgroundColor: Colors.transparent),
        body: IndexedStack(index: index, children: pages),
        bottomNavigationBar: NavigationBar(
          selectedIndex: index,
          onDestinationSelected: (v) => setState(() => index = v),
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'الرئيسية'),
            NavigationDestination(icon: Icon(Icons.auto_awesome_outlined), selectedIcon: Icon(Icons.auto_awesome), label: 'AI'),
            NavigationDestination(icon: Icon(Icons.storefront_outlined), selectedIcon: Icon(Icons.storefront), label: 'الخدمات'),
            NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'حسابي'),
          ],
        ),
      );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  void open(BuildContext context, Widget page) => Navigator.push(context, MaterialPageRoute(builder: (_) => Directionality(textDirection: TextDirection.rtl, child: page)));
  @override
  Widget build(BuildContext context) => ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Icon(Icons.auto_awesome, size: 40),
                const SizedBox(height: 12),
                const Text('حوّل فكرتك إلى عمل', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Text('أدوات AI تجريبية وسوق خدمات في تطبيق عربي واحد.', style: TextStyle(color: Colors.white70, height: 1.5)),
                const SizedBox(height: 16),
                FilledButton.icon(onPressed: () => open(context, const AiPage()), icon: const Icon(Icons.arrow_back), label: const Text('ابدأ الآن')),
              ]),
            ),
          ),
          const SizedBox(height: 20),
          const Text('ماذا تريد أن تفعل؟', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Row(children: [
            Expanded(child: Feature(icon: Icons.auto_awesome, title: 'اصنع بالـAI', sub: 'أفكار ونصوص', onTap: () => open(context, const AiPage()))),
            const SizedBox(width: 10),
            Expanded(child: Feature(icon: Icons.storefront, title: 'سوق الخدمات', sub: 'اعرض أو اطلب', onTap: () => open(context, const ServicesPage()))),
          ]),
          const SizedBox(height: 10),
          Row(children: [
            Expanded(child: Feature(icon: Icons.lightbulb_outline, title: 'أفكار رزق', sub: 'أفكار للعمل', onTap: () => showIdeas(context))),
            const SizedBox(width: 10),
            Expanded(child: Feature(icon: Icons.person_outline, title: 'حسابي', sub: 'ملفك التجريبي', onTap: () => open(context, const ProfilePage()))),
          ]),
          const SizedBox(height: 20),
          const Text('خدمات مقترحة', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          const ServiceTile(title: 'تصميم منشورات للسوشيال ميديا', seller: 'مصمم عربي', price: 'يبدأ من 5\$', icon: Icons.image_outlined),
          const ServiceTile(title: 'كتابة وصف وإعلان لمنتج', seller: 'كاتب محتوى', price: 'يبدأ من 3\$', icon: Icons.edit_note),
        ],
      );

  void showIdeas(BuildContext context) => showModalBottomSheet<void>(
        context: context,
        showDragHandle: true,
        builder: (_) => const Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 8, 20, 30),
            child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('أفكار للعمل', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              SizedBox(height: 14),
              Text('• تصميم منشورات وإعلانات.'), Text('• كتابة محتوى ووصف للمنتجات.'), Text('• تجهيز عروض وملفات بسيطة.'), Text('• إدارة محتوى صفحات التواصل.'),
              SizedBox(height: 8),
              Text('الدخل يعتمد على المهارة والطلب والسوق، ولا يوجد ربح مضمون.', style: TextStyle(color: Colors.white60)),
            ]),
          ),
        ),
      );
}

class Feature extends StatelessWidget {
  final IconData icon; final String title; final String sub; final VoidCallback onTap;
  const Feature({super.key, required this.icon, required this.title, required this.sub, required this.onTap});
  @override
  Widget build(BuildContext context) => Card(child: InkWell(borderRadius: BorderRadius.circular(12), onTap: onTap, child: Padding(padding: const EdgeInsets.all(15), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Icon(icon, size: 30), const SizedBox(height: 10), Text(title, style: const TextStyle(fontWeight: FontWeight.bold)), const SizedBox(height: 4), Text(sub, style: const TextStyle(color: Colors.white60))]))));
}

class AiPage extends StatefulWidget {
  const AiPage({super.key});
  @override State<AiPage> createState() => _AiPageState();
}
class _AiPageState extends State<AiPage> {
  final input = TextEditingController(); String result = ''; bool loading = false;
  void generate() {
    final p = input.text.trim();
    if (p.isEmpty) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('اكتب طلبك أولًا.'))); return; }
    setState(() => loading = true);
    Future.delayed(const Duration(milliseconds: 500), () { if (!mounted) return; setState(() { loading = false; result = 'فكرة مقترحة حول «$p»:\n\nعنوان: اصنع شيئًا مميزًا اليوم\n\nنص: اكتشف الحل المناسب لك بطريقة بسيطة واحترافية. عدّل النص حسب جمهورك ومنتجك قبل النشر.'; }); });
  }
  @override void dispose() { input.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(16), children: [
        const Text('مساعد رزق AI', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text('نسخة تجريبية: التوليد محلي للتجربة وليس متصلًا بخدمة AI خارجية بعد.', style: TextStyle(color: Colors.white60)),
        const SizedBox(height: 18),
        TextField(controller: input, maxLines: 5, decoration: const InputDecoration(filled: true, hintText: 'مثال: اكتب إعلانًا لمتجر ملابس...', border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(14)), borderSide: BorderSide.none))),
        const SizedBox(height: 12),
        FilledButton.icon(onPressed: loading ? null : generate, icon: loading ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2)) : const Icon(Icons.auto_awesome), label: Text(loading ? 'جاري التجهيز...' : 'توليد')),
        if (result.isNotEmpty) ...[const SizedBox(height: 18), Card(child: Padding(padding: const EdgeInsets.all(18), child: SelectableText(result, style: const TextStyle(height: 1.7))))],
      ]);
}

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});
  @override
  Widget build(BuildContext context) {
    final data = [
      ('تصميم شعار وهوية بسيطة', 'مصمم', '10\$', Icons.brush_outlined),
      ('تصميم منشور إعلاني', 'مصمم سوشيال', '5\$', Icons.image_outlined),
      ('كتابة وصف للمنتجات', 'كاتب محتوى', '3\$', Icons.description_outlined),
      ('ترجمة عربية - إنجليزية', 'مترجم', '5\$', Icons.translate),
    ];
    return ListView(padding: const EdgeInsets.all(16), children: [
      const Text('سوق الخدمات', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8), const Text('نماذج تجريبية لواجهة السوق.', style: TextStyle(color: Colors.white60)), const SizedBox(height: 16),
      ...data.map((s) => Card(margin: const EdgeInsets.only(bottom: 10), child: ListTile(leading: CircleAvatar(child: Icon(s.$4)), title: Text(s.$1), subtitle: Text('${s.$2} • ${s.$3}'), trailing: const Icon(Icons.chevron_left), onTap: () => showDialog<void>(context: context, builder: (_) => AlertDialog(title: Text(s.$1), content: Text('هذه بطاقة خدمة تجريبية بسعر يبدأ من ${s.$3}.'), actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('إغلاق'))]))))),
    ]);
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(16), children: [
        const Center(child: CircleAvatar(radius: 42, child: Icon(Icons.person, size: 44))), const SizedBox(height: 12),
        const Center(child: Text('حساب تجريبي', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))), const SizedBox(height: 22),
        Card(child: Column(children: [
          const ListTile(leading: Icon(Icons.sell_outlined), title: Text('خدماتي'), trailing: Icon(Icons.chevron_left)),
          const ListTile(leading: Icon(Icons.receipt_long_outlined), title: Text('طلباتي'), trailing: Icon(Icons.chevron_left)),
          const ListTile(leading: Icon(Icons.account_balance_wallet_outlined), title: Text('الأرباح'), subtitle: Text('سيتم ربط نظام الدفع في مرحلة لاحقة'), trailing: Icon(Icons.lock_outline)),
        ])),
      ]);
}

class ServiceTile extends StatelessWidget {
  final String title, seller, price; final IconData icon;
  const ServiceTile({super.key, required this.title, required this.seller, required this.price, required this.icon});
  @override Widget build(BuildContext context) => Card(margin: const EdgeInsets.only(bottom: 10), child: ListTile(leading: CircleAvatar(child: Icon(icon)), title: Text(title), subtitle: Text('$seller • $price')));
}
