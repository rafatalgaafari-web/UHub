enum VerificationStatus { unverified, pending, verified, rejected }
enum AccountStatus { active, suspended, deletionPending, deleted }

class Student {
  final String uid;
  final String name;
  final String email;
  final String university;
  final String college;
  final AccountStatus accountStatus;
  final VerificationStatus verificationStatus;

  //
  /*
   */
  //
  const Student({
    required this.uid,
    required this.name,
    required this.email,
    required this.university,
    required this.college,
    this.accountStatus = AccountStatus.active,
    this.verificationStatus = VerificationStatus.unverified,
  });

  bool get canPublish => verificationStatus == VerificationStatus.verified;
}

class Post {
  final String id;
  final String authorId;
  final String authorName;
  final String college;
  final String body;
  final DateTime createdAt;
  int likes;
  bool isLiked;
  bool isSaved;

  Post({
    required this.id,
    required this.authorId,
    required this.authorName,
    required this.college,
    required this.body,
    required this.createdAt,
    this.likes = 0,
    this.isLiked = false,
    this.isSaved = false,
  });
}
