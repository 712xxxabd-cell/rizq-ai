import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String GEMINI_KEY = "AQ.Ab8RN6IA2MuK7aLDORr_zeBHV2..."; // <-- الصق مفتاحك الكامل هنا

void main() => runApp(const RizqSuperApp());

class RizqSuperApp extends StatelessWidget {
  const RizqSuperApp({super.key});
  @override Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: const Color(0xFF0B1120)), home: const MainNav());
  }
}

class MainNav extends StatefulWidget { const MainNav({super.key}); @override State<MainNav> createState() => _MainNavState(); }
class _MainNavState extends State<MainNav> {
  int index = 0;
  final pages = [const ChatPage(), const ImagePage(), const IdeaPage()];
  @override Widget build(BuildContext context) {
    return Scaffold(
      body: pages[index],
      bottomNavigationBar: BottomNavigationBar(currentIndex: index, onTap: (i)=>setState(()=>index=i), backgroundColor: const Color(0xFF151F32), selectedItemColor: const Color(0xFF38BDF8), items: const [
        BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'دردشة'),
        BottomNavigationBarItem(icon: Icon(Icons.image), label: 'صور'),
        BottomNavigationBarItem(icon: Icon(Icons.lightbulb), label: 'أفكار'),
      ]),
    );
  }
}

class ChatPage extends StatefulWidget { const ChatPage({super.key}); @override State<ChatPage> createState() => _ChatPageState(); }
class _ChatPageState extends State<ChatPage> {
  final ctrl = TextEditingController(); List<Map> msgs = []; bool loading = false;
  Future<void> send() async {
    if(ctrl.text.isEmpty) return;
    setState(()=> msgs.add({"role":"user","text":ctrl.text}));
    String q = ctrl.text; ctrl.clear(); setState(()=> loading=true);
    try{
      final res = await http.post(Uri.parse('https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$GEMINI_KEY'), headers: {'Content-Type':'application/json'}, body: jsonEncode({"contents":[{"parts":[{"text":q}]}]}));
      String ans = jsonDecode(res.body)['candidates'][0]['content']['parts'][0]['text'];
      setState(()=> msgs.add({"role":"ai","text":ans}));
    }catch(e){ setState(()=> msgs.add({"role":"ai","text":"خطأ، تأكد من المفتاح"}));}
    setState(()=> loading=false);
  }
  @override Widget build(BuildContext context) => SafeArea(child: Column(children: [
    const Padding(padding: EdgeInsets.all(16), child: Text('رزق AI - دردشة', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))),
    Expanded(child: ListView.builder(itemCount: msgs.length, itemBuilder: (c,i)=> Container(margin: const EdgeInsets.all(8), padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: msgs[i]['role']=='user'? const Color(0xFF38BDF8).withValues(alpha:0.2) : const Color(0xFF151F32), borderRadius: BorderRadius.circular(12)), child: Text(msgs[i]['text'])))),
    if(loading) const CircularProgressIndicator(),
    Padding(padding: const EdgeInsets.all(8), child: Row(children: [Expanded(child: TextField(controller: ctrl, decoration: const InputDecoration(hintText: 'اسأل أي شيء...'))), IconButton(onPressed: send, icon: const Icon(Icons.send, color: Color(0xFF38BDF8)))]))
  ]));
}

class ImagePage extends StatefulWidget { const ImagePage({super.key}); @override State<ImagePage> createState() => _ImagePageState(); }
class _ImagePageState extends State<ImagePage> {
  final ctrl = TextEditingController(); String? imgUrl; bool loading=false;
  void gen(){ setState(()=> loading=true); String p = Uri.encodeComponent(ctrl.text); setState(()=> imgUrl = 'https://image.pollinations.ai/prompt/$p?width=512&height=512&seed=${DateTime.now().millisecondsSinceEpoch}'); Future.delayed(const Duration(seconds: 3), ()=> setState(()=> loading=false));}
  @override Widget build(BuildContext context) => SafeArea(child: Padding(padding: const EdgeInsets.all(16), child: Column(children: [
    const Text('مولد الصور بالذكاء الاصطناعي', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    TextField(controller: ctrl, decoration: const InputDecoration(hintText: 'مثال: جمل في حضرموت ليلا')),
    const SizedBox(height: 12), ElevatedButton(onPressed: gen, child: const Text('ولد الصورة 🎨')),
    const SizedBox(height: 16), if(loading) const CircularProgressIndicator(), if(imgUrl!=null &&!loading) Expanded(child: Image.network(imgUrl!)),
  ])));
}

class IdeaPage extends StatefulWidget { const IdeaPage({super.key}); @override State<IdeaPage> createState() => _IdeaPageState(); }
class _IdeaPageState extends State<IdeaPage> {
  String idea = "اضغط الزر ليولد لك مشروع يمني مربح"; bool loading=false;
  Future<void> genIdea() async {
    setState(()=> loading=true);
    try{
      final res = await http.post(Uri.parse('https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$GEMINI_KEY'), headers: {'Content-Type':'application/json'}, body: jsonEncode({"contents":[{"parts":[{"text":"اعطني فكرة مشروع صغير مربح لشاب في المكلا اليمن يربح من الذكاء الاصطناعي، مختصرة ومفيدة"}]}]}));
      idea = jsonDecode(res.body)['candidates'][0]['content']['parts'][0]['text'];
    }catch(e){ idea = "تأكد من المفتاح"; }
    setState(()=> loading=false);
  }
  @override Widget build(BuildContext context) => SafeArea(child: Padding(padding: const EdgeInsets.all(16), child: Column(children: [
    const Text('أفكار بزنس بالذكاء الاصطناعي', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    const SizedBox(height: 20), Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: const Color(0xFF151F32), borderRadius: BorderRadius.circular(16)), child: Text(idea)),
    const SizedBox(height: 20), if(loading) const CircularProgressIndicator() else ElevatedButton(onPressed: genIdea, style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF38BDF8)), child: const Text('ولد لي فكرة جديدة ✨', style: TextStyle(color: Colors.black))),
  ])));
}
