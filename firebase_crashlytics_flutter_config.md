# ✅ HƯỚNG DẪN CẤU HÌNH `firebase_crashlytics` CHO FLUTTER (ANDROID)

## 🎯 Mục tiêu
- Kết nối app Flutter với Firebase
- Tích hợp và cấu hình `firebase_crashlytics`
- Test và xác nhận lỗi được ghi nhận trên Firebase Console

---

## 🧩 PHẦN 1: TẠO & KẾT NỐI FIREBASE PROJECT

### 🔹 Bước 1: Truy cập Firebase Console
- Link: https://console.firebase.google.com

### 🔹 Bước 2: Tạo project Firebase
1. Nhấn **“Add project”**
2. Nhập tên project → Next
3. Bật/tắt Google Analytics → Next → **Create Project**

### 🔹 Bước 3: Thêm App Android
1. Trong trang chính > click **biểu tượng Android** (</>)
2. Nhập thông tin:
   - **Android package name**: ví dụ: `com.example.myapp` → giống `applicationId` trong `android/app/build.gradle`
   - App nickname: tùy chọn
   - SHA-1: có thể bỏ qua nếu chưa cần
3. Nhấn **Register app**

### 🔹 Bước 4: Tải file `google-services.json`
- Sau khi đăng ký → click **Download google-services.json**
- **Đặt vào thư mục:** `android/app/`

---

## ⚙️ PHẦN 2: CẤU HÌNH FLUTTER APP

### 🔹 Bước 5: Thêm dependencies vào `pubspec.yaml`

```yaml
dependencies:
  firebase_core: ^2.27.0
  firebase_crashlytics: ^3.5.3
```

Chạy:
```bash
dart pub global activate flutterfire_cli
flutter pub get
```

### 🔹 Bước 6: Khởi tạo Firebase trong `main.dart`

Tạo file `firebase_options.dart` bằng lệnh:
```bash
flutterfire configure
```

Trong `main.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  runApp(MyApp());
}
```

---

## 🛠 PHẦN 3: CẤU HÌNH DỰ ÁN ANDROID

### 🔹 Bước 7: `android/build.gradle`

```gradle
buildscript {
    dependencies {
        classpath 'com.google.gms:google-services:4.4.0'
    }
}
```

### 🔹 Bước 8: `android/app/build.gradle`

```gradle
apply plugin: 'com.google.gms.google-services'

dependencies {
    implementation 'com.google.firebase:firebase-crashlytics'
}

firebaseCrashlytics {
    nativeSymbolUploadEnabled true
}
```

### 🔹 Bước 9: Sync Gradle

```bash
flutter clean
flutter pub get
flutter build apk
```

---

## 🧪 PHẦN 4: TEST CRASH

### 🔹 Bước 10: Tạo nút test crash

```dart
ElevatedButton(
  onPressed: () {
    FirebaseCrashlytics.instance.crash();
  },
  child: Text('Test Crash'),
)
```

---

## 📊 PHẦN 5: KIỂM TRA TRÊN FIREBASE CONSOLE

### 🔹 Bước 11: Vào Firebase Console

- Truy cập: https://console.firebase.google.com
- Chọn project
- Vào: **Build > Crashlytics**

---

## 💡 MẸO & LƯU Ý

| Tình huống | Giải pháp |
|-----------|-----------|
| Lỗi không hiện | Chạy bằng Android Studio thay vì `flutter run` |
| Muốn test nhanh | Dùng `FirebaseCrashlytics.instance.crash()` |
| JSON sai vị trí | Kiểm tra `android/app/google-services.json` |
| Thiếu file `firebase_options.dart` | Chạy `flutterfire configure` |
| Dùng emulator | Vẫn gửi lỗi như máy thật |

---

## ✅ KẾT LUẬN

Bạn đã cấu hình:
- Firebase Project và file `google-services.json`
- Firebase SDK (`firebase_core`, `firebase_crashlytics`)
- Gửi lỗi thử và xem được trên Firebase Console
