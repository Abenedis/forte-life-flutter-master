import 'package:forte_life/ui/screens/profile/profile_card.dart';

abstract class ProfileCardInfo {
  static List<ProfileCard> info = <ProfileCard>[
    ProfileCard(
      title: 'Кабінет клієнта СК "Форте Лайф"',
      description:
          'Особистий кабінет клієнта з розширеним функціоналом (ваші договори, платежі тощо)',
      image: 'assets/images/profile1.png',
      url: 'https://cc.forte-life.com.ua',
    ),
    ProfileCard(
      title: 'Кабінет страхового агента Fort-On',
      description:
          'Робочий кабінет агента, у якому можна побачити власну структуру, комісійну винагороду, інформацію з укладених договорів тощо',
      image: 'assets/images/profile2.png',
      url: 'https://agent.forte-life.com.ua',
    ),
    ProfileCard(
      title: 'Кабінет по програмі Вельс',
      description:
          'Пенсійна програма європейського рівня, яка вигідна всім без винятку! Надає захист та добробут не лише клієнтам, а й фінансовим консультантам',
      image: 'assets/images/profile3.png',
      url: 'https://wels.forte-life.com.ua',
    ),
  ];
}
