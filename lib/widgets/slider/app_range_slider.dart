import 'package:kyo_base/imports/base_component_import.dart';
import 'package:reactive_range_slider/reactive_range_slider.dart';

class AppReactiveRangeSlider extends StatelessWidget {
  AppReactiveRangeSlider({
    Key? key,
    required this.formControlName,
    required this.min,
    required this.max,
    required this.divisions,
    int? stepDivisions,
    this.showDivisionLabel = true,
    required this.unit,
    this.showPlusAtMax = false,
    this.labelBuilder,
  }) : super(key: key) {
    stepLabelList = [
      for (var i = min; i <= max; i += max / (stepDivisions ?? divisions)) i
    ].mapAsList((item) {
      return item;
    });
  }

  final String formControlName;
  final double min;
  final double max;
  final int divisions;
  final bool showDivisionLabel;
  final String unit;
  final bool showPlusAtMax;
  late final List<num> stepLabelList;
  final String Function(double value)? labelBuilder;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ReactiveRangeSlider<RangeValues>(
          formControlName: formControlName,
          min: min,
          max: max,
          divisions: divisions,
          labelBuilder: (values) => RangeLabels(
            '${getLabel(values.start).toString()}${showUnit(values.start)}',
            '${getLabel(values.end).toString()} ${showUnit(values.end)}${showPlus(values.end)}',
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: Dimens.edge_zero,
          ),
        ),
        if (showDivisionLabel)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: stepLabelList.mapAsListIndexed(
              (item, index) {
                var itemToStr = item.toThousandSeparator();
                if (index == 0) {
                  return itemToStr.text.textMidXS
                      .colorHint(context)
                      .make()
                      .expand(flex: 11);
                }
                if (index == (stepLabelList.length - 1)) {
                  return '$itemToStr $unit${showPlus(item)}'
                      .text
                      .textMidXS
                      .end
                      .colorHint(context)
                      .make()
                      .expand(flex: 11);
                }
                return itemToStr.text.textMidXS.center
                    .colorHint(context)
                    .make()
                    .expand(flex: 20);
              },
            ),
          ).pxDefault(),
      ],
    );
  }

  String getLabel(double value) {
    if (labelBuilder != null) {
      return labelBuilder!(value);
    }
    return value.round().toThousandSeparator();
  }

  String showUnit(num value) => value == min ? '' : ' $unit';

  String showPlus(num value) => showPlusAtMax && value == max ? '+' : '';
}
