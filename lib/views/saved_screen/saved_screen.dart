import 'package:flutter/material.dart';
import 'package:propertify_for_agents/resources/constants/spaces%20&%20paddings/paddings.dart';
import 'package:propertify_for_agents/resources/constants/spaces%20&%20paddings/spaces.dart';
import 'package:propertify_for_agents/resources/fonts/app_fonts/app_fonts.dart';

class SavedScreen extends StatelessWidget {
  SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customSpaces.verticalspace20,
            Padding(
              padding: customPaddings.horizontalpadding20,
              child: Text(
                "Favourites",
                style: AppFonts.SecondaryColorText28,
              ),
            ),
            customSpaces.verticalspace10,
            Padding(
              padding: customPaddings.horizontalpadding20,
              child: InkWell(
                onTap: () {
                  // Navigator.of(context).push(MaterialPageRoute(
                  //   builder: (context) => PropertyDetailsScreen(),
                  // ));
                },
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1 / 1.2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container();
                    
                    // homePageCardSingle(
                    //   cardwidth: 100,
                    // );
                  },
                  itemCount: 3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
