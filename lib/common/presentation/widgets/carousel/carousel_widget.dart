import 'package:flutter/material.dart' hide Card;
import 'package:futbolitonew/common/domain/entities/padding_foundation_entity.dart';
import 'package:futbolitonew/common/presentation/widgets/foundation/card/card_body.dart';
import 'package:futbolitonew/common/presentation/widgets/foundation/card/card_footer_with_actions.dart';
import 'package:futbolitonew/common/presentation/widgets/foundation/card/card_header.dart';
import 'package:futbolitonew/common/presentation/widgets/foundation/card/card_widget.dart';
import 'package:futbolitonew/common/presentation/widgets/foundation/button/button_foundation_widget.dart';
import 'package:futbolitonew/common/presentation/widgets/foundation/text/text_foundation_widget.dart';

class Carousel extends StatelessWidget {
  const Carousel({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        itemCount: 10,
        scrollDirection: Axis.horizontal,
        itemExtent: MediaQuery.of(context).size.width * 0.8,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
              left: index == 0 ? PaddingFoundation.sm.value : 0,
              right: index == 9
                  ? PaddingFoundation.sm.value
                  : PaddingFoundation.sm.value,
              top: PaddingFoundation.md.value,
              bottom: PaddingFoundation.md.value,
            ),
            child: CardFoundation(
              index: index,
              onPressed: () {
                print('Card ${index + 1} pressed');
              },
              header: CardHeader(
                title: 'Card ${index + 1}',
                subtitle: 'Subtitle for card ${index + 1}',
                icon: Icon(Icons.star, color: Colors.amber, size: 32),
              ),
              body: CardBody(
                child: TextFoundation(
                  text: 'Custom content here',
                  style: TextStyle(fontSize: 12),
                ),
              ),
              footer: CardFooterWithActions(
                primaryAction: ButtonFoundation(
                  text: 'Primary',
                  type: ButtonFoundationType.primary,
                  size: ButtonFoundationSize.sm,
                  onPressed: () {
                    print('Primary action on Card ${index + 1}');
                  },
                ),
                secondaryAction: ButtonFoundation(
                  text: 'Secondary',
                  type: ButtonFoundationType.secondary,
                  size: ButtonFoundationSize.sm,
                  onPressed: () {
                    print('Secondary action on Card ${index + 1}');
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
