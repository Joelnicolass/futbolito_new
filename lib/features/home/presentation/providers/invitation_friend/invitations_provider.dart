import 'package:futbolitonew/core/di/register_dependencies.dart';
import 'package:futbolitonew/features/auth/presentation/providers/auth_provider.dart';
import 'package:futbolitonew/features/home/domain/usecases/invitation_friend/get_all_firend_requests_usecase.dart';
import 'package:futbolitonew/features/home/presentation/providers/invitation_friend/invitations_state.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'invitations_provider.g.dart';

@riverpod
class Invitations extends _$Invitations {
  @override
  Future<InvitationsState> build() async {
    final auth = ref.read(authProvider);
    final usecase = getIt<GetAllFirendRequestsUsecase>();

    final requests = await usecase(
      email: auth.value!.email,
      userId: auth.value!.id,
    );

    if (requests.isEmpty)
      return InvitationsState();
    else
      return InvitationsState(pendingRequests: requests);
  }
}
