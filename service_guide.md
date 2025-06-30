# Hướng dẫn tạo Service mới

## Mục lục
- [Hướng dẫn tạo Service mới](#hướng-dẫn-tạo-service-mới)
  - [Mục lục](#mục-lục)
  - [1. Tạo Model (`lib/models/example_model.dart`)](#1-tạo-model-libmodelsexample_modeldart)
  - [2. Tạo Service Interface (`lib/services/example_service.dart`)](#2-tạo-service-interface-libservicesexample_servicedart)
  - [3. Tạo Provider (`lib/providers/example_provider.dart`)](#3-tạo-provider-libprovidersexample_providerdart)
  - [4. Xử lý lỗi (`lib/core/utils/error_handling.dart`)](#4-xử-lý-lỗi-libcoreutilserror_handlingdart)
  - [5. Tích hợp UI (`lib/screens/example/example_screen.dart`)](#5-tích-hợp-ui-libscreensexampleexample_screendart)
  - [6. Checklist triển khai](#6-checklist-triển-khai)
    - [Tạo Model (`lib/models/example_model.dart`):](#tạo-model-libmodelsexample_modeldart)
    - [Tạo Service (`lib/services/example_service.dart`):](#tạo-service-libservicesexample_servicedart)
    - [Tạo Provider (`lib/providers/example_provider.dart`):](#tạo-provider-libprovidersexample_providerdart)
    - [Testing (`test/`):](#testing-test)
    - [Documentation (`.docs/`):](#documentation-docs)
  - [7. Best Practices](#7-best-practices)
    - [Error Handling (`lib/core/utils/error_handling.dart`)](#error-handling-libcoreutilserror_handlingdart)
    - [State Management (`lib/providers/`)](#state-management-libproviders)
    - [Security (`lib/core/utils/security.dart`)](#security-libcoreutilssecuritydart)
    - [Performance (`lib/core/utils/performance.dart`)](#performance-libcoreutilsperformancedart)
  - [8. Lưu ý quan trọng](#8-lưu-ý-quan-trọng)
    - [useEffect với Provider](#useeffect-với-provider)
      - [Các trường hợp sử dụng useEffect](#các-trường-hợp-sử-dụng-useeffect)
      - [Các lưu ý quan trọng](#các-lưu-ý-quan-trọng)
      - [Quy tắc chung](#quy-tắc-chung)

## 1. Tạo Model (`lib/models/example_model.dart`)
Model là lớp đại diện cho cấu trúc dữ liệu của service. File model nên được đặt trong thư mục `lib/models/` với tên file theo format `example_model.dart`.

```dart
class ExampleModel {
  String? responseMessage;
  int? responseCode;
  String? responseDate;

  ExampleModel({
    this.responseMessage,
    this.responseCode,
    this.responseDate,
  });

  ExampleModel.fromJson(Map<String, dynamic> json) {
    responseMessage = json['responseMessage'];
    responseCode = json['responseCode'];
    responseDate = json['responseDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['responseMessage'] = responseMessage;
    data['responseCode'] = responseCode;
    data['responseDate'] = responseDate;
    return data;
  }
}
```

## 2. Tạo Service Interface (`lib/services/example_service.dart`)
Service interface định nghĩa các endpoint và phương thức tương tác với API. File service nên được đặt trong thư mục `lib/services/` với tên file theo format `example_service.dart`.

```dart
@RestApi()
abstract class ExampleService {
  factory ExampleService(Ref ref) => _ExampleService(ref.read(dioProvider));

  @GET('/example/endpoint')
  Future<ExampleModel> getExample(@Queries() Map<String, dynamic> param);

  @POST('/example/create')
  Future<ExampleModel> createExample(@Body() Map<String, dynamic> data);

  @PUT('/example/{id}')
  Future<ExampleModel> updateExample(
    @Path() String id,
    @Body() Map<String, dynamic> data
  );

  @DELETE('/example/{id}')
  Future<void> deleteExample(@Path() String id);
}
```

## 3. Tạo Provider (`lib/providers/example_provider.dart`)
Provider quản lý state và business logic. File provider nên được đặt trong thư mục `lib/providers/` với tên file theo format `example_provider.dart`.

```dart
final exampleProvider = StateNotifierProvider<ExampleProvider, AsyncValue<ExampleModel>>((ref) {
  return ExampleProvider(ref);
});

class ExampleProvider extends StateNotifier<AsyncValue<ExampleModel>> {
  final Ref ref;
  late final exampleService = ref.read(exampleServiceProvider);

  ExampleProvider(this.ref) : super(const AsyncValue.loading()) {
    loadInitialData();
  }

  Future<void> loadInitialData() async {
    try {
      state = const AsyncValue.loading();
      final result = await exampleService.getExample({});
      state = AsyncValue.data(result);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}
```

## 4. Xử lý lỗi (`lib/core/utils/error_handling.dart`)
Cơ chế xử lý lỗi thống nhất. Logic xử lý lỗi nên được đặt trong thư mục `lib/core/utils/` với tên file `error_handling.dart`.

```dart
void handleError(dynamic error) {
  if (error is DioException) {
    switch (error.response?.statusCode) {
      case 401:
        // Xử lý unauthorized
        break;
      case 404:
        // Xử lý not found
        break;
      default:
        // Xử lý lỗi khác
    }
  } else {
    // Xử lý lỗi không phải network
  }
}
```

## 5. Tích hợp UI (`lib/screens/example/example_screen.dart`)
Sử dụng provider trong widget. File màn hình nên được đặt trong thư mục `lib/screens/example/` với tên file theo format `example_screen.dart`.

```dart
class ExampleScreen extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exampleState = ref.watch(exampleProvider);
    
    return exampleState.when(
      loading: () => CircularProgressIndicator(),
      error: (error, stack) => Text('Error: $error'),
      data: (data) => // Hiển thị dữ liệu
    );
  }
}
```

## 6. Checklist triển khai

### Tạo Model (`lib/models/example_model.dart`):
- [ ] Định nghĩa cấu trúc dữ liệu
- [ ] Implement fromJson/toJson
- [ ] Thêm validation logic

### Tạo Service (`lib/services/example_service.dart`):
- [ ] Định nghĩa endpoints
- [ ] Cấu hình HTTP methods
- [ ] Định nghĩa response types
- [ ] Generate code với retrofit

### Tạo Provider (`lib/providers/example_provider.dart`):
- [ ] Định nghĩa state
- [ ] Implement business logic
- [ ] Xử lý lỗi và exceptions
- [ ] Quản lý loading states

### Testing (`test/`):
- [ ] Unit tests cho service (`test/services/example_service_test.dart`)
- [ ] Integration tests (`test/integration/example_integration_test.dart`)
- [ ] UI tests (`test/screens/example_screen_test.dart`)

### Documentation (`.docs/`):
- [ ] API documentation (`.docs/api/example_api.md`)
- [ ] Usage examples (`.docs/examples/example_usage.md`)
- [ ] Error handling guide (`.docs/guides/error_handling.md`)

## 7. Best Practices

### Error Handling (`lib/core/utils/error_handling.dart`)
- Xử lý tất cả các loại lỗi có thể xảy ra
- Hiển thị thông báo lỗi phù hợp
- Log lỗi để debug

### State Management (`lib/providers/`)
- Sử dụng AsyncValue cho loading states
- Cache data khi cần thiết
- Tối ưu số lượng rebuild

### Security (`lib/core/utils/security.dart`)
- Validate input data
- Xử lý token authentication
- Bảo vệ sensitive data

### Performance (`lib/core/utils/performance.dart`)
- Tối ưu số lượng request
- Implement caching strategy
- Xử lý memory leaks

## 8. Lưu ý quan trọng

### useEffect với Provider

#### Các trường hợp sử dụng useEffect
1. **Khởi tạo dữ liệu**
```dart
useEffect(() {
  ref.read(exampleProvider.notifier).loadInitialData();
  return null;
}, []); // Chỉ chạy một lần khi widget được mount
```

2. **Theo dõi thay đổi tham số**
```dart
useEffect(() {
  if (searchTerm.isNotEmpty) {
    ref.read(searchProvider.notifier).search(searchTerm);
  }
  return null;
}, [searchTerm]); // Chạy khi searchTerm thay đổi
```

3. **Cleanup resources**
```dart
useEffect(() {
  final subscription = ref.read(streamProvider.notifier).subscribe();
  return () => subscription.cancel();
}, []); // Cleanup khi widget unmount
```

4. **Xử lý side effects**
```dart
useEffect(() {
  final state = ref.read(authProvider);
  if (state.isAuthenticated) {
    ref.read(userProvider.notifier).loadUserProfile();
  }
  return null;
}, [ref.watch(authProvider)]); // Chạy khi auth state thay đổi
```

5. **Đồng bộ hóa dữ liệu**
```dart
useEffect(() {
  final syncData = () async {
    await ref.read(syncProvider.notifier).sync();
  };
  syncData();
  final timer = Timer.periodic(Duration(minutes: 5), (_) => syncData());
  return () => timer.cancel();
}, []); // Sync định kỳ và cleanup
```

#### Các lưu ý quan trọng

1. **Tránh vòng lặp vô hạn**
```dart
// ❌ Không nên
useEffect(() {
  ref.read(counterProvider.notifier).increment();
}, [ref.watch(counterProvider)]); // Sẽ tạo vòng lặp vô hạn

// ✅ Nên
useEffect(() {
  if (shouldIncrement) {
    ref.read(counterProvider.notifier).increment();
  }
}, [shouldIncrement]); // Chỉ chạy khi điều kiện thay đổi
```

2. **Xử lý bất đồng bộ**
```dart
useEffect(() {
  bool mounted = true;
  
  Future<void> fetchData() async {
    try {
      final data = await ref.read(dataProvider.notifier).fetch();
      if (mounted) {
        // Xử lý data
      }
    } catch (e) {
      if (mounted) {
        // Xử lý lỗi
      }
    }
  }
  
  fetchData();
  return () => mounted = false;
}, []);
```

3. **Quản lý dependencies**
```dart
// ❌ Không nên
useEffect(() {
  ref.read(provider1.notifier).fetch();
  ref.read(provider2.notifier).fetch();
  ref.read(provider3.notifier).fetch();
}, []); // Khó maintain và debug

// ✅ Nên
useEffect(() {
  ref.read(provider1.notifier).fetch();
}, []);

useEffect(() {
  ref.read(provider2.notifier).fetch();
}, []);

useEffect(() {
  ref.read(provider3.notifier).fetch();
}, []);
```

4. **Xử lý loading state**
```dart
useEffect(() {
  ref.read(loadingProvider.notifier).state = true;
  ref.read(dataProvider.notifier).fetch().whenComplete(() {
    if (mounted) {
      ref.read(loadingProvider.notifier).state = false;
    }
  });
  return null;
}, []);
```

5. **Tối ưu hiệu suất**
```dart
// ❌ Không nên
useEffect(() {
  ref.read(heavyProvider.notifier).process();
}, [ref.watch(someProvider)]); // Có thể gây re-render không cần thiết

// ✅ Nên
useEffect(() {
  if (shouldProcess) {
    ref.read(heavyProvider.notifier).process();
  }
}, [shouldProcess]); // Chỉ chạy khi thực sự cần thiết
```

#### Quy tắc chung
1. Luôn kiểm tra `mounted` trước khi cập nhật state trong các tác vụ bất đồng bộ
2. Sử dụng dependency array một cách thông minh để tránh re-render không cần thiết
3. Luôn cleanup resources trong hàm return của useEffect
4. Tách logic phức tạp thành các useEffect riêng biệt
5. Sử dụng các biến điều kiện thay vì watch trực tiếp provider state

*Tài liệu này được tạo và duy trì như một phần của Khung CursorRIPER.* 