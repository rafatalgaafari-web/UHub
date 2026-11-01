# U-Hub

نسخة Flutter أولية لشبكة اجتماعية أكاديمية لطلاب الجامعات.

## الموجود حاليًا

- تطبيق Flutter/Dart بواجهة عربية RTL.
- صفحة الخلاصة والمنشورات.
- الإعجاب والحفظ محليًا.
- صفحة الملف الشخصي.
- حالات الحساب والتوثيق في نموذج البيانات.
- مستودع بيانات مستقل `UHubRepository` مع تنفيذ تجريبي `MockUHubRepository` قابل للاستبدال بـ Firebase.
- حظر إنشاء المنشور للحساب غير الموثق حسب تقرير U-Hub.

## التشغيل

1. ثبّت Flutter 3.22 أو أحدث.
2. نفّذ `flutter pub get`.
3. نفّذ `flutter run`.
4. عند ربط Firebase نفّذ `flutterfire configure` ثم استبدل `MockUHubRepository` بمستودع Firestore.

## الربط القادم مع Firebase

المجموعات المطلوبة حسب التقرير: `Students`, `Universities`, `Colleges`, `Posts`, `Likes`, `SavedPosts`, `UserFollowers`, `CollegeFollowers`, `VerificationRequests`, `Reports`, `Notifications`, `CommercialAccounts`, `AdCampaigns`, `PaymentRequests`.

يجب وضع قواعد Firestore تمنع القراءة العامة لبطاقات التوثيق وبيانات الدفع، وتمنع الكتابة العامة لمنشور جديد ما لم تكن حالة التوثيق `verified`.

## ملاحظة البيئة

لم تكن أدوات Flutter/Dart مثبتة في بيئة البناء الحالية، لذلك لم يتم تشغيل `flutter analyze` أو `flutter test` هنا. الملفات مكتوبة كمشروع Flutter قياسي وقابلة للفتح في Android Studio أو VS Code.
