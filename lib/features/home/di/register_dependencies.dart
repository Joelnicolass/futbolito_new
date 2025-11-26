import 'package:futbolitonew/features/home/data/datasources/remote/remote_datasource.dart';
import 'package:futbolitonew/features/home/data/respositories/invitation_friend/invitation_friend_repository_impl.dart';
import 'package:futbolitonew/features/home/domain/repositories/invitation_friend/invitation_friend_repository.dart';
import 'package:futbolitonew/features/home/domain/usecases/invitation_friend/get_all_firend_requests_usecase.dart';

import '../../../core/di/register_dependencies.dart';

void invitationsRegisterDependencies() {
  /// DataSources
  getIt.registerLazySingleton<InvitaitonFriendDatasource>(
    () => InvitationsRemoteDataSource(),
  );

  /// Repositories
  getIt.registerLazySingleton<InvitationFriendRepository>(
    () => InvitationFriendRepositoryImpl(getIt<InvitaitonFriendDatasource>()),
  );

  /// Use Cases
  getIt.registerLazySingleton<GetAllFirendRequestsUsecase>(
    () => GetAllFirendRequestsUsecase(getIt<InvitationFriendRepository>()),
  );
}
