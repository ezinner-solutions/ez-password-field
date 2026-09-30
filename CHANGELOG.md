## 0.0.3

* **Drop-in Parity:** Added full support for standard `TextFormField` properties (`initialValue`, `focusNode`, `autovalidateMode`, `enabled`, `readOnly`, `autofocus`, `textInputAction`, `keyboardType`, `style`, `textAlign`, `cursorColor`, `inputFormatters`, `autofillHints`, `scrollPadding`, `maxLength`, `onSaved`, `onFieldSubmitted`, `onEditingComplete`, `onTap`).
* **Enhanced Visibility Toggle:** Added `visibilityIcon`, `visibilityOffIcon`, `initiallyObscure`, `showVisibilityToggle`, and `onVisibilityChanged` callback.
* **Validation Improvements:** Added `required` (default `true`) and `requiredMessage` with customizable fallback.
* **Design & UX:** Added default lock prefix icon, modern rounded outline border, and automated `AutofillHints.password`.
* **Testing & Architecture:** Expanded test coverage and modernized example.

## 0.0.2

* **Docs:** Added `FUNDING.yml` and updated `pubspec.yaml` metadata.

## 0.0.1

* Initial release of the `ez_password_field` widget.
* Features:
    * Visibility toggle.
    * Configurable validation rules (length, uppercase, lowercase, digits, special chars).
    * Robustness features (prohibit spaces, dashes, etc.).
