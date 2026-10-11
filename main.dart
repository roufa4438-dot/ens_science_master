import 'package:flutter/material.dart';

void main() {
  runApp(const EnsApp());
}

class EnsApp extends StatelessWidget {
  const EnsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'منصة المدرسة العليا للأساتذة - عنابة',
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        );
      },
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
        fontFamily: 'Segoe UI',
      ),
      home: const HomePage(),
    );
  }
}

// 1. الصفحة الرئيسية: الأطوار التعليمية
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ملحقة المدرسة العليا للأساتذة - عنابة',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF00C853),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF00E676), Color(0xFF00A152)],
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Column(
                children: [
                  Icon(Icons.school_rounded, size: 50, color: Colors.white),
                  SizedBox(height: 10),
                  Text(
                    'تطبيق مقاييس اللغة العربية',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 5),
                  Text(
                    'اختر الطور الدراسي للمتابعة',
                    style: TextStyle(fontSize: 14, color: Colors.white70),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            const Text(
              'الأطوار التعليمية:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),

            _buildStageCard(context, 'الطور الابتدائي', 'تخصص PEP - أستاذ المدرسة الابتدائية', Icons.child_care, const Color(0xFF29B6F6), isAvailable: true),
            _buildStageCard(context, 'الطور المتوسط', 'تخصص PEM - أستاذ التعليم المتوسط', Icons.menu_book, const Color(0xFF26A69A), isAvailable: true),
            _buildStageCard(context, 'الطور الثانوي', 'سيتم الإضافة قريباً', Icons.history_edu, const Color(0xFFFF7043), isAvailable: false),
          ],
        ),
      ),
    );
  }

  Widget _buildStageCard(BuildContext context, String title, String subtitle, IconData icon, Color color, {required bool isAvailable}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 3,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        leading: CircleAvatar(
          backgroundColor: color.withValues(alpha: 0.15),
          radius: 25,
          child: Icon(icon, color: color, size: 28),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 13)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          if (isAvailable) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => YearsPage(stageTitle: title)),
            );
          } else {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('تنبيه'),
                content: Text('محتوى $title سيتم إضافته قريباً جداً.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('حسناً'),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

// 2. صفحة السنوات الخمس
class YearsPage extends StatelessWidget {
  final String stageTitle;

  const YearsPage({super.key, required this.stageTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$stageTitle - السنوات الدراسية'),
        backgroundColor: const Color(0xFF00C853),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Text(
            'اختر السنة الدراسية في $stageTitle:',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          _buildYearTile(context, 'سنة أولى', Icons.looks_one, const Color(0xFF00C853), isAvailable: true),
          _buildYearTile(context, 'سنة ثانية', Icons.looks_two, const Color(0xFF29B6F6), isAvailable: true),
          _buildYearTile(context, 'سنة ثالثة', Icons.looks_3, const Color(0xFF7E57C2), isAvailable: false),
          _buildYearTile(context, 'سنة رابعة', Icons.looks_4, const Color(0xFFEC407A), isAvailable: false),
          _buildYearTile(context, 'سنة خامسة', Icons.looks_5, const Color(0xFFFF7043), isAvailable: false),
        ],
      ),
    );
  }

  Widget _buildYearTile(BuildContext context, String yearTitle, IconData icon, Color color, {required bool isAvailable}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 2,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: color.withValues(alpha: 0.15),
          child: Icon(icon, color: color),
        ),
        title: Text(yearTitle, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        subtitle: Text(isAvailable ? 'عرض المقاييس والمواد الدراسية' : 'سيتم الإضافة قريباً...', style: const TextStyle(fontSize: 13)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          if (isAvailable) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SubjectsGridPage(stageTitle: stageTitle, yearTitle: yearTitle)),
            );
          } else {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('تنبيه'),
                content: Text('محتوى $yearTitle ($stageTitle) سيتم إضافته قريباً جداً.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('حسناً'),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

// 3. صفحة عرض المقاييس تصميم قائمة طولية بنفس شكل السنوات والقوائم السابقة
class SubjectsGridPage extends StatelessWidget {
  final String stageTitle;
  final String yearTitle;

  const SubjectsGridPage({super.key, required this.stageTitle, required this.yearTitle});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> subjects = [];

    if (stageTitle == 'الطور الابتدائي') {
      if (yearTitle == 'سنة أولى') {
        subjects = [
          {'name': 'النحو العربي 1', 'icon': Icons.menu_book_rounded, 'color': const Color(0xFF00C853)},
          {'name': 'البلاغة العربية 1', 'icon': Icons.style_rounded, 'color': const Color(0xFFFF7043)},
          {'name': 'الأدب العربي قديما وحديثا 1', 'icon': Icons.auto_stories_rounded, 'color': const Color(0xFF29B6F6)},
          {'name': 'رياضيات 1', 'icon': Icons.calculate_rounded, 'color': const Color(0xFF7E57C2)},
          {'name': 'فيزياء عامة 1', 'icon': Icons.flash_on_rounded, 'color': const Color(0xFFFF5252)},
          {'name': 'كيمياء عامة 1', 'icon': Icons.science_rounded, 'color': const Color(0xFF26A69A)},
          {'name': 'الإملاء', 'icon': Icons.edit_note_rounded, 'color': const Color(0xFFEC407A)},
          {'name': 'تكنولوجيات الاعلام والاتصال', 'icon': Icons.computer_rounded, 'color': const Color(0xFF424242)},
          {'name': 'التربية الإسلامية 1', 'icon': Icons.mosque_rounded, 'color': const Color(0xFFAB47BC)},
          {'name': 'إنجليزية', 'icon': Icons.language_rounded, 'color': const Color(0xFF5C6BC0)},
        ];
      } else if (yearTitle == 'سنة ثانية') {
        subjects = [
          {'name': 'النحو العربي', 'icon': Icons.menu_book_rounded, 'color': const Color(0xFF00C853)},
          {'name': 'الصرف العربي', 'icon': Icons.category_rounded, 'color': const Color(0xFFFF7043)},
          {'name': 'قضايا النقد العربي قديما وحديثا', 'icon': Icons.rate_review_rounded, 'color': const Color(0xFF29B6F6)},
          {'name': 'لسانيات عامة', 'icon': Icons.psychology_rounded, 'color': const Color(0xFF7E57C2)},
          {'name': 'رياضيات 3', 'icon': Icons.calculate_rounded, 'color': const Color(0xFFFF5252)},
          {'name': 'مدخل إلى علم الأحياء ودراسة الأحياء الدقيقة', 'icon': Icons.biotech_rounded, 'color': const Color(0xFF26A69A)},
          {'name': 'علم نفس النمو الطفل والمراهق', 'icon': Icons.child_care_rounded, 'color': const Color(0xFFEC407A)},
          {'name': 'الذكاء الاصطناعي في التعلم', 'icon': Icons.smart_toy_rounded, 'color': const Color(0xFF424242)},
          {'name': 'تربية إسلامية', 'icon': Icons.mosque_rounded, 'color': const Color(0xFFAB47BC)},
          {'name': 'إنجليزية', 'icon': Icons.language_rounded, 'color': const Color(0xFF5C6BC0)},
        ];
      }
    } else if (stageTitle == 'الطور المتوسط') {
      if (yearTitle == 'سنة أولى') {
        subjects = [
          {'name': 'اللسانيات العامة 1', 'icon': Icons.psychology_rounded, 'color': const Color(0xFF00C853)},
          {'name': 'الإملاء 1', 'icon': Icons.edit_note_rounded, 'color': const Color(0xFFFF7043)},
          {'name': 'البلاغة العربية 1 (علم البيان)', 'icon': Icons.style_rounded, 'color': const Color(0xFF29B6F6)},
          {'name': 'التربية الإسلامية 1', 'icon': Icons.mosque_rounded, 'color': const Color(0xFF7E57C2)},
          {'name': 'تكنولوجيا الإعلام والاتصال', 'icon': Icons.computer_rounded, 'color': const Color(0xFF424242)},
          {'name': 'فقه اللغة 1', 'icon': Icons.history_edu_rounded, 'color': const Color(0xFF26A69A)},
          {'name': 'النحو العربي 1', 'icon': Icons.menu_book_rounded, 'color': const Color(0xFFFF5252)},
          {'name': 'الصرف العربي 1', 'icon': Icons.category_rounded, 'color': const Color(0xFFEC407A)},
          {'name': 'إنجليزية 1', 'icon': Icons.language_rounded, 'color': const Color(0xFF5C6BC0)},
          {'name': 'الأدب الجاهلي 1', 'icon': Icons.auto_stories_rounded, 'color': const Color(0xFFAB47BC)},
        ];
      } else if (yearTitle == 'سنة ثانية') {
        subjects = [
          {'name': 'أدب صدر الإسلام والعصر الأموي', 'icon': Icons.auto_stories_rounded, 'color': const Color(0xFF00C853)},
          {'name': 'الذكاء الاصطناعي في التعلم', 'icon': Icons.smart_toy_rounded, 'color': const Color(0xFF424242)},
          {'name': 'تربية إسلامية', 'icon': Icons.mosque_rounded, 'color': const Color(0xFFAB47BC)},
          {'name': 'الثقافة الشعبية', 'icon': Icons.groups_rounded, 'color': const Color(0xFFFF7043)},
          {'name': 'البلاغة علم المعاني', 'icon': Icons.style_rounded, 'color': const Color(0xFF29B6F6)},
          {'name': 'الصرف العربي', 'icon': Icons.category_rounded, 'color': const Color(0xFF7E57C2)},
          {'name': 'النحو العربي', 'icon': Icons.menu_book_rounded, 'color': const Color(0xFFFF5252)},
          {'name': 'إنجليزية', 'icon': Icons.language_rounded, 'color': const Color(0xFF5C6BC0)},
          {'name': 'علم النفس الطفل والمراهق', 'icon': Icons.child_care_rounded, 'color': const Color(0xFFEC407A)},
          {'name': 'علم الدلالة', 'icon': Icons.record_voice_over_rounded, 'color': const Color(0xFF26A69A)},
        ];
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('مقاييس $yearTitle ($stageTitle)'),
        backgroundColor: const Color(0xFF00C853),
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: subjects.length,
        itemBuilder: (context, index) {
          final subject = subjects[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 2,
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              leading: CircleAvatar(
                backgroundColor: (subject['color'] as Color).withValues(alpha: 0.15),
                radius: 24,
                child: Icon(subject['icon'], color: subject['color'], size: 24),
              ),
              title: Text(
                subject['name'],
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              subtitle: const Text('عرض الدروس والمصادر والامتحانات', style: TextStyle(fontSize: 13)),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SubjectDetailPage(
                      subjectName: subject['name'],
                      themeColor: subject['color'],
                      stageTitle: stageTitle,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// 4. صفحة تفاصيل المقياس (دروس، مصادر، امتحانات)
class SubjectDetailPage extends StatelessWidget {
  final String subjectName;
  final Color themeColor;
  final String stageTitle;

  const SubjectDetailPage({
    super.key,
    required this.subjectName,
    required this.themeColor,
    required this.stageTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(subjectName),
        backgroundColor: themeColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: themeColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: themeColor.withValues(alpha: 0.3)),
              ),
              child: Column(
                children: [
                  Text(
                    'تجدون في هذا القسم كل ما يخص\nمقياس $subjectName\n$stageTitle',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: themeColor,
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            _buildOptionButton(
              context: context,
              title: 'دروس',
              icon: Icons.menu_book_rounded,
              color: themeColor,
              destination: LessonsPage(subjectName: subjectName, themeColor: themeColor),
            ),
            const SizedBox(height: 15),
            _buildOptionButton(
              context: context,
              title: 'مصادر',
              icon: Icons.library_books_rounded,
              color: themeColor,
              destination: SourcesPage(subjectName: subjectName, themeColor: themeColor),
            ),
            const SizedBox(height: 15),
            _buildOptionButton(
              context: context,
              title: 'امتحانات',
              icon: Icons.assignment_outlined,
              color: themeColor,
              destination: ExamsPage(subjectName: subjectName, themeColor: themeColor),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionButton({
    required BuildContext context,
    required String title,
    required IconData icon,
    required Color color,
    required Widget destination,
  }) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 2),
            )
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              child: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
            ),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
              ),
              child: Icon(icon, color: Colors.white, size: 26),
            ),
          ],
        ),
      ),
    );
  }
}

// 5. صفحة الدروس
class LessonsPage extends StatelessWidget {
  final String subjectName;
  final Color themeColor;

  const LessonsPage({super.key, required this.subjectName, required this.themeColor});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> lessons = [
      {'title': 'الدرس الأول: المدخل الأساسي للمقياس', 'duration': 'محاضرة رقم 01'},
      {'title': 'الدرس الثاني: المفاهيم والاصطلاحات المركزية', 'duration': 'محاضرة رقم 02'},
      {'title': 'الدرس الثالث: التطبيقات العملية والأمثلة', 'duration': 'محاضرة رقم 03'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('دروس مقياس: $subjectName'),
        backgroundColor: themeColor,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: lessons.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: themeColor.withValues(alpha: 0.2),
                child: Icon(Icons.menu_book, color: themeColor),
              ),
              title: Text(
                lessons[index]['title']!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(lessons[index]['duration']!),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('فتح: ${lessons[index]['title']}')),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// 6. صفحة المصادر
class SourcesPage extends StatelessWidget {
  final String subjectName;
  final Color themeColor;

  const SourcesPage({super.key, required this.subjectName, required this.themeColor});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> sources = [
      {'title': 'المرجع الأساسي المعتمد في المحاضرات', 'author': 'مطبوعة الأستاذ المقررة'},
      {'title': 'كتاب المراجع العامة في التخصص', 'author': 'دار المعارف للطباعة والنشر'},
      {'title': 'سلسلة المقالات العلمية والمجلات المحكمة', 'author': 'أرشيف الملزمة الجامعية'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('مصادر ومرجعيات: $subjectName'),
        backgroundColor: themeColor,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: sources.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: themeColor.withValues(alpha: 0.2),
                child: Icon(Icons.library_books, color: themeColor),
              ),
              title: Text(
                sources[index]['title']!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(sources[index]['author']!),
              trailing: const Icon(Icons.download, size: 20),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('تحميل المرجع: ${sources[index]['title']}')),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// 7. صفحة الامتحانات
class ExamsPage extends StatelessWidget {
  final String subjectName;
  final Color themeColor;

  const ExamsPage({super.key, required this.subjectName, required this.themeColor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('امتحانات مقياس: $subjectName'),
        backgroundColor: themeColor,
      ),
      body: const Center(
        child: Text(
          'قريباً سيتم إضافة مواضيع الامتحانات السابقة مع التصحيح النموذجي',
          style: TextStyle(fontSize: 16, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}