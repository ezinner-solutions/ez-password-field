import 'package:ez_password_field/ez_password_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EzPasswordField', () {
    testWidgets('toggles visibility when toggle button is pressed',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: EzPasswordField(),
          ),
        ),
      );

      // Initially obscured
      TextField textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.obscureText, isTrue);
      expect(find.byIcon(Icons.visibility), findsOneWidget);

      // Tap visibility icon
      await tester.tap(find.byIcon(Icons.visibility));
      await tester.pump();

      // Now visible
      textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.obscureText, isFalse);
      expect(find.byIcon(Icons.visibility_off), findsOneWidget);

      // Tap again to obscure
      await tester.tap(find.byIcon(Icons.visibility_off));
      await tester.pump();

      textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.obscureText, isTrue);
    });

    testWidgets('respects initiallyObscure: false',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: EzPasswordField(
              initiallyObscure: false,
            ),
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.obscureText, isFalse);
      expect(find.byIcon(Icons.visibility_off), findsOneWidget);
    });

    testWidgets('hides visibility toggle when showVisibilityToggle is false',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: EzPasswordField(
              showVisibilityToggle: false,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.visibility), findsNothing);
      expect(find.byIcon(Icons.visibility_off), findsNothing);
    });

    testWidgets('renders custom visibility and visibilityOff icons',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: EzPasswordField(
              visibilityIcon: Icon(Icons.lock_open, key: Key('custom_open')),
              visibilityOffIcon: Icon(Icons.lock, key: Key('custom_closed')),
            ),
          ),
        ),
      );

      expect(find.byKey(const Key('custom_open')), findsOneWidget);

      await tester.tap(find.byKey(const Key('custom_open')));
      await tester.pump();

      expect(find.byKey(const Key('custom_closed')), findsOneWidget);
    });

    testWidgets('calls onVisibilityChanged callback',
        (WidgetTester tester) async {
      bool? lastState;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EzPasswordField(
              onVisibilityChanged: (val) => lastState = val,
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.visibility));
      await tester.pump();

      expect(lastState, isFalse); // Now visible (obscureText = false)

      await tester.tap(find.byIcon(Icons.visibility_off));
      await tester.pump();

      expect(lastState, isTrue); // Obscured again
    });

    testWidgets(
        'disables visibility toggle button when field is disabled or readOnly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                EzPasswordField(
                  key: Key('disabled_field'),
                  enabled: false,
                ),
                EzPasswordField(
                  key: Key('readonly_field'),
                  readOnly: true,
                ),
              ],
            ),
          ),
        ),
      );

      final iconButtons =
          tester.widgetList<IconButton>(find.byType(IconButton)).toList();
      expect(iconButtons[0].onPressed, isNull);
      expect(iconButtons[1].onPressed, isNull);
    });

    testWidgets('validates required field and custom requiredMessage',
        (WidgetTester tester) async {
      final formKey = GlobalKey<FormState>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey,
              child: Column(
                children: const [
                  EzPasswordField(
                    key: Key('field1'),
                    labelText: 'Secret',
                    required: true,
                  ),
                  EzPasswordField(
                    key: Key('field2'),
                    required: true,
                    requiredMessage: 'Please provide a password',
                  ),
                  EzPasswordField(
                    key: Key('field3'),
                    required: false,
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      formKey.currentState!.validate();
      await tester.pump();

      expect(find.text('Secret is required'), findsOneWidget);
      expect(find.text('Please provide a password'), findsOneWidget);

      // field3 is not required, so no error for it
      expect(find.text('Password is required'), findsNothing);
    });

    testWidgets('validates built-in password rules',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Form(
              autovalidateMode: AutovalidateMode.always,
              child: EzPasswordField(
                minLength: 6,
                requireUppercase: true,
                requireLowercase: true,
                requireDigits: true,
                requireSpecialChars: true,
              ),
            ),
          ),
        ),
      );

      final finder = find.byType(EzPasswordField);

      // Short input without uppercase, digits, or special characters
      await tester.enterText(finder, 'abc');
      await tester.pump();

      expect(find.textContaining('at least 6 characters'), findsOneWidget);
      expect(find.textContaining('an uppercase letter'), findsOneWidget);
      expect(find.textContaining('a digit'), findsOneWidget);
      expect(find.textContaining('a special character'), findsOneWidget);

      // Meets length, lowercase, and uppercase
      await tester.enterText(finder, 'Abcdef');
      await tester.pump();

      expect(find.textContaining('at least 6 characters'), findsNothing);
      expect(find.textContaining('an uppercase letter'), findsNothing);
      expect(find.textContaining('a digit'), findsOneWidget);
      expect(find.textContaining('a special character'), findsOneWidget);

      // Meets all criteria
      await tester.enterText(finder, 'Abcde1!');
      await tester.pump();

      expect(find.textContaining('Issues:'), findsNothing);
    });

    testWidgets('enforces character prohibitions', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Form(
              autovalidateMode: AutovalidateMode.always,
              child: EzPasswordField(
                prohibitSpaces: true,
                prohibitDashes: true,
                prohibitLetters: true,
                prohibitDigits: true,
                prohibitSpecialChars: true,
                minLength: 1,
                requireUppercase: false,
                requireLowercase: false,
                requireDigits: false,
                requireSpecialChars: false,
              ),
            ),
          ),
        ),
      );

      final finder = find.byType(EzPasswordField);

      await tester.enterText(finder, ' ');
      await tester.pump();
      expect(find.textContaining('no spaces'), findsOneWidget);

      await tester.enterText(finder, '-');
      await tester.pump();
      expect(find.textContaining('no dashes'), findsOneWidget);

      await tester.enterText(finder, 'a');
      await tester.pump();
      expect(find.textContaining('no letters'), findsOneWidget);

      await tester.enterText(finder, '1');
      await tester.pump();
      expect(find.textContaining('no digits'), findsOneWidget);

      await tester.enterText(finder, '!');
      await tester.pump();
      expect(find.textContaining('no special characters'), findsOneWidget);
    });

    testWidgets('applies custom validator after built-in validation passes',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              autovalidateMode: AutovalidateMode.always,
              child: EzPasswordField(
                minLength: 4,
                requireUppercase: false,
                requireLowercase: false,
                requireDigits: false,
                requireSpecialChars: false,
                validator: (value) {
                  if (value == 'admin123') {
                    return 'Password is too common';
                  }
                  return null;
                },
              ),
            ),
          ),
        ),
      );

      final finder = find.byType(EzPasswordField);

      await tester.enterText(finder, 'admin123');
      await tester.pump();
      expect(find.text('Password is too common'), findsOneWidget);

      await tester.enterText(finder, 'secret123');
      await tester.pump();
      expect(find.text('Password is too common'), findsNothing);
    });

    testWidgets('supports initialValue and controller',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: EzPasswordField(
              initialValue: 'InitialPass123!',
            ),
          ),
        ),
      );

      expect(find.text('InitialPass123!'), findsOneWidget);

      final controller = TextEditingController(text: 'ControllerPass123!');
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EzPasswordField(
              controller: controller,
            ),
          ),
        ),
      );

      expect(find.text('ControllerPass123!'), findsOneWidget);
    });

    testWidgets('supports onSaved, onFieldSubmitted, and focusNode',
        (WidgetTester tester) async {
      final formKey = GlobalKey<FormState>();
      final focusNode = FocusNode();
      String? savedVal;
      String? submittedVal;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey,
              child: EzPasswordField(
                focusNode: focusNode,
                onSaved: (val) => savedVal = val,
                onFieldSubmitted: (val) => submittedVal = val,
              ),
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(EzPasswordField), 'MyPass123!');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      expect(submittedVal, 'MyPass123!');

      formKey.currentState!.save();
      expect(savedVal, 'MyPass123!');

      focusNode.dispose();
    });

    testWidgets('passes decoration and autofillHints down to TextFormField',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: EzPasswordField(
              labelText: 'Custom Label',
              hintText: 'Enter secret',
            ),
          ),
        ),
      );

      expect(find.text('Custom Label'), findsOneWidget);
      expect(find.text('Enter secret'), findsOneWidget);
      expect(find.byIcon(Icons.lock_outline), findsOneWidget);

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.autofillHints, const [AutofillHints.password]);
    });
  });
}
