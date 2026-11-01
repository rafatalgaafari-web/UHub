import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/entities.dart';
import 'u_hub_repository.dart';

/// طبقة جاهزة لاستبدال المستودع التجريبي بعد تنفيذ flutterfire configure.
class FirestoreUHubRepository implements UHubRepository {
  final FirebaseFirestore firestore;
  final Student _student;

  FirestoreUHubRepository({FirebaseFirestore? firestore, required Student student})
      : firestore = firestore ?? FirebaseFirestore.instance,
        _student = student;

  @override
  Student get currentStudent => _student;

  @override
  List<Post> getFeed() => <Post>[];

  @override
  void toggleLike(Post post) {
    final ref = firestore.collection('Likes').doc('${_student.uid}_${post.id}');
    if (post.isLiked) {
      ref.delete();
      post.isLiked = false;
      post.likes--;
    } else {
      ref.set({'studentId': _student.uid, 'postId': post.id, 'createdAt': FieldValue.serverTimestamp()});
      post.isLiked = true;
      post.likes++;
    }
  }

  @override
  void toggleSave(Post post) {
    final ref = firestore.collection('SavedPosts').doc('${_student.uid}_${post.id}');
    post.isSaved = !post.isSaved;
    if (post.isSaved) {
      ref.set({'studentId': _student.uid, 'postId': post.id, 'createdAt': FieldValue.serverTimestamp()});
    } else {
      ref.delete();
    }
  }

  @override
  void addPost(String body) {
    if (!_student.canPublish) throw StateError('Verification is required before publishing.');
    firestore.collection('Posts').add({
      'authorId': _student.uid,
      'authorName': _student.name,
      'college': _student.college,
      'body': body,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  @override
  void requestVerification() {
    firestore.collection('VerificationRequests').add({
      'requesterId': _student.uid,
      'studentId': _student.uid,
      'decision': 'pending',
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}
