// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invitations_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Invitations)
const invitationsProvider = InvitationsProvider._();

final class InvitationsProvider
    extends $AsyncNotifierProvider<Invitations, InvitationsState> {
  const InvitationsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'invitationsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$invitationsHash();

  @$internal
  @override
  Invitations create() => Invitations();
}

String _$invitationsHash() => r'133ecccec84fa864adaa98893b662cf4f4554f0b';

abstract class _$Invitations extends $AsyncNotifier<InvitationsState> {
  FutureOr<InvitationsState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<InvitationsState>, InvitationsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<InvitationsState>, InvitationsState>,
              AsyncValue<InvitationsState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
