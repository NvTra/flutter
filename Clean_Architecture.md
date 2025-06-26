# Cấu Trúc Thư Mục Dự Án

| Thư Mục/Tệp        | Mô Tả                                                                 |
|--------------------|----------------------------------------------------------------------|
| **lib/**           | - Thư mục quan trọng nhất<br>- Tạo sẵn file mã nguồn `main.dart`<br>- Nơi tạo các file `.dart` và viết mã nguồn |
| **/android, ios,…**| - Thư mục chứa mã nguồn của từng nền tảng Android và iOS             |
| **/test**          | - Nơi viết các bài kiểm tra đơn vị (Unit Test) cho dự án             |
| **pubspec.yaml**   | - Nơi khai báo tên dự án, mô tả, các thư viện sử dụng và các tài nguyên như biểu tượng, hình ảnh, phông chữ |
| **.metadata, .packages** | - Các tệp cấu hình tự động                                         |
| **analysis_options.yaml** | - Cấu hình quy tắc phân tích và kiểm tra mã nguồn (linting) cho dự án |
| **core/**          | - Chứa cấu hình Dio, hằng số, xử lý lỗi, kiểm tra kết nối mạng       |
| **data/**          | - Giao tiếp API, cơ sở dữ liệu cục bộ, phân tích JSON thành model, triển khai repository |
| **domain/**        | - Logic nghiệp vụ thuần: entity, use case, giao diện repository       |
| **presentation/**  | - Mã nguồn giao diện: màn hình, view model, widget riêng lẻ          |
| **routes/**        | - Quản lý định tuyến (route) của ứng dụng (nếu có)                   |
| **main.dart**      | - Điểm khởi chạy của ứng dụng                                        |

## Cấu Trúc Chi Tiết Thư Mục `lib/`

```plaintext
lib/
├── core/                     # Các cấu hình và tiện ích chung
│   ├── api/                  # Cấu hình API (ví dụ: Dio client)
│   │   └── dio_client.dart
│   ├── constants/            # Hằng số dùng chung
│   │   └── app_constants.dart
│   ├── error/                # Xử lý lỗi và ngoại lệ
│   │   └── exception.dart
│   └── network/              # Tiện ích mạng (kiểm tra kết nối internet)
│       └── network_info.dart
│
├── data/                     # Tầng dữ liệu: API, cơ sở dữ liệu, model, repository
│   ├── datasources/          # Nguồn dữ liệu (remote và local)
│   │   └── remote/
│   │       └── post_remote_datasource.dart
│   ├── models/               # Mô hình dữ liệu từ JSON
│   │   └── post_model.dart
│   └── repositories/         # Triển khai repository
│       └── post_repository_impl.dart
│
├── domain/                   # Tầng nghiệp vụ: logic, entity, use case
│   ├── entities/             # Thực thể nghiệp vụ
│   │   └── post.dart
│   ├── repositories/         # Giao diện repository
│   │   └── post_repository.dart
│   └── usecases/             # Logic nghiệp vụ (use case)
│       └── fetch_posts_usecase.dart
│
├── presentation/             # Tầng giao diện: màn hình, view model, widget
│   ├── screens/              # Màn hình giao diện
│   │   └── post/
│   │       └── post_screen.dart
│   ├── viewmodels/           # View model quản lý trạng thái
│   │   └── post_viewmodel.dart
│   └── widgets/              # Widget tái sử dụng
│       └── post_item.dart
│
├── routes/                   # Quản lý định tuyến
│   └── app_router.dart
│
├── main.dart                 # Điểm khởi chạy ứng dụng
