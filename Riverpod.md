# Hướng dẫn xây dựng ứng dụng Todo List với Riverpod

## 1. Thiết lập dự án

### 1.1. Tạo dự án Flutter mới
```bash
flutter create dio_river_pod
cd dio_river_pod
```

### 1.2. Cập nhật dependencies
Thêm các dependency sau vào file `pubspec.yaml`:
```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_riverpod: ^2.5.1
  riverpod_annotation: ^2.3.5

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0
  build_runner: ^2.4.8
  riverpod_generator: ^2.3.11
```

Sau đó chạy lệnh:
```bash
flutter pub get
```

## 2. Tạo Model

### 2.1. Tạo file `lib/models/todo_model.dart`
```dart
import 'package:flutter/foundation.dart';

@immutable
class Todo {
  final String id;
  final String title;
  final bool completed;

  const Todo({
    required this.id,
    required this.title,
    this.completed = false,
  });

  Todo copyWith({
    String? id,
    String? title,
    bool? completed,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      completed: completed ?? this.completed,
    );
  }
}
```

## 3. Tạo Providers

### 3.1. Tạo file `lib/providers/todo_provider.dart`
```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/todo_model.dart';

part 'todo_provider.g.dart';

@riverpod
class TodoList extends _$TodoList {
  @override
  List<Todo> build() {
    return [];
  }

  void addTodo(String title) {
    final todo = Todo(
      id: DateTime.now().toString(),
      title: title,
    );
    state = [...state, todo];
  }

  void toggleTodo(String id) {
    state = [
      for (final todo in state)
        if (todo.id == id)
          todo.copyWith(completed: !todo.completed)
        else
          todo,
    ];
  }

  void removeTodo(String id) {
    state = state.where((todo) => todo.id != id).toList();
  }
}

@riverpod
class TodoFilter extends _$TodoFilter {
  @override
  TodoFilterType build() {
    return TodoFilterType.all;
  }

  void setFilter(TodoFilterType filter) {
    state = filter;
  }
}

enum TodoFilterType { all, active, completed }

@riverpod
List<Todo> filteredTodos(FilteredTodosRef ref) {
  final filter = ref.watch(todoFilterProvider);
  final todos = ref.watch(todoListProvider);

  switch (filter) {
    case TodoFilterType.completed:
      return todos.where((todo) => todo.completed).toList();
    case TodoFilterType.active:
      return todos.where((todo) => !todo.completed).toList();
    case TodoFilterType.all:
      return todos;
  }
}
```

### 3.2. Tạo code tự động
Chạy lệnh sau để tạo các file code tự động:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## 4. Tạo giao diện người dùng

### 4.1. Cập nhật file `lib/main.dart`
```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/todo_provider.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}
```

## 5. Giải thích các thành phần chính

### 5.1. Model (Todo)
- `id`: Định danh duy nhất cho mỗi công việc
- `title`: Tiêu đề công việc
- `completed`: Trạng thái hoàn thành
- `copyWith`: Phương thức tạo bản sao với các thuộc tính có thể thay đổi

### 5.2. Providers
- `TodoList`: Quản lý danh sách các công việc
  - `build()`: Khởi tạo state ban đầu
  - `addTodo()`: Thêm công việc mới
  - `toggleTodo()`: Đổi trạng thái công việc
  - `removeTodo()`: Xóa công việc

- `TodoFilter`: Quản lý bộ lọc
  - `build()`: Khởi tạo bộ lọc mặc định
  - `setFilter()`: Thay đổi bộ lọc

- `filteredTodos`: Provider tính toán danh sách công việc đã lọc

### 5.3. Giao diện người dùng
- `ProviderScope`: Wrapper cần thiết cho Riverpod
- `TodoScreen`: Màn hình chính hiển thị danh sách công việc
- `AddTodoDialog`: Dialog thêm công việc mới

## 6. Các tính năng chính
1. Thêm công việc mới
2. Đánh dấu công việc đã hoàn thành
3. Xóa công việc
4. Lọc danh sách theo trạng thái:
   - Tất cả
   - Đang làm
   - Hoàn thành

## 7. Chạy ứng dụng
```bash
flutter run
```

## 8. Mở rộng ứng dụng
Bạn có thể mở rộng ứng dụng bằng cách:
1. Thêm local storage để lưu dữ liệu
2. Thêm chức năng sửa công việc
3. Thêm deadline cho công việc
4. Thêm categories cho công việc
5. Thêm chức năng sắp xếp
6. Thêm thông báo cho công việc
7. Đồng bộ dữ liệu với server

## 9. Cấu trúc thư mục
```
lib/
  ├── main.dart
  ├── models/
  │   └── todo_model.dart
  └── providers/
      └── todo_provider.dart
```

## 10. Lưu ý quan trọng
1. Đảm bảo đã cài đặt đầy đủ các dependency trong `pubspec.yaml`
2. Chạy `build_runner` mỗi khi thay đổi các file provider
3. Wrap ứng dụng trong `ProviderScope` để sử dụng Riverpod
4. Sử dụng `ConsumerWidget` hoặc `Consumer` để truy cập providers
5. Sử dụng `ref.watch()` để lắng nghe thay đổi và `ref.read()` để đọc giá trị một lần

## 11. Tài liệu tham khảo
- [Flutter Documentation](https://flutter.dev/docs)
- [Riverpod Documentation](https://riverpod.dev/)
- [Flutter Riverpod Package](https://pub.dev/packages/flutter_riverpod)
