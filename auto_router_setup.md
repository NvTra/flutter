# 🚀 Hướng dẫn cài đặt AutoRoute cho Flutter

## 📋 Mục lục

1. [Cài đặt Dependencies](#1-cài-đặt-dependencies)
2. [Cấu hình AppRouter](#2-cấu-hình-approuter)
3. [Tạo Routable Pages](#3-tạo-routable-pages)
4. [Chạy Code Generation](#4-chạy-code-generation)
5. [Cấu hình MaterialApp](#5-cấu-hình-materialapp)
6. [Navigation](#6-navigation)
7. [Troubleshooting](#7-troubleshooting)

---

## 1. 📦 Cài đặt Dependencies

### Thêm vào `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  auto_route: ^10.1.0+1

dev_dependencies:
  flutter_test:
    sdk: flutter
  build_runner: ^2.4.9
  auto_route_generator: ^10.2.3
```

### Chạy lệnh cài đặt:

```bash
flutter pub get
```

---

## 2. 🛣️ Cấu hình AppRouter

### Tạo file `lib/app_router.dart`:

```dart
import 'package:auto_route/auto_route.dart';
import 'home_page.dart';
import 'counter_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
    // Trang chủ - route mặc định
    AutoRoute(
      page: HomeRouteWrapper.page,
      path: '/',
      initial: true,
    ),
    // Trang counter
    AutoRoute(
      page: CounterRouteWrapper.page,
      path: '/counter',
    ),
  ];
}
```

**⚠️ Lưu ý quan trọng:**

- Dòng `part 'app_router.gr.dart';` phải có trước khi chạy code generation
- File `.gr.dart` sẽ được tự động tạo

---

## 3. 📄 Tạo Routable Pages

### Cấu trúc cho mỗi page:

#### `lib/home_page.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'app_router.dart';

@RoutePage()
class HomePageWrapper extends StatelessWidget {
  const HomePageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomePage();
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Trang chủ")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            AutoRouter.of(context).push(const CounterRouteWrapper());
          },
          child: Text("Đi đến Counter"),
        ),
      ),
    );
  }
}
```

#### `lib/counter_page.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class CounterPageWrapper extends StatelessWidget {
  const CounterPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return const CounterPage();
  }
}

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Counter")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Count: $_counter'),
            ElevatedButton(
              onPressed: () => setState(() => _counter++),
              child: Text('Increment'),
            ),
            ElevatedButton(
              onPressed: () => AutoRouter.of(context).maybePop(),
              child: Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}
```

**📝 Pattern quan trọng:**

- **Wrapper Class**: Có `@RoutePage()` annotation - đây là class AutoRoute sẽ generate
- **Actual Page**: Widget thực tế chứa UI logic

---

## 4. ⚙️ Chạy Code Generation

### Lệnh build một lần:

```bash
dart run build_runner build
```

### Lệnh build và xóa conflicts:

```bash
dart run build_runner build --delete-conflicting-outputs
```

### Lệnh watch (tự động rebuild khi có thay đổi):

```bash
dart run build_runner watch
```

**✅ Kết quả:** File `app_router.gr.dart` sẽ được tạo với nội dung như:

```dart
/// generated route for [HomePageWrapper]
class HomeRouteWrapper extends PageRouteInfo<void> {
  // ... generated code
}

/// generated route for [CounterPageWrapper]
class CounterRouteWrapper extends PageRouteInfo<void> {
  // ... generated code
}
```

---

## 5. 📱 Cấu hình MaterialApp

### Update `lib/main.dart`:

```dart
import 'package:flutter/material.dart';
import 'app_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Tạo instance của AppRouter
  final _appRouter = AppRouter();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter AutoRoute Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      routerConfig: _appRouter.config(),
    );
  }
}
```

**🔑 Key points:**

- Sử dụng `MaterialApp.router` thay vì `MaterialApp`
- Pass `_appRouter.config()` vào `routerConfig`

---

## 6. 🧭 Navigation

### Basic Navigation:

```dart
// Push to new route
AutoRouter.of(context).push(const CounterRouteWrapper());

// Pop current route
AutoRouter.of(context).pop();

// Pop if possible (safe pop)
AutoRouter.of(context).maybePop();

// Replace current route
AutoRouter.of(context).replace(const HomeRouteWrapper());

// Push and remove all previous routes
AutoRouter.of(context).pushAndClearStack(const HomeRouteWrapper());
```

### Navigation với parameters:

```dart
// Define route with parameters
@RoutePage()
class ProfilePageWrapper extends StatelessWidget {
  final String userId;
  const ProfilePageWrapper({required this.userId, super.key});

  @override
  Widget build(BuildContext context) {
    return ProfilePage(userId: userId);
  }
}

// Navigate with parameters
AutoRouter.of(context).push(ProfileRouteWrapper(userId: '123'));
```

---

## 7. 🛠️ Troubleshooting

### ❌ Lỗi thường gặp:

#### 1. "The getter 'page' isn't defined"

**Nguyên nhân:** Chưa chạy code generation
**Giải pháp:**

```bash
dart run build_runner build --delete-conflicting-outputs
```

#### 2. "A value of type 'XxxWrapper' can't be returned from function"

**Nguyên nhân:** Naming conflict giữa PageRouteInfo và Widget
**Giải pháp:** Đảm bảo class pattern đúng:

- `@RoutePage()` class extends `StatelessWidget`
- Generated class sẽ có tên khác (VD: `HomePageWrapper` → `HomeRouteWrapper`)

#### 3. Import errors

**Giải pháp:** Đảm bảo import đúng:

```dart
import 'package:auto_route/auto_route.dart';
import 'app_router.dart'; // Để sử dụng generated routes
```

### ✅ Best Practices:

1. **Naming Convention:**

   - Page wrapper: `XxxPageWrapper`
   - Generated route: `XxxRouteWrapper` (tự động)

2. **File Organization:**

   ```
   lib/
   ├── main.dart
   ├── app_router.dart
   ├── app_router.gr.dart (generated)
   ├── pages/
   │   ├── home_page.dart
   │   └── counter_page.dart
   ```

3. **Always run build_runner after:**
   - Thêm page mới
   - Thay đổi route configuration
   - Thay đổi page parameters

---

## 🎯 Kết quả cuối cùng

Sau khi hoàn thành tất cả bước trên, bạn sẽ có:

✅ Type-safe navigation  
✅ Code generation tự động  
✅ Deep linking support  
✅ Route guards (nâng cao)  
✅ Nested navigation (nâng cao)

**🚀 Ứng dụng sẵn sàng scale với routing chuyên nghiệp!**

---

## 📚 Tài liệu tham khảo

- [AutoRoute Official Documentation](https://pub.dev/packages/auto_route)
- [Flutter Navigation & Routing](https://docs.flutter.dev/development/ui/navigation)
- [Build Runner Documentation](https://pub.dev/packages/build_runner)
