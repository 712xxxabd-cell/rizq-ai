import 'package:flutter/material.dart';

void main() {
  runApp(const RizqAIApp());
}

class RizqAIApp extends StatelessWidget {
  const RizqAIApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'رزق AI',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF061326),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF18BFFF),
          brightness: Brightness.dark,
        ),
        fontFamily: 'Arial',
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;

  final pages = const [
    HomeTab(),
    ServicesTab(),
    IdeasTab(),
    ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(child: pages[index]),
        bottomNavigationBar: NavigationBar(
          selectedIndex: index,
          onDestinationSelected: (value) => setState(() => index = value),
          backgroundColor: const Color(0xFF081A31),
          indicatorColor: const Color(0xFF123B65),
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'الرئيسية'),
            NavigationDestination(icon: Icon(Icons.grid_view_outlined), selectedIcon: Icon(Icons.grid_view), label: 'الخدمات'),
            NavigationDestination(icon: Icon(Icons.lightbulb_outline), selectedIcon: Icon(Icons.lightbulb), label: 'أفكار'),
            NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'حسابي'),
          ],
        ),
      ),
    );
  }
}

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        Row(
          children: [
            const Expanded(
              child: Text(
                'رزق AI',
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
              ),
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none)),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            gradient: const LinearGradient(
              colors: [Color(0xFF1555D9), Color(0xFF13A9E8)],
            ),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('حوّل أفكارك إلى عمل', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              SizedBox(height: 7),
              Text('استخدم الذكاء الاصطناعي لصنع تصاميم ومحتوى ثم اعرض مهاراتك للبيع.'),
            ],
          ),
        ),
        const SizedBox(height: 18),
        Row(
          children: [
            Expanded(child: FeatureCard(
              icon: Icons.auto_awesome,
              title: 'اصنع بالـAI',
              subtitle: 'صور ومحتوى وإعلانات',
              color: const Color(0xFF0FAF9E),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AIGeneratorPage())),
            )),
            const SizedBox(width: 12),
            Expanded(child: FeatureCard(
              icon: Icons.work_outline,
              title: 'بع خدمتك',
              subtitle: 'اعرض مهاراتك واربح',
              color: const Color(0xFF4A55D8),
              onTap: () {},
            )),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: FeatureCard(
              icon: Icons.shopping_cart_outlined,
              title: 'اطلب خدمة',
              subtitle: 'ابحث عن مستقل',
              color: const Color(0xFFF26D21),
              onTap: () {},
            )),
            const SizedBox(width: 12),
            Expanded(child: FeatureCard(
              icon: Icons.lightbulb_outline,
              title: 'أفكار للربح',
              subtitle: 'اكتشف فرصًا جديدة',
              color: const Color(0xFF7D43D9),
              onTap: () {},
            )),
          ],
        ),
        const SizedBox(height: 24),
        const Text('أحدث الخدمات', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        const ServiceTile(title: 'تصميم منشورات سوشيال ميديا', price: '15\$'),
        const ServiceTile(title: 'تصميم شعار احترافي', price: '10\$'),
        const ServiceTile(title: 'تحسين وتعديل الصور', price: '5\$'),
      ],
    );
  }
}

class FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title, subtitle;
  final Color color;
  final VoidCallback onTap;

  const FeatureCard({super.key, required this.icon, required this.title, required this.subtitle, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        height: 135,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 30),
            const Spacer(),
            Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(subtitle, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

class ServiceTile extends StatelessWidget {
  final String title, price;
  const ServiceTile({super.key, required this.title, required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFF0C2038),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          const CircleAvatar(child: Icon(Icons.image_outlined)),
          const SizedBox(width: 12),
          Expanded(child: Text(title)),
          Text(price, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class AIGeneratorPage extends StatelessWidget {
  const AIGeneratorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('اصنع بالذكاء الاصطناعي')),
        body: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('ماذا تريد أن تصنع؟', style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              TextField(
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'مثال: تصميم إعلان احترافي لمتجر ملابس...',
                  filled: true,
                  fillColor: const Color(0xFF0C2038),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                ),
              ),
              const SizedBox(height: 18),
              FilledButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('هذه نسخة تجريبية — سنربط مولد الذكاء الاصطناعي في الخطوة التالية.')),
                  );
                },
                icon: const Icon(Icons.auto_awesome),
                label: const Padding(
                  padding: EdgeInsets.all(14),
                  child: Text('إنشاء'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ServicesTab extends StatelessWidget {
  const ServicesTab({super.key});
  @override
  Widget build(BuildContext context) => const Center(child: Text('قسم الخدمات — قيد التطوير', style: TextStyle(fontSize: 20)));
}

class IdeasTab extends StatelessWidget {
  const IdeasTab({super.key});
  @override
  Widget build(BuildContext context) => const Center(child: Text('أفكار للربح — قيد التطوير', style: TextStyle(fontSize: 20)));
}

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});
  @override
  Widget build(BuildContext context) => const Center(child: Text('حسابي — قيد التطوير', style: TextStyle(fontSize: 20)));
}
