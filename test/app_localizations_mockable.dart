import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito_gen_issue/infra.dart';

import 'mocks/mocks.mocks.dart';

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
