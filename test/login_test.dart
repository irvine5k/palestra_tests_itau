import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../lib/login.dart';
import '../lib/main.dart';

class MockRepository1 implements Repository {
  @override
  Future<Response> login() async {
    return Response.success;
  }
}

class MockRepository2 implements Repository {
  @override
  Future<Response> login() async {
    return Response.failure;
  }
}

void main() {
  test('Authentication True', () async {
    final login = Login(MockRepository1());
    final success = await login.authenticate();
    await expectLater(success, true);
  });
  test('Authentication False', () async {
    final login = Login(MockRepository2());
    final success = await login.authenticate();
    await expectLater(success, false);
  });

  testWidgets('When success should navigate to Home', (tester) async {
    final login = Login(MockRepository1());

    await _createWidget(tester, login);

    await tester.tap(find.byType(FloatingActionButton));

    await tester.pump();

    expect(find.byType(LoginPage), findsOneWidget);
  });
}

Future<void> _createWidget(WidgetTester tester, Login login) async {
  await tester.pumpWidget(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(
        login: login,
      ),
    ),
  );
}
