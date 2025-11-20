// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TestProvider)
const testProviderProvider = TestProviderProvider._();

final class TestProviderProvider
    extends $AsyncNotifierProvider<TestProvider, TestState> {
  const TestProviderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'testProviderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$testProviderHash();

  @$internal
  @override
  TestProvider create() => TestProvider();
}

String _$testProviderHash() => r'da4676ddce23530c28791eb782e15d0b695613b0';

abstract class _$TestProvider extends $AsyncNotifier<TestState> {
  FutureOr<TestState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<TestState>, TestState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<TestState>, TestState>,
              AsyncValue<TestState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
