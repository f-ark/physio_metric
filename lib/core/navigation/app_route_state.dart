import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_route_state.freezed.dart';

@freezed
sealed class AppRouteState with _$AppRouteState {
  const factory AppRouteState.home() = HomeRoute;
  const factory AppRouteState.login() = LoginRoute;
  const factory AppRouteState.account() = AccountRoute;
  const factory AppRouteState.posture() = PostureRoute;
}
