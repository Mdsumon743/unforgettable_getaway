import 'package:flutter/material.dart';
import 'package:unforgettable_getaway/core/const/const.dart';
import 'package:unforgettable_getaway/feature/meet_people/presentation/widget/custom_profile_view_card.dart';

class CustomGridviewProfile extends StatelessWidget {
  const CustomGridviewProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: Const.userProfileDetails.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      primary: false,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 0.5 / 0.68),
      itemBuilder: (context, index) {
        var data = Const.userProfileDetails[index];
        return CustomProfileViewCard(
          image: data['images'],
          adress: data['adress'],
          age: data['age'],
          country: data['country'],
          distance: data['nerme'],
          level: data['level'],
          love: data['love'],
          name: data['name'],
          status: data['status'],
        );
      },
    );
  }
}
