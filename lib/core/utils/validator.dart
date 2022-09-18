import 'package:email_validator/email_validator.dart';
import 'package:kyo_base/imports/base_component_import.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ValidatorPair {
  final AbstractControl<dynamic>? control;
  final String? formControlName;
  final ValidatorFunction? validatorFunction;
  final String? msg;

  ValidatorPair(
      {this.control,
      this.formControlName,
      required this.validatorFunction,
      required this.msg});

  /// Check if the validation correct
  /// - If valid -> return "null"
  /// - If not valid -> return error msg
  String? getValidMsg({FormGroup? form}) {
    if (formControlName != null && form == null) {
      throw ('form must not be null when use formControlName');
    }
    var _control = control ?? form?.controls[formControlName];

    if (validatorFunction != null && _control != null) {
      if (!validatorFunction!(_control).isNullOrEmpty()) {
        return msg;
      }
    }
    return null;
  }
}

class AppValidator {
  AppValidator._();

  static String validatingString(List<ValidatorPair> map, {FormGroup? form}) {
    return map
        .mapAsList<String?>((item) {
          return item.getValidMsg(form: form);
        })
        .filterAsList((item) => !item.isNullOrEmpty())
        .join('\n');
  }

  static String validatingStringForm({
    required List<ValidatorPair> map,
    required FormGroup form,
  }) {
    return map
        .mapAsList<String?>((item) {
          return item.getValidMsg(form: form);
        })
        .filterAsList((item) => !item.isNullOrEmpty())
        .join('\n');
  }

  static String validatingStringAppPhone(
      FormGroup form, String formControlName) {
    return AppValidator.validatingStringForm(
      map: [
        ValidatorPair(
          msg: 'phoneNotValid'.tr,
          formControlName: formControlName,
          validatorFunction:
              Validators.pattern(AppValidator.phoneNumberVnRegex),
        ),
        ValidatorPair(
          msg: 'phoneNotValid'.tr,
          formControlName: formControlName,
          validatorFunction: Validators.required,
        )
      ],
      form: form,
    );
  }

  static String validatingStringAppEmail(
      FormGroup form, String formControlName) {
    return AppValidator.validatingStringForm(
      map: [
        ValidatorPair(
          msg: 'emailNotValid'.tr,
          formControlName: formControlName,
          validatorFunction: Validators.email,
        ),
        ValidatorPair(
          msg: 'emailNotValid'.tr,
          formControlName: formControlName,
          validatorFunction: Validators.required,
        ),
      ],
      form: form,
    );
  }

  static bool showDialogError({
    required BuildContext context,
    required List<ValidatorPair> map,
    required FormGroup form,
  }) {
    String validatingString = AppValidator.validatingStringForm(
      form: form,
      map: map,
    );
    logger.i(validatingString);

    if (!validatingString.isNullOrEmpty()) {
      DialogUtils.showAlertDialog(context,
          content: validatingString.toString());
      return true;
    }
    return false;
  }

  static const Pattern phoneNumberVnRegex = r'(^(?:[+0]9)?[0-9]{10,11}$)';

  static const Pattern passwordRegex =
      r'^(?=.*[a-zA-Z])(?=.*[0-9])[A-Za-z0-9$@$!%*?&#]{8,}$';

  static const Pattern simpleUrlRegex =
      r'(?:[a-zA-Z]|[0-9]|[$-_@.&+]|[!*\(\),]|(?:%[0-9a-fA-F][0-9a-fA-F]))';

  static bool checkPhoneNumber(String? phone) {
    if (phone.isNullOrEmpty()) {
      return false;
    }

    final RegExp regex = RegExp(phoneNumberVnRegex as String);

    if (regex.stringMatch(phone!) == phone) {
      return true;
    } else {
      return false;
    }
  }

  static bool checkName(String name) {
    const Pattern pattern = r'[!@#<>?":_`~;.,/[\]\\|=+)(*&^%0-9-]';

    final RegExp regex = RegExp(pattern as String);
    return !regex.hasMatch(name);
  }

  static bool checkEmail(String? email) {
    if (email.isNullOrEmpty()) {
      return false;
    }

    return EmailValidator.validate(email!);
  }

  static bool checkUrl(String? url) {
    if (url.isNullOrEmpty()) {
      return false;
    }

    return Uri.tryParse(url!)?.hasAbsolutePath ?? false;
  }

  static bool checkSimpleUrl(String? url) {
    if (url.isNullOrEmpty()) {
      return false;
    }

    return true;
    // final RegExp regex = RegExp(simpleUrlRegex as String);
    // return regex.hasMatch(url!);
  }

  static bool hasSpecialCharacter(String name) {
    const Pattern pattern = r'[.!@#<>?":_`~;[\]\\|=+)(*&^%-]';

    final RegExp regex = RegExp(pattern as String);
    return regex.hasMatch(name);
  }

  static bool hasCapitalCharacter(String name) {
    const Pattern pattern = r'.*[A-Z].*';
    final RegExp regex = RegExp(pattern as String);
    return regex.hasMatch(name);
  }

  static bool hasLowercaseCharacter(String name) {
    const Pattern pattern = r'.*[a-z].*';
    final RegExp regex = RegExp(pattern as String);
    return regex.hasMatch(name);
  }

  static bool hasNumber(String name) {
    const Pattern pattern = r'.*[0-9].*';
    final RegExp regex = RegExp(pattern as String);
    return regex.hasMatch(name);
  }

  static bool checkFilePathWithExtensions(
      String path, List<String> extensions) {
    final String extension = extensions.join('|');
    final Pattern pattern =
        '^([A-Za-z_\\s0-9\\.]|\\\\[a-z_\\-\\s0-9\\.]+)+\\.($extension)\$';
    final RegExp regex = RegExp(pattern as String);

    if (regex.stringMatch(path) == path) {
      return true;
    } else {
      return false;
    }
  }
}
