# EZ Password Field

A **secure, developer-friendly** Flutter password field with built-in visibility toggle, robust validation, and full `TextFormField` parity.

## 🛑 The Problem

Implementing password fields repeatedly involves:
1.  **Boilerplate:** Manually managing `obscureText` state, focus nodes, and toggle icons.
2.  **Complex Validation:** Writing tedious regular expressions to check for uppercase, lowercase, digits, special characters, and minimum length.
3.  **Inconsistent UX:** Poor error reporting (showing one issue at a time instead of all unmet requirements).
4.  **Missing Defaults:** Forgetting autofill hints (`AutofillHints.password`), prefix lock icons, or clear empty-field checks.

## ✅ The EZ Solution

`EzPasswordField` encapsulates best practices for password input into a single, drop-in widget:
-   **Built-in Visibility Toggle:** Ready-to-use toggle button with customizable icons and state callbacks.
-   **Smart Validation:** Accumulates all missing requirements into a single, clear error message (e.g., *"Issues: no spaces, at least 8 characters, a digit"*).
-   **Robustness Flags:** Easily prohibit specific characters like spaces or dashes (great for PINs or strictly alphanumeric passwords).
-   **Drop-in Parity:** Supports `initialValue`, `controller`, `focusNode`, `autovalidateMode`, `onSaved`, `inputFormatters`, `autofillHints`, and all standard form field properties.
-   **Sensible Defaults:** Modern rounded borders, lock prefix icon, and OS password autofill support out of the box.

## ✨ Features

*   **Zero-Config Validation:** Default rules enforce strong passwords (min length 8, uppercase, lowercase, digits, special characters).
*   **Configurable Requirements:** Enable or disable specific rules or adjust minimum length.
*   **Character Prohibitions:** `prohibitSpaces`, `prohibitDashes`, `prohibitLetters`, `prohibitDigits`, `prohibitSpecialChars`.
*   **Visibility Customization:** Custom icons (`visibilityIcon`, `visibilityOffIcon`), `initiallyObscure`, or disable the toggle via `showVisibilityToggle: false`.
*   **Complete Form Integration:** Works seamlessly inside Flutter's `Form` with `onSaved`, `validator`, and `autovalidateMode`.

## 📦 Installation

```shell
flutter pub add ez_password_field
```

## 🚀 Usage

### Standard Form Field

Wrap it in a `Form` to enable validation:

```dart
Form(
  key: _formKey,
  child: Column(
    children: [
      EzPasswordField(
        controller: _passwordController,
        labelText: 'Password',
        onSaved: (value) => _password = value,
      ),
      ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            // Handle valid submission
          }
        },
        child: const Text('Submit'),
      ),
    ],
  ),
)
```

### PIN Mode (Numeric Only)

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

### Custom Validation Logic

Add additional checks on top of the built-in validation rules:

```dart
EzPasswordField(
  validator: (value) {
    if (value != null && value.toLowerCase().contains('password')) {
      return 'Password cannot contain "password"';
    }
    return null;
  },
)
```

### Custom Styling & Icons

Style it just like any standard `TextFormField`:

```dart
EzPasswordField(
  visibilityIcon: const Icon(Icons.lock_open),
  visibilityOffIcon: const Icon(Icons.lock),
  decoration: InputDecoration(
    labelText: 'Enter Secret Code',
    border: const OutlineInputBorder(),
    filled: true,
    fillColor: Colors.grey.shade100,
  ),
)
```

## 🤝 Contributing

Contributions are welcome! Please feel free to open an issue or submit a pull request on [GitHub](https://github.com/Evgenii-Zinner/ez-password-field).

## 📜 License

MIT License - see the [LICENSE](LICENSE) file for details.
