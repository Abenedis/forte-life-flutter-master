import 'package:flutter/material.dart';
import 'package:forte_life/app/dimen.dart';
import 'package:forte_life/ui/screens/profile/profile_card.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileListItem extends StatelessWidget {
  const ProfileListItem({
    Key key,
    this.profileCard,
    this.isSmallPadding = false,
  }) : super(key: key);
  final ProfileCard profileCard;
  final bool isSmallPadding;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 16,
      child: InkWell(
        onTap: _onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                padding: isSmallPadding
                    ? const EdgeInsets.all(8.0)
                    : const EdgeInsets.all(16.0),
                child: Image.asset(
                  profileCard.image,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    profileCard.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: StandardDimensions.text_title,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    profileCard.description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onTap() {
    launch(profileCard.url);
  }
}
