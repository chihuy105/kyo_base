import 'package:kyo_base/imports/base_component_import.dart';

class SingleChildScrollViewSliver extends StatelessWidget {
  const SingleChildScrollViewSliver({Key? key, required this.child, this.hasScrollBody}) : super(key: key);

  final Widget child;
  final bool? hasScrollBody;

  @override
  Widget build(BuildContext context) {
    // if (hasScrollBody == true) {
    if (true) {
      return CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                child,
              ],
            ),
          ),
        ],
      );
    }

    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: hasScrollBody ?? false,
          child: Column(
            children: [
              child,
            ],
          ),
        ),
      ],
    );
  }
}

