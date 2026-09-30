import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A highly customizable, pre-configured [TextFormField] designed specifically
/// for password input with built-in visibility toggle, robust validation rules,
/// and Material 3 styling.
///
/// Features:
/// * **Configurable Requirements:** Enforce minimum length, uppercase, lowercase,
///   digits, and special characters.
/// * **Character Prohibitions:** Prohibit spaces, dashes, letters, digits, or
///   special characters (useful for PIN codes, strictly alphanumeric credentials, etc.).
/// * **Built-in Visibility Toggle:** Toggles obscured text state with customizable icons.
/// * **Drop-in Parity:** Supports [validator], [initialValue], [focusNode],
///   [autovalidateMode], [onSaved], [inputFormatters], and all standard
///   [TextFormField] properties.
/// * **Mobile Autofill:** Pre-configured with [AutofillHints.password] for instant
///   browser and OS credential manager integration.
///
/// ## Examples
///
/// ### Basic Usage
///
/// ```dart
/// EzPasswordField(
///   onChanged: (password) => print('Password changed'),
/// )
/// ```
///
/// ### PIN-Code Style Field (Numeric Only)
///
/// ```dart
/// EzPasswordField(
///   labelText: 'PIN',
///   minLength: 4,
///   requireUppercase: false,
///   requireLowercase: false,
///   requireSpecialChars: false,
///   prohibitLetters: true,
///   prohibitSpecialChars: true,
///   keyboardType: TextInputType.number,
/// )
/// ```
class EzPasswordField extends StatefulWidget {
  /// The controller for the text field.
  final TextEditingController? controller;

  /// Initial text value to populate the field with if no [controller] is provided.
  final String? initialValue;

  /// Defines the keyboard focus for this widget.
  final FocusNode? focusNode;

  /// The label text for the input decoration. Defaults to `'Password'`.
  final String? labelText;

  /// The hint text for the input decoration.
  final String? hintText;

  /// Whether the field is required. If `true`, validation ensures the field is not empty.
  ///
  /// Defaults to `true`.
  final bool required;

  /// Custom error message to display when the field is required but left empty.
  ///
  /// If `null`, defaults to `'${labelText ?? "Password"} is required'`.
  final String? requiredMessage;

  /// The minimum length required for the password. Defaults to `8`.
  final int minLength;

  /// Whether to require at least one uppercase letter. Defaults to `true`.
  final bool requireUppercase;

  /// Whether to require at least one lowercase letter. Defaults to `true`.
  final bool requireLowercase;

  /// Whether to require at least one digit. Defaults to `true`.
  final bool requireDigits;

  /// Whether to require at least one special character. Defaults to `true`.
  final bool requireSpecialChars;

  /// Whether to prohibit spaces. Defaults to `true`.
  final bool prohibitSpaces;

  /// Whether to prohibit dashes. Defaults to `false`.
  final bool prohibitDashes;

  /// Whether to prohibit letters. Defaults to `false`.
  final bool prohibitLetters;

  /// Whether to prohibit digits. Defaults to `false`.
  final bool prohibitDigits;

  /// Whether to prohibit special characters. Defaults to `false`.
  final bool prohibitSpecialChars;

  /// Prefix text prepended before the list of missing requirements.
  ///
  /// Defaults to `'Issues: '`.
  final String issuesPrefix;

  /// Whether to show the password visibility toggle icon button.
  ///
  /// Defaults to `true`.
  final bool showVisibilityToggle;

  /// Whether the text field is initially obscured.
  ///
  /// Defaults to `true`.
  final bool initiallyObscure;

  /// Custom widget for the visibility toggle icon when password is obscured.
  ///
  /// If `null`, defaults to `Icon(Icons.visibility)`.
  final Widget? visibilityIcon;

  /// Custom widget for the visibility toggle icon when password is visible.
  ///
  /// If `null`, defaults to `Icon(Icons.visibility_off)`.
  final Widget? visibilityOffIcon;

  /// Callback invoked when the visibility toggle is pressed.
  final ValueChanged<bool>? onVisibilityChanged;

  /// Additional custom validator callback executed after all built-in validation checks pass.
  final FormFieldValidator<String>? validator;

  /// Alias for [validator].
  final FormFieldValidator<String>? customValidator;

  /// Callback when the text value changes.
  final ValueChanged<String>? onChanged;

  /// Invoked when the enclosing form is saved via [FormState.save].
  final FormFieldSetter<String>? onSaved;

  /// Invoked when the user submits editing on the keyboard action button.
  final ValueChanged<String>? onFieldSubmitted;

  /// Invoked when editing is completed.
  final VoidCallback? onEditingComplete;

  /// Invoked when the field is tapped.
  final GestureTapCallback? onTap;

  /// The decoration to use for the text field.
  ///
  /// If provided, properties specified here take precedence over [labelText] and [hintText].
  final InputDecoration? decoration;

  /// Used to enable/disable auto-validation and determine its trigger mode.
  final AutovalidateMode? autovalidateMode;

  /// If `false`, the field will be disabled and ignore user interaction.
  final bool? enabled;

  /// Whether the field can be edited. Defaults to `false`.
  final bool readOnly;

  /// Whether this field should focus automatically. Defaults to `false`.
  final bool autofocus;

  /// The type of action button to use for the keyboard. Defaults to [TextInputAction.done].
  final TextInputAction? textInputAction;

  /// The type of keyboard to use. Defaults to [TextInputType.visiblePassword].
  final TextInputType? keyboardType;

  /// The style to use for the text being edited.
  final TextStyle? style;

  /// How the text should be aligned horizontally. Defaults to [TextAlign.start].
  final TextAlign textAlign;

  /// The color of the cursor.
  final Color? cursorColor;

  /// Optional input formatters to apply as the user types.
  final List<TextInputFormatter>? inputFormatters;

  /// Autofill hints to communicate with the OS autofill service.
  ///
  /// Defaults to `const [AutofillHints.password]`.
  final Iterable<String>? autofillHints;

  /// Configures padding for the viewport when scrolling into view. Defaults to `EdgeInsets.all(20.0)`.
  final EdgeInsets scrollPadding;

  /// The maximum number of characters to allow in the field.
  final int? maxLength;

  /// Creates an [EzPasswordField].
  const EzPasswordField({
    super.key,
    this.controller,
    this.initialValue,
    this.focusNode,
    this.labelText = 'Password',
    this.hintText,
    this.required = true,
    this.requiredMessage,
    this.minLength = 8,
    this.requireUppercase = true,
    this.requireLowercase = true,
    this.requireDigits = true,
    this.requireSpecialChars = true,
    this.prohibitSpaces = true,
    this.prohibitDashes = false,
    this.prohibitLetters = false,
    this.prohibitDigits = false,
    this.prohibitSpecialChars = false,
    this.issuesPrefix = 'Issues: ',
    this.showVisibilityToggle = true,
    this.initiallyObscure = true,
    this.visibilityIcon,
    this.visibilityOffIcon,
    this.onVisibilityChanged,
    this.validator,
    this.customValidator,
    this.onChanged,
    this.onSaved,
    this.onFieldSubmitted,
    this.onEditingComplete,
    this.onTap,
    this.decoration,
    this.autovalidateMode,
    this.enabled,
    this.readOnly = false,
    this.autofocus = false,
    this.textInputAction = TextInputAction.done,
    this.keyboardType = TextInputType.visiblePassword,
    this.style,
    this.textAlign = TextAlign.start,
    this.cursorColor,
    this.inputFormatters,
    this.autofillHints = const [AutofillHints.password],
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.maxLength,
  });

  @override
  State<EzPasswordField> createState() => _EzPasswordFieldState();
}

class _EzPasswordFieldState extends State<EzPasswordField> {
  late bool _obscureText;
  TextEditingController? _internalController;

  TextEditingController get _effectiveController =>
      widget.controller ??
      (_internalController ??=
          TextEditingController(text: widget.initialValue));

  @override
  void initState() {
    super.initState();
    _obscureText = widget.initiallyObscure;
  }

  @override
  void didUpdateWidget(EzPasswordField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      if (oldWidget.controller == null) {
        _internalController?.dispose();
        _internalController = null;
      }
    }
  }

  @override
  void dispose() {
    _internalController?.dispose();
    super.dispose();
  }

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
    widget.onVisibilityChanged?.call(_obscureText);
  }

  String? _validate(String? value) {
    if (value == null || value.isEmpty) {
      if (widget.required) {
        return widget.requiredMessage ??
            '${widget.labelText ?? "Password"} is required';
      }
      return null;
    }

    final List<String> missingRequirements = [];

    // Check prohibited characters
    if (widget.prohibitSpaces && value.contains(' ')) {
      missingRequirements.add('no spaces');
    }

    if (widget.prohibitDashes && value.contains('-')) {
      missingRequirements.add('no dashes');
    }

    if (widget.prohibitLetters && value.contains(RegExp(r'[a-zA-Z]'))) {
      missingRequirements.add('no letters');
    }

    if (widget.prohibitDigits && value.contains(RegExp(r'[0-9]'))) {
      missingRequirements.add('no digits');
    }

    if (widget.prohibitSpecialChars &&
        value.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'))) {
      missingRequirements.add('no special characters');
    }

    if (value.length < widget.minLength) {
      missingRequirements.add('at least ${widget.minLength} characters');
    }

    if (widget.requireUppercase && !value.contains(RegExp(r'[A-Z]'))) {
      missingRequirements.add('an uppercase letter');
    }

    if (widget.requireLowercase && !value.contains(RegExp(r'[a-z]'))) {
      missingRequirements.add('a lowercase letter');
    }

    if (widget.requireDigits && !value.contains(RegExp(r'[0-9]'))) {
      missingRequirements.add('a digit');
    }

    if (widget.requireSpecialChars &&
        !value.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'))) {
      missingRequirements.add('a special character');
    }

    if (missingRequirements.isNotEmpty) {
      return '${widget.issuesPrefix}${missingRequirements.join(", ")}';
    }

    final extraValidator = widget.validator ?? widget.customValidator;
    if (extraValidator != null) {
      return extraValidator(value);
    }

    return null;
  }

  Widget? _buildSuffixIcon(InputDecoration userDecoration) {
    if (!widget.showVisibilityToggle) {
      return userDecoration.suffixIcon;
    }

    return IconButton(
      icon: _obscureText
          ? (widget.visibilityIcon ?? const Icon(Icons.visibility))
          : (widget.visibilityOffIcon ?? const Icon(Icons.visibility_off)),
      tooltip: _obscureText ? 'Show password' : 'Hide password',
      onPressed: widget.enabled != false && !widget.readOnly
          ? _toggleVisibility
          : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    final userDecoration = widget.decoration ?? const InputDecoration();

    final InputDecoration effectiveDecoration = userDecoration.copyWith(
      labelText: userDecoration.labelText ?? widget.labelText,
      hintText: userDecoration.hintText ?? widget.hintText,
      prefixIcon: userDecoration.prefixIcon ?? const Icon(Icons.lock_outline),
      suffixIcon: _buildSuffixIcon(userDecoration),
      border: userDecoration.border ??
          const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
      contentPadding: userDecoration.contentPadding ??
          const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 12.0,
          ),
    );

    return TextFormField(
      controller: _effectiveController,
      focusNode: widget.focusNode,
      obscureText: _obscureText,
      validator: _validate,
      onChanged: widget.onChanged,
      onSaved: widget.onSaved,
      onFieldSubmitted: widget.onFieldSubmitted,
      onEditingComplete: widget.onEditingComplete,
      onTap: widget.onTap,
      decoration: effectiveDecoration,
      autovalidateMode: widget.autovalidateMode,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      autofocus: widget.autofocus,
      textInputAction: widget.textInputAction,
      keyboardType: widget.keyboardType,
      style: widget.style,
      textAlign: widget.textAlign,
      cursorColor: widget.cursorColor,
      inputFormatters: widget.inputFormatters,
      autofillHints: widget.autofillHints,
      scrollPadding: widget.scrollPadding,
      maxLength: widget.maxLength,
    );
  }
}
