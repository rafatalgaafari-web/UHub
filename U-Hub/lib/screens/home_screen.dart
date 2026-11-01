import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/entities.dart';
import '../repositories/u_hub_repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final repo = context.read<UHubRepository>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('U-Hub', style: TextStyle(fontWeight: FontWeight.w800)),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none_rounded)),
          Padding(padding: const EdgeInsets.only(left: 16), child: CircleAvatar(child: Text(repo.currentStudent.name[0]))),
        ],
      ),
      body: _index == 0 ? const _Feed() : const _Profile(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openComposer(context),
        icon: const Icon(Icons.edit_rounded), label: const Text('منشور'),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (value) => setState(() => _index = value),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'الرئيسية'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'ملفي'),
        ],
      ),
    );
  }

  Future<void> _openComposer(BuildContext context) async {
    final repo = context.read<UHubRepository>();
    if (!repo.currentStudent.canPublish) {
      await showDialog(context: context, builder: (_) => AlertDialog(
        title: const Text('التوثيق مطلوب'),
        content: const Text('لإنشاء منشور عام، يرجى طلب توثيق الحساب أولًا.'),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('حسنًا'))],
      ));
      return;
    }
  }
}

class _Feed extends StatelessWidget {
  const _Feed();
  @override
  Widget build(BuildContext context) {
    final repo = context.watch<UHubRepository>();
    final posts = repo.getFeed();
    return RefreshIndicator(
      onRefresh: () async => await Future<void>.delayed(const Duration(milliseconds: 500)),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF102A43), Color(0xFF0E9384)]), borderRadius: BorderRadius.circular(24)),
            child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('مساحتك الأكاديمية', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
              SizedBox(height: 6), Text('اكتشف، شارك، وتواصل مع مجتمع جامعتك.', style: TextStyle(color: Colors.white70)),
            ]),
          ),
          const SizedBox(height: 18),
          const Text('آخر المنشورات', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          ...posts.map((post) => _PostCard(post: post)),
        ],
      ),
    );
  }
}

class _PostCard extends StatelessWidget {
  final Post post;
  const _PostCard({required this.post});
  @override
  Widget build(BuildContext context) {
    final repo = context.read<UHubRepository>();
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 7),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [CircleAvatar(child: Text(post.authorName[0])), const SizedBox(width: 10), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(post.authorName, style: const TextStyle(fontWeight: FontWeight.bold)), Text(post.college, style: TextStyle(color: Colors.grey[600], fontSize: 12))])), Text(DateFormat('MM/dd').format(post.createdAt), style: TextStyle(color: Colors.grey[500], fontSize: 12))]),
        const SizedBox(height: 14), Text(post.body, style: const TextStyle(fontSize: 16, height: 1.5)),
        const Divider(height: 24),
        Row(children: [IconButton(onPressed: () { repo.toggleLike(post); (context as Element).markNeedsBuild(); }, icon: Icon(post.isLiked ? Icons.favorite : Icons.favorite_border, color: post.isLiked ? Colors.red : null)), Text('${post.likes}'), const Spacer(), IconButton(onPressed: () { repo.toggleSave(post); (context as Element).markNeedsBuild(); }, icon: Icon(post.isSaved ? Icons.bookmark : Icons.bookmark_border))]),
      ])),
    );
  }
}

class _Profile extends StatelessWidget {
  const _Profile();
  @override
  Widget build(BuildContext context) {
    final student = context.read<UHubRepository>().currentStudent;
    return ListView(padding: const EdgeInsets.all(20), children: [
      CircleAvatar(radius: 42, child: Text(student.name[0], style: const TextStyle(fontSize: 30))),
      const SizedBox(height: 12), Center(child: Text(student.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold))),
      Center(child: Text('${student.college} • ${student.university}', style: TextStyle(color: Colors.grey[600]))),
      const SizedBox(height: 24),
      Card(child: ListTile(leading: const Icon(Icons.verified_user_outlined), title: const Text('حالة التوثيق'), subtitle: const Text('الحساب غير موثق حاليًا'), trailing: TextButton(onPressed: () {}, child: const Text('طلب توثيق')))),
    ]);
  }
}
