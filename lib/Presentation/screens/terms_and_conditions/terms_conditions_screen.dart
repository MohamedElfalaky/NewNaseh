import 'package:flutter/material.dart';
import 'package:nasooh/Presentation/widgets/shared.dart';
import 'package:nasooh/app/constants.dart';

class TermsConditionsScreen extends StatefulWidget {
  const TermsConditionsScreen({super.key});

  @override
  State<TermsConditionsScreen> createState() => _TermsConditionsScreenState();
}

class _TermsConditionsScreenState extends State<TermsConditionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Constants.whiteAppColor,
      appBar: AppBar(
          centerTitle: false,
          leadingWidth: 70,
          title: const Row(
            children: [
              Text("الشروط والأحكام"),
            ],
          ),
          leading: const CustomBackButton()),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildHeader('مقدمة:'),
            buildBody(
                "مرحبًا بكم في تطبيق  نصوح ، التطبيق الذي يجمع بين الأشخاص الباحثين عن نصائح والناصحين المستعدين لتقديمها في مختلف المجالات. يُرجى قراءة هذه الشروط والأحكام بعناية قبل استخدام التطبيق، حيث إن استخدامك له يعني موافقتك على الالتزام بهذه الشروط."),
            buildHeader('التعريفات:'),
            buildBody(
                "المستخدم يشير إلى أي شخص يقوم بتحميل و/أو استخدام تطبيق  نصوح."),
            buildBody(
                "الناصح يشير إلى المستخدمين المسجلين الذين يقدمون النصائح للمستخدمين الآخرين."),
            buildBody(
                " النصيحة  تشير إلى المعلومات والإرشادات والتوجيهات التي يقدمها الناصحون للمستخدمين."),
            buildHeader("استخدام التطبيق:"),
            buildBody(
                "يجب على المستخدمين تقديم معلومات دقيقة وحديثة عند التسجيل في التطبيق والحفاظ على تحديث هذه المعلومات.1- "
                " يُحظر استخدام التطبيق لأي أغراض غير قانونية أو محظورة بموجب هذه الشروط.2-"
                "  3- يجب على المستخدمين احترام حقوق الآخرين وعدم نشر أو توزيع محتوى يعتبر مسيء، غير لائق، أو ينتهك حقوق النشر"),
            buildHeader("النصائح:"),
            buildBody(
                "النصائح المقدمة من الناصحين هي لأغراض إعلامية فقط ولا يجب اعتبارها بديلاً عن الاستشارة المهنية."
                "يتحمل المستخدمون كامل المسؤولية عن كيفية استخدامهم للنصائح المقدمة."
                "   يحتفظ تطبيق نصوح بالحق في مراجعة وإزالة أي نصائح تُعتبر غير مناسبة أو مخالفة لهذه الشروط."),
            buildHeader("الخصوصية وحماية البيانات:"),
            buildBody(
                "يلتزم تطبيق  نصوح  بحماية خصوصية المستخدمين وبياناتهم الشخصية وفقًا لسياسة الخصوصية المنشورة."
                "يجب على المستخدمين قراءة سياسة الخصوصية بعناية لفهم كيفية جمع واستخدام وحماية معلوماتهم الشخصية."),
            buildHeader("التعديلات على الشروط والأحكام:"),
            buildBody(
                "يحتفظ تطبيق  نصوح  بالحق في تعديل هذه الشروط والأحكام في أي وقت. سيتم إخطار المستخدمين بأي تعديلات من خلال التطبيق أو عبر البريد الإلكتروني. استمرار استخدام التطبيق بعد هذه التعديلات يعني قبول المستخدم للشروط المعدلة."),
            buildHeader("إنهاء الخدمة:"),
            buildBody(
                "يحتفظ تطبيق  نصوح  بالحق في إنهاء أو تعليق حساب أي مستخدم يخالف هذه الشروط والأحكام."
                "إخلاء المسؤولية وحدود الضمان:"
                "  يُقدم تطبيق  نصوح   كما هو  دون أي ضمانات صريحة أو ضمنية. لا يضمن التطبيق دقة، كمال، أو ملاءمة النصائح المقدمة لأي غرض معين."),
            buildHeader("القانون الحاكم والاختصاص القضائي:"),
            buildBody(
                "تُحكم هذه الشروط والأحكام وتُفسر وفقًا لقوانين [المملكة العربية السعودية]، ويكون لمحاكم [المملكة العربية السعودية] الاختصاص الحصري في أي نزاعات قد تنشأ عنها."),
            // buildHeader("الاتصال بنا:")
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildHeader(title) => Padding(
      padding: const EdgeInsets.only(top: 30, bottom: 5),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      ),
    );

Widget buildBody(title) => Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
    );
