import 'package:habit_tracker/core/utils/assets.dart';

class OnboardingModel {
  String title;
  String description;
  String image;

  OnboardingModel({
    required this.title,
    required this.description,
    required this.image,
  });
}

//* List of Onborading
List<OnboardingModel> onboardingPages = [
  OnboardingModel(
    title: "أهلاً بك في أثر",
    description: "هنا هتبدأ رحلتك لتتبع العادات وتحقيق أهدافك الشخصية",
    image: AppAssets.handSvg,
  ),
  OnboardingModel(
    title: "شوف تقدمك بعينك",
    description: "تتبع يومي لعاداتك وتقدمك عبر شبكات ملونة سهلة وواضحة",
    image: AppAssets.chartSvg,
  ),
  OnboardingModel(
    title: "حافظ على الاستمرارية",
    description: "فعّل التذكيرات اليومية علشان متفوتش عادتك أبداً",
    image: AppAssets.bellSvg,
  ),
  OnboardingModel(
    title: "اسمك ايه؟",
    description: "هنستخدم اسمك جوه التطبيق علشان نخلي التجربة مخصصة ليك",
    image: AppAssets.profileSvg,
  ),
];
