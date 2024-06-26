import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/widgets.dart';
import 'package:profinix_tech/constants/colors.dart';
import 'package:profinix_tech/constants/size.dart';
import 'package:profinix_tech/widgets/contact_page.dart';
import 'package:profinix_tech/widgets/drawer_mobile.dart';
import 'package:profinix_tech/widgets/footer.dart';
import 'package:profinix_tech/widgets/fourthpage_section.dart';
import 'package:profinix_tech/widgets/header_desktop.dart';
import 'package:profinix_tech/widgets/header_mobile.dart';
import 'package:profinix_tech/widgets/main_desktop.dart';
// import 'package:pr_web_test/widgets/main_mobile.dart';
import 'package:profinix_tech/widgets/second_desktop.dart';
import 'package:profinix_tech/widgets/second_mobile.dart';
import 'package:profinix_tech/widgets/third_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final scrollController = ScrollController();
  final List<GlobalKey> navbarKeys = List.generate(4, (index) => GlobalKey());

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: CustomColor.scaffoldBg,
      endDrawer: screenWidth >= kMinDesktopWidth
          ? null
          : DrawerMobile(
              onNavItemTap: (int navIndex) {
                scaffoldKey.currentState?.closeEndDrawer();
                if (navIndex == 1) {
                  Navigator.pushNamed(context, '/shoppinghomepage');
                } else {
                  scrollToSection(navIndex);
                }
              },
            ),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: screenWidth >= kMinDesktopWidth
            ? HeaderDesktop(
                onNavMenuTap: (int navIndex) {
                  if (navIndex == 3) {
                    Navigator.pushNamed(context, '/shoppinghomepage');
                  } else {
                    scrollToSection(navIndex);
                  }
                },
              )
            : HeaderMobile(
                onLogoTap: () {},
                onMenuTap: () {
                  scaffoldKey.currentState?.openEndDrawer();
                },
              ),
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(key: navbarKeys.first),
            MainDesktop(),
            Container(
              width: screenWidth,
              padding: const EdgeInsets.fromLTRB(25, 20, 25, 60),
              color: CustomColor.bgLight1,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Main Features",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: CustomColor.whitePrimary,
                    ),
                  ),
                  const SizedBox(height: 50),
                  screenWidth >= kMedDesktopWidth
                      ? SecondDesktop()
                      : SecondMobile(),
                ],
              ),
            ),
            ThirdPage(),
            SizedBox(height: 20),
            const FourthpageSection(),
            const SizedBox(height: 30),
            Container(
              width: double.infinity,
              color: CustomColor.bgLight1,
              padding: const EdgeInsets.fromLTRB(25, 20, 25, 60),
              child: Column(
                children: [
                  const Text(
                    "Works All Over the World",
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: CustomColor.whitePrimary,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: Image.asset(
                      "newworld.png",
                      width: screenWidth * 0.8,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ContactPage(
              key: navbarKeys[1],
            ),
            const Footer(),
            //PP & Tc
          ],
        ),
      ),
    );
  }

  void scrollToSection(int navIndex) {
    if (navIndex == 2) {
      Navigator.pushNamed(context, '/joinus');
      return;
    }

    final key = navbarKeys[navIndex];
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}
