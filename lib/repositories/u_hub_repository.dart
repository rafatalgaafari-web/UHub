import '../models/entities.dart';

abstract class UHubRepository {
  Student get currentStudent;
  List<Post> getFeed();
  void toggleLike(Post post);
  void toggleSave(Post post);
  void addPost(String body);
  void requestVerification();
}

class MockUHubRepository implements UHubRepository {
  final Student _student = const Student(
    uid: 'student-001',
    name: 'أحمد محمد',
    email: 'ahmad@example.com',
    university: 'جامعة بغداد',
    college: 'كلية الهندسة',
  );

  final List<Post> _posts = [
    Post(
      id: 'p1',
      authorId: 'student-002',
      authorName: 'سارة علي',
      college: 'كلية الهندسة',
      body: 'هل توجد ملخصات لمادة هياكل البيانات؟ أحتاج إلى مراجعتها قبل الاختبار.',
      createdAt: DateTime(2026, 10, 30, 10),
      likes: 12,
    ),
    Post(
      id: 'p2',
      authorId: 'student-003',
      authorName: 'عمر حسن',
      college: 'كلية العلوم',
      body: 'تم الإعلان عن ندوة مجانية حول البحث العلمي يوم الخميس في القاعة المركزية.',
      createdAt: DateTime(2026, 10, 29, 15),
      likes: 8,
    ),
  ];

  @override
  Student get currentStudent => _student;

  @override
  List<Post> getFeed() => List.unmodifiable(_posts);

  @override
  void toggleLike(Post post) {
    post.isLiked = !post.isLiked;
    post.likes += post.isLiked ? 1 : -1;
  }

  @override
  void toggleSave(Post post) => post.isSaved = !post.isSaved;

  @override
  void addPost(String body) {
    _posts.insert(0, Post(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      authorId: _student.uid,
      authorName: _student.name,
      college: _student.college,
      body: body,
      createdAt: DateTime.now(),
    ));
  }

  @override
  void requestVerification() {}
}
