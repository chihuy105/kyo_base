// ignore_for_file: invalid_use_of_protected_member

import 'package:kyo_base/imports/base_component_import.dart';
import 'package:velocity_x/velocity_x.dart';
import 'dart:math' as math;

bool canPop(BuildContext context) => ModalRoute.of(context)?.canPop ?? false;

class SliverListExtend {
  static SliverList separator(
      {required Widget Function(int index) delegateBuilder,
      required int childCount,
      required Widget separator,
      Widget? tail}) {
    final tailCount = tail != null ? 1 : 0;

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          final int itemIndex = index ~/ 2;
          if (index.isEven) {
            if (tailCount == 1 && itemIndex == childCount) {
              return tail;
            }

            return delegateBuilder(itemIndex);
          }
          return separator;
        },
        semanticIndexCallback: (Widget widget, int localIndex) {
          if (localIndex.isEven) return localIndex ~/ 2;
          return null;
        },
        childCount: math.max(0, (childCount + tailCount) * 2 - 1),
      ),
    );
  }
}

extension NullExtend on dynamic {
  dynamic checkEmpty() {
    if (this == null) return Gaps.empty;
    return this;
  }
}

// ignore: unnecessary_this
extension ThemeExtend on ThemeData {
  Color defaultTextColor() {
    return primaryTextTheme.bodyText2!.color!;
  }

  Color onPrimary() {
    return colorScheme.onPrimary;
  }

  Color onAccent() {
    return primaryTextTheme.bodyText2!.color!;
  }

  Color lightGrey() {
    return hintColor.withOpacity(0.6);
  }

  Color darkText() {
    return Get.isDarkMode ? Colors.white : Colors.black;
  }
}

extension ListWidgetExtend<T extends Widget> on List<T> {
  List<Widget> withDivider(Widget divider,
      {bool showLast = false, bool showFirst = false}) {
    if (isNullOrEmpty()) return [];

    List<Widget> rs = [];
    if (showFirst) {
      rs.add(divider);
    }
    forEach((element) {
      rs.add(element);
      rs.add(divider);
    });
    if (!showLast) {
      rs.removeLast();
    }
    return rs;
  }
}

extension VxTextBuilderExtend on VxTextBuilder {
  VxTextBuilder get textXS => size(Dimens.text_XS);

  VxTextBuilder get textMidXS => size(Dimens.text_mid_XS);

  VxTextBuilder get textS => size(Dimens.text_S);

  VxTextBuilder get textBase => size(Dimens.text);

  VxTextBuilder get textL => size(Dimens.text_L);

  VxTextBuilder get textLMid => size(Dimens.text_L_mid);

  VxTextBuilder get textXL => size(Dimens.text_XL);

  VxTextBuilder colorPrimary(BuildContext context) {
    velocityColor = Theme.of(context).primaryColor;
    return this;
  }

  VxTextBuilder colorError(BuildContext context) {
    velocityColor = Theme.of(context).errorColor;
    return this;
  }

  VxTextBuilder colorTransparent(BuildContext context) {
    velocityColor = Colors.transparent;
    return this;
  }

  VxTextBuilder colorOnPrimary(BuildContext context) {
    velocityColor = Theme.of(context).onPrimary();
    return this;
  }

  VxTextBuilder colorOnAccent(BuildContext context) {
    velocityColor = Theme.of(context).onAccent();
    return this;
  }

  VxTextBuilder colorLink(BuildContext context) {
    velocityColor = context.themeColor.link;
    return this;
  }

  VxTextBuilder colorHint(BuildContext context) {
    velocityColor = Theme.of(context).hintColor;
    return this;
  }

  VxTextBuilder colorN3(BuildContext context) {
    velocityColor = context.themeColor.n3;
    return this;
  }

  VxTextBuilder colorGray(BuildContext context) {
    velocityColor = context.themeColor.gray;
    return this;
  }

  VxTextBuilder colorGray5(BuildContext context) {
    velocityColor = context.themeColor.gray5;
    return this;
  }

  VxTextBuilder price() {
    return this;
  }
}

extension StringVelocityExtend on String {
  /// Get Text Widget for the String
  VxTextBuilder get text => VxTextBuilder(this).isIntrinsic;

  VxTextBuilder get textAuto => VxTextBuilder(this);
}

extension WidgetExtend on Widget {

  Widget isVisible(bool isLogin) {
    return isLogin
        ? this
        : Gaps.empty;
  }

  Widget visible(bool visible, {Key? key}) =>
      Opacity(
        key: key,
        opacity: visible ? 1: 0,
        child: this,
      );

  Flexible flex({Key? key, int flex = 1, FlexFit fit = FlexFit.loose}) =>
      Flexible(
        key: key,
        flex: flex,
        fit: fit,
        child: this,
      );

  Padding pExceptLeft(double padding, {Key? key}) => Padding(
    key: key,
    padding: EdgeInsets.fromLTRB(0, padding, padding, padding),
    child: this,
  );

  Padding pExceptTop(double padding, {Key? key}) => Padding(
    key: key,
    padding: EdgeInsets.fromLTRB(padding, 0, padding, padding),
    child: this,
  );

  Padding pExceptRight(double padding, {Key? key}) => Padding(
    key: key,
    padding: EdgeInsets.fromLTRB(padding, padding, 0, padding),
    child: this,
  );

  Padding pExceptBottom(double padding, {Key? key}) => Padding(
    key: key,
    padding: EdgeInsets.fromLTRB(padding, padding, padding, 0),
    child: this,
  );

  Padding pDefault({Key? key}) => Padding(
        key: key,
        padding: const EdgeInsets.all(Dimens.pad_default),
        child: this,
      );

  Padding pDefaultExceptTop({Key? key}) => Padding(
        key: key,
        padding: const EdgeInsets.only(
            bottom: Dimens.pad_default,
            left: Dimens.pad_default,
            right: Dimens.pad_default,
        ),
        child: this,
      );

  Padding pDefaultExceptBottom({Key? key}) => Padding(
        key: key,
        padding: const EdgeInsets.only(
            top: Dimens.pad_default,
            left: Dimens.pad_default,
            right: Dimens.pad_default),
        child: this,
      );

  Padding pxDefault({Key? key}) => Padding(
        key: key,
        padding: const EdgeInsets.symmetric(horizontal: Dimens.pad_default),
        child: this,
      );

  Padding px6({Key? key}) => Padding(
        key: key,
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: this,
      );

  Padding pyDefault({Key? key}) => Padding(
        key: key,
        padding: const EdgeInsets.symmetric(vertical: Dimens.pad_default),
        child: this,
      );

  Padding pLeft4({Key? key}) => Padding(
        key: key,
        padding: const EdgeInsets.only(left: Dimens.gap_dp4),
        child: this,
      );

  Padding pLeft8({Key? key}) => Padding(
        key: key,
        padding: const EdgeInsets.only(left: Dimens.gap_dp8),
        child: this,
      );

  Padding pLeft12({Key? key}) => Padding(
        key: key,
        padding: const EdgeInsets.only(left: Dimens.gap_dp12),
        child: this,
      );

  Padding pLeftDefault({Key? key}) => Padding(
        key: key,
        padding: const EdgeInsets.only(left: Dimens.pad_default),
        child: this,
      );

  Padding pRight4({Key? key}) => Padding(
        key: key,
        padding: const EdgeInsets.only(right: Dimens.gap_dp4),
        child: this,
      );

  Padding pRight8({Key? key}) => Padding(
        key: key,
        padding: const EdgeInsets.only(right: Dimens.gap_dp8),
        child: this,
      );

  Padding pRight6({Key? key}) => Padding(
        key: key,
        padding: const EdgeInsets.only(right: Dimens.gap_dp6),
        child: this,
      );

  Padding pRight12({Key? key}) => Padding(
        key: key,
        padding: const EdgeInsets.only(right: Dimens.gap_dp12),
        child: this,
      );

  Padding pRightDefault({Key? key}) => Padding(
        key: key,
        padding: const EdgeInsets.only(right: Dimens.pad_default),
        child: this,
      );

  Padding pTopDefault({Key? key}) => Padding(
        key: key,
        padding: const EdgeInsets.only(top: Dimens.pad_default),
        child: this,
      );

  Padding pBottomDefault({Key? key}) => Padding(
        key: key,
        padding: const EdgeInsets.only(bottom: Dimens.pad_default),
        child: this,
      );

  // 430 screen width on mobile
  ConstrainedBox maxWidth({Key? key, double maxWidth = 430}) {
    return ConstrainedBox(
      key: key,
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: this,
    );
  }

  ConstrainedBox maxHeight({Key? key, required double maxHeight}) {
    return ConstrainedBox(
      key: key,
      constraints: BoxConstraints(maxHeight: maxHeight),
      child: this,
    );
  }

  ConstrainedBox minWidth({Key? key, double minWidth = 430}) {
    return ConstrainedBox(
      key: key,
      constraints: BoxConstraints(minWidth: minWidth),
      child: this,
    );
  }

  ConstrainedBox minHeight(double minHeight, {Key? key}) {
    return ConstrainedBox(
      key: key,
      constraints: BoxConstraints(minHeight: minHeight),
      child: this,
    );
  }

  Padding pb24({Key? key}) => Padding(
        key: key,
        padding: const EdgeInsets.only(bottom: Vx.dp24),
        child: this,
      );

  Padding pb20({Key? key}) => Padding(
        key: key,
        padding: const EdgeInsets.only(bottom: Vx.dp20),
        child: this,
      );

  Padding pb16({Key? key}) => Padding(
        key: key,
        padding: const EdgeInsets.only(bottom: Vx.dp16),
        child: this,
      );

  Padding pb12({Key? key}) => Padding(
        key: key,
        padding: const EdgeInsets.only(bottom: Vx.dp12),
        child: this,
      );

  Padding pb10({Key? key}) => Padding(
        key: key,
        padding: const EdgeInsets.only(bottom: Vx.dp10),
        child: this,
      );

  Padding pb4({Key? key}) => Padding(
        key: key,
        padding: const EdgeInsets.only(bottom: Vx.dp4),
        child: this,
      );

  Padding pb8({Key? key}) => Padding(
        key: key,
        padding: const EdgeInsets.only(bottom: Vx.dp8),
        child: this,
      );

  Padding pt24({Key? key}) => Padding(
        key: key,
        padding: const EdgeInsets.only(top: Vx.dp24),
        child: this,
      );

  Padding pt20({Key? key}) => Padding(
        key: key,
        padding: const EdgeInsets.only(top: Vx.dp20),
        child: this,
      );

  Padding pt16({Key? key}) => Padding(
        key: key,
        padding: const EdgeInsets.only(top: Vx.dp16),
        child: this,
      );

  Padding pt12({Key? key}) => Padding(
        key: key,
        padding: const EdgeInsets.only(top: Vx.dp12),
        child: this,
      );

  Padding pr12({Key? key}) => Padding(
        key: key,
        padding: const EdgeInsets.only(right: Vx.dp12),
        child: this,
      );

  Padding pt8({Key? key}) => Padding(
        key: key,
        padding: const EdgeInsets.only(top: Vx.dp8),
        child: this,
      );

  Padding pt6({Key? key}) => Padding(
        key: key,
        padding: const EdgeInsets.only(top: Vx.dp6),
        child: this,
      );

  Padding pt4({Key? key}) => Padding(
        key: key,
        padding: const EdgeInsets.only(top: Vx.dp4),
        child: this,
      );

  Padding px8y4({Key? key}) => Padding(
        key: key,
        padding: const EdgeInsets.symmetric(horizontal: Dimens.gap_dp8, vertical: Dimens.gap_dp4),
        child: this,
      );
}
