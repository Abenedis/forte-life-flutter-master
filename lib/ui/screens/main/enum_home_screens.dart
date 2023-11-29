import 'package:forte_life/utils/constants/asset_images.dart';
import 'package:forte_life/utils/constants/strings.dart';

class HomeScreenType {
  static const HomeScreenType PROGRAMS = HomeScreenType(
    0,
    Strings.online_insurance,
    Strings.programs,
    AssetsImages.ic_programs,
  );
  static const HomeScreenType INFO = HomeScreenType(
    1,
    Strings.information,
    Strings.information,
    AssetsImages.ic_info,
  );
  static const HomeScreenType NEWS = HomeScreenType(
    2,
    Strings.news,
    Strings.news,
    AssetsImages.ic_news,
  );

  final String title;
  final String buttonText;
  final String iconPath;
  final int index;

  const HomeScreenType(this.index, this.title, this.buttonText, this.iconPath);
}
