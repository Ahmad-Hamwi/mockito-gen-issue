# mockito_gen_issue

A minimal Flutter project to reproduce the issue [#608](https://github.com/dart-lang/mockito/issues/608).

### Mockito version used: 5.4.2

## The issue:

Mockito is not generating the stubbing getter method for the class `IAppLocalization` under
[infra.dart](lib%2Finfra.dart):

```dart
abstract class IAppLocalization {
  AppLocalizations get instance;
}
```

### to reproduce
The setup is in [mocks.dart](test%2Fmocks%2Fmocks.dart)

```dart
@GenerateNiceMocks([MockSpec<IAppLocalization>()])
class _Mocks {}
```

The generated mock [mocks.mocks.dart](test%2Fmocks%2Fmocks.mocks.dart):

```dart
class MockIAppLocalization extends _i1.Mock implements _i2.IAppLocalization {}
```

The test that produces the issue is called [app_localizations_mockable.dart](test%2Fapp_localizations_mockable.dart):

```dart
class FakeAppLocalizations extends Fake implements AppLocalizations {
  @override
  String get helloWorld => "";
}

void main() {
  late IAppLocalization mockAppLocalization;

  setUp(() {
    mockAppLocalization = MockIAppLocalization();
  });

  test('IAppLocalization is mockable', () {
    when(mockAppLocalization.instance).thenReturn(FakeAppLocalizations());

    expect(mockAppLocalization.instance.helloWorld, "");
  });
}
```

### output:
```
test/mocks/mocks.mocks.dart 23:7            MockIAppLocalization.instance
test/app_localizations_mockable.dart 21:30  main.<fn>

type 'Null' is not a subtype of type 'AppLocalizations'
```