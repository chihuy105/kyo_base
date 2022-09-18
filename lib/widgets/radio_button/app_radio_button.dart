// import 'package:kyo_base/imports/all_file.dart';
//
// class AppRadioButton<T> extends _BaseRadioButton<T> {
//   AppRadioButton({
//     required T value,
//     T? groupValue,
//     VoidCallback? onTap,
//     Widget? child,
//   }) : super(
//           value: value,
//           groupValue: groupValue,
//           onTap: onTap,
//           child: child,
//         );
//
//   factory AppRadioButton.withLabel(
//     String label, {
//     required T value,
//     T? groupValue,
//     VoidCallback? onTap,
//   }) {
//     return AppRadioButton<T>(
//       value: value,
//       groupValue: groupValue,
//       onTap: onTap,
//       child: Builder(
//         builder: (context) => Text(
//           label,
//           style: Theme.of(context).textTheme.subtitle1!.copyWith(
//             color: Utilities.colors.titleColor,
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class _BaseRadioButton<T> extends StatelessWidget {
//   final T value;
//   final T? groupValue;
//   final VoidCallback? onTap;
//   final Widget? child;
//
//   _BaseRadioButton({
//     Key? key,
//     this.child,
//     required this.value,
//     this.groupValue,
//     this.onTap,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final isSelected =
//         value != null && groupValue != null && value == groupValue;
//     return Container(
//       decoration: BoxDecoration(
//         border: Border.all(
//           color: isSelected
//               ? context.theme.primaryColor
//               : Colors.transparent,
//         ),
//         borderRadius: BorderRadius.circular(4.0),
//       ),
//       child: CupertinoButton(
//         padding: EdgeInsets.all(7.0),
//         minSize: 20.0,
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             isSelected
//                 ? Utilities.icon.radioSelected
//                 : Utilities.icon.radioUnSelected,
//             if (child != null)
//               Padding(padding: EdgeInsets.only(left: 5.0), child: child),
//           ],
//         ),
//         onPressed: onTap,
//       ),
//     );
//   }
// }
