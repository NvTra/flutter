📖 Phần 1: Flutter Hooks Cơ bản
📌 Bài 1: Counter với useState
Tạo một màn hình có nút + và hiển thị số lần bấm.

Dùng useState để quản lý state.

📌 Bài 2: TextField với useTextEditingController
Tạo một TextField và một Text hiển thị nội dung nhập vào theo real-time.

Dùng useTextEditingController

📌 Bài 3: Animation với useAnimationController
Tạo một ô vuông co giãn kích thước khi nhấn nút.

Dùng useAnimationController và useEffect để tự động start animation.

📖 Phần 2: Riverpod Hook Cơ bản
📌 Bài 4: Counter với StateProvider
Tạo Provider lưu số lần bấm.

Dùng HookConsumerWidget để watch và tăng giá trị.

📌 Bài 5: Tạo TextField lưu giá trị vào Provider
TextField nhập tên người dùng.

Provider StateProvider<String> lưu giá trị.

Text hiển thị Xin chào, {tên bạn} theo real-time.

📖 Phần 3: useEffect + useFuture + useStream
📌 Bài 6: Dùng useEffect log khi widget mount
Tạo màn hình in log khi mở và đóng.

📌 Bài 7: useFuture hiển thị dữ liệu API giả lập
Dùng Future.delayed trả về dữ liệu sau 2s.

Dùng useFuture hiển thị loading và dữ liệu.

📌 Bài 8: useStream với Stream.periodic
Hiển thị đồng hồ đếm thời gian thực bằng Stream.periodic

Dùng useStream để lắng nghe stream

📖 Phần 4: Riverpod Hook + FutureProvider / StreamProvider
📌 Bài 9: FutureProvider gọi API giả lập
Provider fetch dữ liệu giả lập sau 3s

Hiển thị loading / dữ liệu / error

📌 Bài 10: StreamProvider cập nhật số random mỗi 1s
Provider stream trả về số ngẫu nhiên mỗi giây

Hiển thị số thay đổi real-time

📖 Phần 5: Project thực tế
📌 Bài 11: Todo App với Riverpod Hook
Thêm, xóa, hiển thị danh sách todo

Dùng StateNotifierProvider hoặc StateProvider

TextField + ListView + FloatingActionButton

📖 Phần 6: Bài tập nâng cao
📌 Bài 12: Đồng bộ dữ liệu form nhiều trường
Form gồm 3 TextField: tên, email, số điện thoại

Mỗi field dùng useTextEditingController

Provider lưu trữ giá trị toàn cục và cập nhật real-time

📌 Bài 13: Load danh sách bài viết từ API với Dio + FutureProvider
Dùng Dio fetch API giả lập

Dùng FutureProvider + HookConsumerWidget

Hiển thị ListView bài viết
