# EzPasswordField

A drop-in Flutter `TextFormField` specifically designed for password input with built-in visibility toggle, multi-rule validation, character prohibitions, and mobile autofill support.

[![pub package](https://img.shields.io/pub/v/ez_password_field.svg)](https://pub.dev/packages/ez_password_field)
[![likes](https://img.shields.io/pub/likes/ez_password_field.svg)](https://pub.dev/packages/ez_password_field)
[![pub points](https://img.shields.io/pub/points/ez_password_field.svg)](https://pub.dev/packages/ez_password_field)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

## Problem Statement

Building password fields in Flutter repeatedly involves boilerplate and poor default user experiences:

1. **Visibility State Boilerplate:** Manually creating state variables, `IconButton` toggles, and icons to obscure or reveal passwords.
2. **Fragmented Validation UX:** Showing errors one-by-one (e.g. failing length -> user fixes -> failing uppercase -> user fixes -> failing digit), frustrating users.
3. **Missing Autofill:** Forgetting `autofillHints: const [AutofillHints.password]`, preventing OS and browser password managers from suggesting credentials.
4. **PIN / Alphanumeric Restrictions:** Writing custom input formatters or regex to forbid spaces, dashes, or letters for numeric credentials.

### Targeted Error Signatures & Defects
* `"Password is required"`
* Fragmented, incremental validation error feedback
* Missing browser and OS password manager suggestions (`AutofillHints.password`)

## Technical Solution

`EzPasswordField` encapsulates password input best practices into a single drop-in widget:

1. **Built-in Visibility Toggle:** Toggles obscured text state out of the box with customizable icons, initial state, and state change callbacks.
2. **Aggregated Multi-Rule Validation:** Combines all missing password requirements into a single clear error message (e.g. *"Issues: no spaces, at least 8 characters, a digit"*).
3. **Character Prohibitions:** Built-in boolean flags to prohibit spaces, dashes, letters, digits, or special characters (useful for PIN codes).
4. **Mobile Autofill Integration:** Configured with `AutofillHints.password` out of the box.
5. **100% Drop-in Parity:** Supports all standard `TextFormField` properties (`initialValue`, `controller`, `focusNode`, `autovalidateMode`, `onSaved`, `onFieldSubmitted`, etc.).

## Installation

```shell
flutter pub add ez_password_field
```

## Quick Migration

Replace standard `TextFormField` with `EzPasswordField`:

```diff
- TextFormField(
-   obscureText: _isObscure,
-   decoration: InputDecoration(
-     suffixIcon: IconButton(onPressed: () => setState(() => _isObscure = !_isObscure), ...),
-   ),
+ EzPasswordField(
    onSaved: (pass) => _password = pass,
  )
```

## Usage Examples

### 1. Basic Form Integration

```dart
Form(
  key: _formKey,
  child: Column(
    children: [
      EzPasswordField(
        labelText: 'Password',
        onSaved: (val) => _password = val,
      ),
      ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
          }
        },
        child: const Text('Submit'),
      ),
    ],
  ),
)
```

### 2. PIN Mode (Numeric Only)

```dart
EzPasswordField(
  labelText: 'PIN',
  hintText: 'Enter 4 digits',
  minLength: 4,
  requireUppercase: false,
  requireLowercase: false,
  requireSpecialChars: false,
  requireDigits: true,
  prohibitLetters: true,
  prohibitSpecialChars: true,
  prohibitSpaces: true,
  prohibitDashes: true,
  keyboardType: TextInputType.number,
)
```

### 3. Custom Validation Logic

Add additional checks on top of the built-in validation rules:

```dart
EzPasswordField(
  validator: (value) {
    if (value != null && value.toLowerCase().contains('password')) {
      return 'Password cannot contain the word "password"';
    }
    return null;
  },
)
```

### 4. Custom Styling & Toggle Icons

```dart
EzPasswordField(
  visibilityIcon: const Icon(Icons.lock_open_rounded),
  visibilityOffIcon: const Icon(Icons.lock_rounded),
  decoration: InputDecoration(
    labelText: 'Master Password',
    border: const OutlineInputBorder(),
  ),
)
```

## API Reference

| Property | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `controller` | `TextEditingController?` | `null` | Controls the text being edited. |
| `initialValue` | `String?` | `null` | Initial text value when no controller is provided. |
| `focusNode` | `FocusNode?` | `null` | Defines keyboard focus for the field. |
| `labelText` | `String?` | `'Password'` | Label text for input decoration. |
| `hintText` | `String?` | `null` | Hint text suggesting accepted format. |
| `required` | `bool` | `true` | Whether the field is required. |
| `requiredMessage` | `String?` | `null` | Error message when required field is empty. |
| `minLength` | `int` | `8` | Minimum required password length. |
| `requireUppercase` | `bool` | `true` | Requires at least one uppercase letter. |
| `requireLowercase` | `bool` | `true` | Requires at least one lowercase letter. |
| `requireDigits` | `bool` | `true` | Requires at least one numeric digit. |
| `requireSpecialChars` | `bool` | `true` | Requires at least one special character. |
| `prohibitSpaces` | `bool` | `true` | Forbids whitespace in the password. |
| `prohibitDashes` | `bool` | `false` | Forbids dashes in the password. |
| `prohibitLetters` | `bool` | `false` | Forbids alphabetic characters (useful for PINs). |
| `showVisibilityToggle` | `bool` | `true` | Whether to display the eye visibility toggle icon button. |
| `initiallyObscure` | `bool` | `true` | Whether text starts in obscured mode. |
| `onVisibilityChanged` | `ValueChanged<bool>?` | `null` | Callback invoked when visibility is toggled. |
| `validator` | `FormFieldValidator<String>?` | `null` | Additional validator executed after built-in rules pass. |
| `autofillHints` | `Iterable<String>?` | `[AutofillHints.password]` | Autofill hints for mobile/browser credential managers. |

## Sponsoring & Support

If this package saved you debugging time, consider supporting ongoing maintenance:
* [GitHub Sponsors](https://github.com/sponsors/Evgenii-Zinner/)
* [Thanks.dev](https://thanks.dev/u/gh/evgenii-zinner)
* [Buy Me a Coffee](https://buymeacoffee.com/evgeniizinner)

## License

MIT License. See [LICENSE](LICENSE) for details.
