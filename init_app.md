### create app
```
flutter create <app_name>
```

### remove folder

```
rmdir /s /q linux
rmdir /s /q macos
rmdir /s /q web
rmdir /s /q windows
```
### add hook
```
flutter pub add flutter_hooks
flutter pub add hooks_riverpod
```

### add auto_router
```
flutter pub add auto_route dev:auto_route_generator dev:build_runner
```
cấu hình app_router v10
```
part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  // TODO: implement routes
  List<AutoRoute> get routes => [
    AutoRoute(page: HomeRoute.page, initial: true),
    ....
  ];
}
```
- thêm `@RoutePage()` vào các page
- auto generete: `flutter pub run build_runner build --delete-conflicting-outputs`
- sử dụng `context.pushRoute(const HomeRoute())`
