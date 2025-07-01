# Hướng dẫn Cài đặt và Sử dụng Thư viện cho REST API Flutter

## 📑 Mục lục
1. [🚀 Khởi tạo Dự án](#1-khởi-tạo-dự-án)
2. [⚙️ Quản lý Môi trường](#2-quản-lý-môi-trường)
3. [📱 State Management](#3-state-management)
   - [Riverpod Setup](#31-riverpod-setup)
   - [Provider Pattern](#32-provider-pattern)
   - [Internationalization](#33-internationalization-l10n)
   - [Theme Configuration](#34-theme-configuration)
4. [🔄 Routing](#4-routing)
5. [🌐 Network và API](#5-network-và-api)
6. [🔐 Authentication](#6-authentication)
7. [📁 Cấu trúc Dự án](#7-cấu-trúc-dự-án)
8. [🧪 Testing và Debug](#8-testing-và-debug)

## 1. Khởi tạo Dự án

### 1.1. Tạo Project Mới
```bash
# Tạo dự án Flutter mới
flutter create --org com.example restapi

# Di chuyển vào thư mục dự án
cd restapi

# Xóa các platforms không cần thiết (nếu chỉ phát triển cho mobile)
rmdir /s /q linux macos web windows

# Kiểm tra các platforms còn lại
flutter devices
```

# Tạo thư mục theo chuẩn Clean_Architecture
```
mkdir lib\core\api lib\core\constants lib\core\error lib\core\network ^
lib\data\datasources\remote lib\data\models lib\data\repositories ^
lib\domain\entities lib\domain\repositories lib\domain\usecases ^
lib\presentation\screens\post lib\presentation\viewmodels lib\presentation\widgets ^
lib\routes
```


### 1.2. Cài đặt Dependencies Cơ bản
```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_dotenv: ^5.1.0
  hooks_riverpod: ^2.5.1
  dio: ^5.4.1
  retrofit: ^4.1.0
  json_annotation: ^4.8.1
  auto_route: ^7.8.4
  shared_preferences: ^2.2.2

dev_dependencies:
  flutter_test:
    sdk: flutter
  retrofit_generator: ^8.1.0
  build_runner: ^2.4.8
  json_serializable: ^6.7.1
  auto_route_generator: ^7.3.2
```

## 2. Quản lý Môi trường

### 2.1. Cấu hình Environment
1. Tạo các file môi trường:
```env
# .env
API_BASE_URL=https://api.production.com
API_TIMEOUT=30000
API_KEY=your_api_key

2. Cấu hình pubspec.yaml:
```yaml
flutter:
  assets:
    - .env
```

3. Tạo Environment Helper:
```flutter pub add flutter_dotenv ```
```dart
// lib/env.dart
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static String get apiUrl => 
      dotenv.env['API_BASE_URL'] ?? 'https://api.default.com';
  
  static int get apiTimeout => 
      int.parse(dotenv.env['API_TIMEOUT'] ?? '30000');
      
  static String get apiKey => 
      dotenv.env['API_KEY'] ?? '';
}
```

4. Cấu hình main:
```
await dotenv.load(fileName: '.env');
```
5. Sử dụng: Env.apiUrl


### 2.2. Bảo mật Environment
```gitignore
# .gitignore
.env*
!.env.example
```

## 3. State Management

### 3.1. Riverpod Setup
```yaml
dependencies:
  flutter_hooks: ^0.20.5
  hooks_riverpod: ^2.5.1
```

### 3.2. Provider Pattern
```dart
// Ví dụ Provider cơ bản
final counterProvider = StateNotifierProvider<CounterNotifier, int>((ref) {
  return CounterNotifier();
});

class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(0);
  
  void increment() => state++;
  void decrement() => state--;
}
```

### 3.3. Internationalization (l10n)

#### 3.3.1. Cài đặt Dependencies
```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter
  intl: ^0.18.1
```
```
flutter pub add intl
```
#### 3.3.2. Cấu hình pubspec.yaml
```yaml
# pubspec.yaml
flutter_localizations:
  sdk: flutter
  
flutter:
  generate: true # Kích hoạt generation của synthetic packages
```

#### 3.3.3. Tạo Thư mục và File Ngôn ngữ
```
lib/
└── l10n/
    ├── app_en.arb     # English
    ├── app_vi.arb     # Vietnamese
    └── l10n.dart      # Export file
```

```json
// lib/l10n/app_en.arb
{
  "@@locale": "en",
  "hello": "Hello",
  "welcome": "Welcome to our app"
}
```

```json
// lib/l10n/app_vi.arb
{
  "@@locale": "vi",
  "hello": "Xin chào",
  "welcome": "Chào mừng đến với ứng dụng của chúng tôi"
}
```

- chạy lệnh `flutter pub run build_runner build --delete-conflicting-outputs` để gen 

#### 3.3.4. Cấu hình l10n.yaml
```yaml
# l10n.yaml (tạo ở thư mục root)
arb-dir: lib/l10n
template-arb-file: app_en.arb
output-localization-file: app_localizations.dart
output-class: AppLocalizations
```

#### 3.3.5. Sử dụng với Riverpod và lưu trữ Locale `shared_preferences`
```dart
// lib/providers/locale_provider.dart
final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  return LocaleNotifier();
});

class LocaleNotifier extends StateNotifier<Locale> {
  static const String _localeKey = 'app_locale';

  LocaleNotifier() : super(const Locale('vi')) {
    _loadSavedLocale();
  }

  Future<void> _loadSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final langCode = prefs.getString(_localeKey);

    if (langCode != null && langCode.isNotEmpty) {
      state = Locale(langCode);
    }
  }

  Future<void> changeLocale(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_localeKey, languageCode);
    state = Locale(languageCode);
  }
}
```
#### 3.3.5. Cấu hình main
```
// lib/main.dart
class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);
    
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: locale,
      supportedLocales: AppLocalizations.supportedLocales,
	  ...
    );
  }
}
```

#### 3.3.6. Sử dụng Localizations
```dart
// Trong widget
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Lấy instance của AppLocalizations
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
      ),
      body: Column(
        children: [
          Text(l10n.hello('John')),
          Text(l10n.itemCount(5)),
          Text(l10n.lastUpdated(DateTime.now())),
        ],
      ),
    );
  }
}
```

#### 3.3.9. Language Change
```dart
ref.read(localeProvider.notifier).changeLocale('vi');
```

## 4. Routing
```
flutter pub add auto_route dev:auto_route_generator dev:build_runner
```

### 4.1. Auto Router Setup
```dart
// lib/config/router/app_router.dart
import 'package:auto_route/auto_route.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      initial: true,
      page: HomeRoute.page,
      path: '/',
    ),
    AutoRoute(
      page: LoginRoute.page,
      path: '/login',
    ),
    AutoRoute(
      page: ProfileRoute.page,
      path: '/profile',
      guards: [AuthGuard()],
    ),
  ];
}
```

### 4.2. Route Guards
```dart
class AuthGuard extends AutoRouteGuard {
  @override
  Future<bool> canNavigate(NavigationResolver resolver, StackRouter router) async {
    final isAuthenticated = await checkAuthentication();
    if (!isAuthenticated) {
      router.push(LoginRoute());
      return false;
    }
    return true;
  }
}
```

## 5. Network và API

### 5.1. Dio Configuration
```dart
// lib/app_dio.dart
class AppDio with DioMixin implements Dio {
  AppDio._() {
    options = BaseOptions(
      baseUrl: Env.apiUrl,
      connectTimeout: Duration(milliseconds: Env.apiTimeout),
      receiveTimeout: Duration(milliseconds: Env.apiTimeout),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final client = HttpClient();
        client.badCertificateCallback = 
            (X509Certificate cert, String host, int port) => true;
        return client;
      },
    );

    interceptors.addAll([
      AuthInterceptor(),
      LogInterceptor(requestBody: true, responseBody: true),
    ]);
  }

  static Dio getInstance() => AppDio._();
}
```

### 5.2. Retrofit Service
```dart
@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio) = _ApiService;

  @GET('/items')
  Future<List<Item>> getItems();

  @POST('/items')
  Future<Item> createItem(@Body() Item item);
}
```

## 6. Authentication

### 6.1. Token Storage
```dart
class TokenStorage {
  final SharedPreferences _prefs;
  
  TokenStorage(this._prefs);
  
  Future<String?> getAccessToken() => 
      _prefs.getString('access_token');
  
  Future<bool> setAccessToken(String token) => 
      _prefs.setString('access_token', token);
  
  Future<void> clearTokens() => 
      _prefs.clear();
}
```

### 6.2. Auth Interceptor
```dart
class AuthInterceptor extends Interceptor {
  final TokenStorage _tokenStorage;
  bool _isRefreshing = false;
  
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _tokenStorage.getAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
  
  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401 && !_isRefreshing) {
      _isRefreshing = true;
      try {
        final newToken = await refreshToken();
        _isRefreshing = false;
        
        if (newToken != null) {
          // Retry request với token mới
          final response = await _retry(err.requestOptions, newToken);
          handler.resolve(response);
          return;
        }
      } catch (e) {
        _isRefreshing = false;
        await _tokenStorage.clearTokens();
      }
    }
    handler.next(err);
  }
}
```

## 7. Cấu trúc Dự án

```
lib/
├── config/
│   ├── router/
│   │   ├── app_router.dart
│   │   └── guards/
│   └── env.dart
├── core/
│   ├── dio/
│   │   ├── app_dio.dart
│   │   └── interceptors/
│   └── storage/
│       └── token_storage.dart
├── features/
│   ├── auth/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   └── home/
├── shared/
│   ├── models/
│   ├── widgets/
│   └── utils/
└── main.dart
```

## 8. Testing và Debug

### 8.1. Unit Testing
```dart
void main() {
  group('ApiService Tests', () {
    late ApiService apiService;

    setUp(() {
      final dio = AppDio.getInstance();
      apiService = ApiService(dio);
    });

    test('getItems returns list of items', () async {
      final items = await apiService.getItems();
      expect(items, isA<List<Item>>());
    });
  });
}
```

### 8.2. Debug Tools
- Dio Logger Interceptor
- Riverpod DevTools
- Flutter DevTools

## Best Practices

### Code Generation
```bash
# Generate code cho các annotations
flutter pub run build_runner build --delete-conflicting-outputs

# Watch mode cho development
flutter pub run build_runner watch --delete-conflicting-outputs
```

### Error Handling
- ✅ Xử lý lỗi ở tầng service
- 📝 Hiển thị user-friendly messages
- 🔄 Implement retry mechanism
- 📊 Log errors cho analytics

### Security
- 🔒 Không commit sensitive data
- 🔑 Sử dụng environment variables
- 🔄 Implement proper token management
- 🛡️ Validate input data

### Performance
- 📦 Lazy loading components và data
- 💾 Implement caching strategy
- 🎯 Minimize rebuilds
- 🖼️ Optimize images và assets

### Testing
- 🧪 Unit tests cho business logic
- 🎨 Widget tests cho UI components
- 🔄 Integration tests cho user flows
- 🤖 Automation tests cho CI/CD

## ⚠️ Lưu ý Quan trọng

### Version Compatibility
- ✅ Kiểm tra phiên bản Flutter SDK
- 📦 Đảm bảo các dependencies tương thích
- 🔄 Update dependencies thường xuyên
- 📝 Ghi chú các breaking changes

### Code Generation
- 🔄 Chạy build_runner sau mỗi thay đổi
- ✅ Kiểm tra generated code
- 🧹 Clean build khi cần thiết
- 📝 Comment cho complex generations

### Security
- 🔒 Bảo vệ sensitive data
- 🔑 Implement proper authentication
- ⏰ Handle token expiration
- 🛡️ Implement security headers

### Debugging
- 📝 Sử dụng proper logging
- 🌐 Monitor network calls
- 📊 Track state changes
- 🐛 Implement error boundaries

## 3.4. Theme Configuration

### 3.4.1. Cấu trúc Theme
```dart
// lib/config/theme/app_colors.dart
import 'package:flutter/material.dart';

class AppColors {
  // Primary Swatch
  static const MaterialColor primary = MaterialColor(
    0xFF2196F3, // 500
    <int, Color>{
      50: Color(0xFFE3F2FD),
      100: Color(0xFFBBDEFB),
      200: Color(0xFF90CAF9),
      300: Color(0xFF64B5F6),
      400: Color(0xFF42A5F5),
      500: Color(0xFF2196F3),
      600: Color(0xFF1E88E5),
      700: Color(0xFF1976D2),
      800: Color(0xFF1565C0),
      900: Color(0xFF0D47A1),
    },
  );

  // Secondary Swatch
  static const MaterialColor secondary = MaterialColor(
    0xFF4CAF50,
    <int, Color>{
      50: Color(0xFFE8F5E9),
      100: Color(0xFFC8E6C9),
      200: Color(0xFFA5D6A7),
      300: Color(0xFF81C784),
      400: Color(0xFF66BB6A),
      500: Color(0xFF4CAF50),
      600: Color(0xFF43A047),
      700: Color(0xFF388E3C),
      800: Color(0xFF2E7D32),
      900: Color(0xFF1B5E20),
    },
  );

  // Accent Colors
  static const MaterialColor accent = MaterialColor(
    0xFFFFC107,
    <int, Color>{
      50: Color(0xFFFFF8E1),
      100: Color(0xFFFFECB3),
      200: Color(0xFFFFE082),
      300: Color(0xFFFFD54F),
      400: Color(0xFFFFCA28),
      500: Color(0xFFFFC107),
      600: Color(0xFFFFB300),
      700: Color(0xFFFFA000),
      800: Color(0xFFFF8F00),
      900: Color(0xFFFF6F00),
    },
  );

  // Error Colors
  static const MaterialColor error = MaterialColor(
    0xFFE53935,
    <int, Color>{
      50: Color(0xFFFFEBEE),
      100: Color(0xFFFFCDD2),
      200: Color(0xFFEF9A9A),
      300: Color(0xFFE57373),
      400: Color(0xFFEF5350),
      500: Color(0xFFE53935),
      600: Color(0xFFD32F2F),
      700: Color(0xFFC62828),
      800: Color(0xFFB71C1C),
      900: Color(0xFF8B0000),
    },
  );

  // Neutral Colors
  static const MaterialColor neutral = MaterialColor(
    0xFF9E9E9E,
    <int, Color>{
      50: Color(0xFFFAFAFA),
      100: Color(0xFFF5F5F5),
      200: Color(0xFFEEEEEE),
      300: Color(0xFFE0E0E0),
      400: Color(0xFFBDBDBD),
      500: Color(0xFF9E9E9E),
      600: Color(0xFF757575),
      700: Color(0xFF616161),
      800: Color(0xFF424242),
      900: Color(0xFF212121),
    },
  );
}

// lib/config/theme/app_theme.dart
import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  // Light Theme
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: AppColors.primary,
          onPrimary: Colors.white,
          secondary: AppColors.secondary,
          onSecondary: Colors.white,
          error: AppColors.error,
          onError: Colors.white,
          background: AppColors.neutral.shade50,
          onBackground: AppColors.neutral.shade900,
          surface: Colors.white,
          onSurface: AppColors.neutral.shade900,
        ),
        // Text Theme
        textTheme: TextTheme(
          displayLarge: TextStyle(
            fontSize: 96,
            fontWeight: FontWeight.w300,
            color: AppColors.neutral.shade900,
          ),
          displayMedium: TextStyle(
            fontSize: 60,
            fontWeight: FontWeight.w300,
            color: AppColors.neutral.shade900,
          ),
          displaySmall: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.w400,
            color: AppColors.neutral.shade900,
          ),
          headlineLarge: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w500,
            color: AppColors.neutral.shade900,
          ),
          headlineMedium: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.w400,
            color: AppColors.neutral.shade900,
          ),
          headlineSmall: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w400,
            color: AppColors.neutral.shade900,
          ),
          titleLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: AppColors.neutral.shade900,
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColors.neutral.shade900,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.neutral.shade900,
          ),
        ),
        // Component Themes
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        cardTheme: CardTheme(
          color: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppColors.secondary,
          foregroundColor: Colors.white,
        ),
      );

  // Dark Theme
  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme(
          brightness: Brightness.dark,
          primary: AppColors.primary.shade300,
          onPrimary: Colors.black,
          secondary: AppColors.secondary.shade300,
          onSecondary: Colors.black,
          error: AppColors.error.shade300,
          onError: Colors.black,
          background: AppColors.neutral.shade900,
          onBackground: AppColors.neutral.shade50,
          surface: AppColors.neutral.shade800,
          onSurface: AppColors.neutral.shade50,
        ),
        // Text Theme
        textTheme: TextTheme(
          displayLarge: TextStyle(
            fontSize: 96,
            fontWeight: FontWeight.w300,
            color: AppColors.neutral.shade50,
          ),
          displayMedium: TextStyle(
            fontSize: 60,
            fontWeight: FontWeight.w300,
            color: AppColors.neutral.shade50,
          ),
          displaySmall: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.w400,
            color: AppColors.neutral.shade50,
          ),
          headlineLarge: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w500,
            color: AppColors.neutral.shade50,
          ),
          headlineMedium: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.w400,
            color: AppColors.neutral.shade50,
          ),
          headlineSmall: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w400,
            color: AppColors.neutral.shade50,
          ),
          titleLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: AppColors.neutral.shade50,
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColors.neutral.shade50,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.neutral.shade50,
          ),
        ),
        // Component Themes
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.neutral.shade800,
          foregroundColor: AppColors.neutral.shade50,
          elevation: 0,
        ),
        cardTheme: CardTheme(
          color: AppColors.neutral.shade800,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary.shade300,
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppColors.secondary.shade300,
          foregroundColor: Colors.black,
        ),
      );
}

// lib/config/theme/theme_provider.dart
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier() : super(ThemeMode.system) {
    _loadThemeMode();
  }

  static const _themeKey = 'app_theme';

  Future<void> _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final theme = prefs.getString(_themeKey);
    if (theme != null && theme.isNotEmpty) {
      state = ThemeMode.values.firstWhere(
        (e) => e.name == theme,
        orElse: () => ThemeMode.system,
      );
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, mode.name);
    state = mode;
  }
}


// lib/main.dart
class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    
    return MaterialApp(
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      // ... other configurations
    );
  }
}
```

### 3.4.2. Theme Change
```dart
 ref.read(themeProvider.notifier).setThemeMode(ThemeMode.light);
```

### 3.4.3. Sử dụng Theme
```dart
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Sử dụng màu từ theme
    final primary = Theme.of(context).colorScheme.primary;
    final onPrimary = Theme.of(context).colorScheme.onPrimary;
    
    // Sử dụng text style từ theme
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    
    return Container(
      color: primary,
      child: Text(
        'Hello World',
        style: titleStyle?.copyWith(color: onPrimary),
      ),
    );
  }
}
```

### 3.4.4. Best Practices

1. **Tổ chức Theme**:
   - Tách biệt colors và theme configuration
   - Sử dụng extension methods cho theme helpers
   - Tạo constants cho các giá trị dùng chung

2. **Color Management**:
   - Sử dụng MaterialColor cho color swatches
   - Định nghĩa đầy đủ các shade (50-900)
   - Đảm bảo contrast ratio phù hợp

3. **Responsive Design**:
   - Sử dụng MediaQuery cho responsive values
   - Tạo các breakpoints cho different screen sizes
   - Adjust text sizes based on screen size

4. **Performance**:
   - Cache theme instances
   - Sử dụng const widgets khi có thể
   - Tránh rebuild không cần thiết

5. **Accessibility**:
   - Đảm bảo contrast ratio đạt chuẩn WCAG
   - Hỗ trợ dynamic text scaling
   - Test với screen readers

### 3.4.5. Extensions hiện tại
```dart
extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colors => theme.colorScheme;
  TextTheme get textTheme => theme.textTheme;
  bool get isDark => theme.brightness == Brightness.dark;
}

// Sử dụng
Widget build(BuildContext context) {
  return Container(
    color: context.colors.primary,
    child: Text(
      'Hello',
      style: context.textTheme.bodyLarge,
    ),
  );
}
```

### 3.4.6. Theme Extensions Nâng Cao

```dart
// lib/config/theme/theme_extensions.dart
import 'package:flutter/material.dart';

/// Extension cho BuildContext để truy cập theme dễ dàng hơn
extension ThemeContext on BuildContext {
  // Theme Data
  ThemeData get theme => Theme.of(this);
  ColorScheme get colors => theme.colorScheme;
  TextTheme get text => theme.textTheme;
  
  // Colors từ ColorScheme
  Color get primary => colors.primary;
  Color get onPrimary => colors.onPrimary;
  Color get secondary => colors.secondary;
  Color get onSecondary => colors.onSecondary;
  Color get background => colors.background;
  Color get onBackground => colors.onBackground;
  Color get surface => colors.surface;
  Color get onSurface => colors.onSurface;
  Color get error => colors.error;
  Color get onError => colors.onError;
  
  // Custom Colors từ AppColors
  MaterialColor get primarySwatch => AppColors.primary;
  MaterialColor get secondarySwatch => AppColors.secondary;
  MaterialColor get accentSwatch => AppColors.accent;
  MaterialColor get errorSwatch => AppColors.error;
  MaterialColor get neutralSwatch => AppColors.neutral;
  
  // Shades của Primary
  Color get primary50 => primarySwatch.shade50;
  Color get primary100 => primarySwatch.shade100;
  Color get primary200 => primarySwatch.shade200;
  Color get primary300 => primarySwatch.shade300;
  Color get primary400 => primarySwatch.shade400;
  Color get primary500 => primarySwatch.shade500;
  Color get primary600 => primarySwatch.shade600;
  Color get primary700 => primarySwatch.shade700;
  Color get primary800 => primarySwatch.shade800;
  Color get primary900 => primarySwatch.shade900;
  
  // Shades của Secondary
  Color get secondary50 => secondarySwatch.shade50;
  Color get secondary100 => secondarySwatch.shade100;
  Color get secondary200 => secondarySwatch.shade200;
  Color get secondary300 => secondarySwatch.shade300;
  Color get secondary400 => secondarySwatch.shade400;
  Color get secondary500 => secondarySwatch.shade500;
  Color get secondary600 => secondarySwatch.shade600;
  Color get secondary700 => secondarySwatch.shade700;
  Color get secondary800 => secondarySwatch.shade800;
  Color get secondary900 => secondarySwatch.shade900;
  
  // Shades của Accent
  Color get accent50 => accentSwatch.shade50;
  Color get accent100 => accentSwatch.shade100;
  Color get accent200 => accentSwatch.shade200;
  Color get accent300 => accentSwatch.shade300;
  Color get accent400 => accentSwatch.shade400;
  Color get accent500 => accentSwatch.shade500;
  Color get accent600 => accentSwatch.shade600;
  Color get accent700 => accentSwatch.shade700;
  Color get accent800 => accentSwatch.shade800;
  Color get accent900 => accentSwatch.shade900;
  
  // Shades của Error
  Color get error50 => errorSwatch.shade50;
  Color get error100 => errorSwatch.shade100;
  Color get error200 => errorSwatch.shade200;
  Color get error300 => errorSwatch.shade300;
  Color get error400 => errorSwatch.shade400;
  Color get error500 => errorSwatch.shade500;
  Color get error600 => errorSwatch.shade600;
  Color get error700 => errorSwatch.shade700;
  Color get error800 => errorSwatch.shade800;
  Color get error900 => errorSwatch.shade900;
  
  // Shades của Neutral
  Color get neutral50 => neutralSwatch.shade50;
  Color get neutral100 => neutralSwatch.shade100;
  Color get neutral200 => neutralSwatch.shade200;
  Color get neutral300 => neutralSwatch.shade300;
  Color get neutral400 => neutralSwatch.shade400;
  Color get neutral500 => neutralSwatch.shade500;
  Color get neutral600 => neutralSwatch.shade600;
  Color get neutral700 => neutralSwatch.shade700;
  Color get neutral800 => neutralSwatch.shade800;
  Color get neutral900 => neutralSwatch.shade900;
  
  // Text Styles
  TextStyle? get displayLarge => text.displayLarge;
  TextStyle? get displayMedium => text.displayMedium;
  TextStyle? get displaySmall => text.displaySmall;
  TextStyle? get headlineLarge => text.headlineLarge;
  TextStyle? get headlineMedium => text.headlineMedium;
  TextStyle? get headlineSmall => text.headlineSmall;
  TextStyle? get titleLarge => text.titleLarge;
  TextStyle? get titleMedium => text.titleMedium;
  TextStyle? get titleSmall => text.titleSmall;
  TextStyle? get bodyLarge => text.bodyLarge;
  TextStyle? get bodyMedium => text.bodyMedium;
  TextStyle? get bodySmall => text.bodySmall;
  
  // Theme Mode
  bool get isDark => theme.brightness == Brightness.dark;
  bool get isLight => theme.brightness == Brightness.light;
  
  // Responsive
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
  EdgeInsets get padding => MediaQuery.of(this).padding;
  EdgeInsets get viewInsets => MediaQuery.of(this).viewInsets;
  EdgeInsets get viewPadding => MediaQuery.of(this).viewPadding;
}

/// Sử dụng trong widget
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Thay vì:
    // final primary = Theme.of(context).colorScheme.primary;
    // final onPrimary = Theme.of(context).colorScheme.onPrimary;
    // final titleStyle = Theme.of(context).textTheme.titleLarge;
    
    // Có thể viết ngắn gọn:
    return Container(
      color: context.primary,
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            color: context.primary100, // Shade 100 của primary
            child: Text(
              'Light Primary Background',
              style: context.titleLarge?.copyWith(
                color: context.onPrimary,
              ),
            ),
          ),
          Container(
            color: context.secondary300, // Shade 300 của secondary
            child: Text(
              'Medium Secondary Background',
              style: context.bodyLarge?.copyWith(
                color: context.onSecondary,
              ),
            ),
          ),
          if (context.isDark) // Kiểm tra dark mode
            Container(
              color: context.neutral800,
              child: Text(
                'Dark Mode Specific',
                style: context.bodyMedium?.copyWith(
                  color: context.neutral200,
                ),
              ),
            ),
          Container(
            width: context.width * 0.8, // 80% màn hình
            padding: context.padding, // Safe area padding
            color: context.error100,
            child: Text(
              'Error State',
              style: context.titleSmall?.copyWith(
                color: context.error900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Custom Color Extension
extension CustomColorScheme on ColorScheme {
  // Custom semantic colors
  Color get success => AppColors.secondary.shade500;
  Color get warning => AppColors.accent.shade500;
  Color get info => AppColors.primary.shade300;
  
  // Custom component colors
  Color get cardBackground => brightness == Brightness.light 
    ? AppColors.neutral.shade50 
    : AppColors.neutral.shade800;
    
  Color get divider => brightness == Brightness.light
    ? AppColors.neutral.shade200
    : AppColors.neutral.shade700;
    
  Color get shadow => brightness == Brightness.light
    ? AppColors.neutral.shade400.withOpacity(0.2)
    : AppColors.neutral.shade900.withOpacity(0.4);
}

/// Sử dụng Custom Color Extension
class CustomCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.cardBackground,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: context.colors.shadow,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Success Message',
            style: context.titleMedium?.copyWith(
              color: context.colors.success,
            ),
          ),
          Divider(color: context.colors.divider),
          Text(
            'Warning Message',
            style: context.bodyMedium?.copyWith(
              color: context.colors.warning,
            ),
          ),
        ],
      ),
    );
  }
}
```

### 3.4.7. Sử dụng Theme với Constants

```dart
// lib/config/theme/theme_constants.dart
class ThemeSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  
  static const EdgeInsets buttonPadding = EdgeInsets.symmetric(
    horizontal: md,
    vertical: sm,
  );
  
  static const EdgeInsets cardPadding = EdgeInsets.all(md);
  
  static const EdgeInsets screenPadding = EdgeInsets.symmetric(
    horizontal: md,
    vertical: lg,
  );
}

class ThemeRadius {
  static const double sm = 4.0;
  static const double md = 8.0;
  static const double lg = 16.0;
  static const double xl = 24.0;
  
  static const BorderRadius buttonRadius = BorderRadius.all(
    Radius.circular(md),
  );
  
  static const BorderRadius cardRadius = BorderRadius.all(
    Radius.circular(lg),
  );
}

class ThemeShadow {
  static List<BoxShadow> get small => [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      blurRadius: 4,
      offset: Offset(0, 2),
    ),
  ];
  
  static List<BoxShadow> get medium => [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      blurRadius: 8,
      offset: Offset(0, 4),
    ),
  ];
  
  static List<BoxShadow> get large => [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      blurRadius: 16,
      offset: Offset(0, 8),
    ),
  ];
}

/// Sử dụng Constants
class ThemedWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: ThemeSpacing.screenPadding,
      child: Card(
        margin: ThemeSpacing.cardPadding,
        shape: RoundedRectangleBorder(
          borderRadius: ThemeRadius.cardRadius,
        ),
        elevation: 0,
        child: Container(
          decoration: BoxDecoration(
            color: context.colors.cardBackground,
            borderRadius: ThemeRadius.cardRadius,
            boxShadow: ThemeShadow.medium,
          ),
          padding: ThemeSpacing.cardPadding,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: ThemeSpacing.buttonPadding,
              shape: RoundedRectangleBorder(
                borderRadius: ThemeRadius.buttonRadius,
              ),
            ),
            onPressed: () {},
            child: Text('Themed Button'),
          ),
        ),
      ),
    );
  }
} 
