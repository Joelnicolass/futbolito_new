import 'package:animate_do/animate_do.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:futbolitonew/common/domain/entities/color_foundation_entity.dart';
import 'package:futbolitonew/common/domain/entities/spacing_foundation_entity.dart';
import 'package:futbolitonew/common/presentation/widgets/foundation/text/text.dart';
import 'package:futbolitonew/core/intl/intl.dart';

/// Widget del encabezado del login (logo y textos)
class LoginHeader extends StatelessWidget {
  const LoginHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Positioned(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: ColorFoundation.cardBackground.color,
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: ColorFoundation.background.color,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Positioned(
              child: Bounce(
                from: 20,
                child: SvgPicture.asset(
                  'assets/svg/soccer_ball.svg',
                  height: 80,
                  colorFilter: ColorFilter.mode(
                    ColorFoundation.dark.color,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ],
        ),

        Translate.welcome.toTextFoundation(
          align: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 32,
            color: ColorFoundation.textPrimary.color,
          ),
        ),

        SpacingFoundation.lg.spacer,

        Translate.loginSubtitle.toTextFoundation(type: TextType.bodyText1),
      ],
    );
  }
}
