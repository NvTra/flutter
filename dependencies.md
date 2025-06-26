## enum_to_string:
* `flutter pub add enum_to_string`
* Giúp bạn chuyển đổi dễ dàng các giá trị enum thành chuỗi và ngược lại. Rất tiện lợi khi bạn cần lưu trữ hoặc hiển thị các giá trị enum.
## intl:
* `flutter pub add intl`
* Cung cấp các công cụ để quốc tế hóa (internationalization) và bản địa hóa (localization) ứng dụng của bạn, bao gồm định dạng tin nhắn, ngày tháng, số và hỗ trợ văn bản đa hướng. Đây là thư viện cần thiết cho các ứng dụng đa ngôn ngữ.
## cupertino_icons:
* `flutter pub add cupertino_icons` 
* Cung cấp một bộ biểu tượng theo phong cách iOS (Cupertino) chất lượng cao để sử dụng trong ứng dụng Flutter của bạn, giúp ứng dụng trông tự nhiên hơn trên các thiết bị Apple.
## flutter_dotenv:
* `flutter pub add flutter_dotenv`
* Cho phép bạn tải các biến môi trường từ file .env. Điều này cực kỳ hữu ích để quản lý các khóa API, thông tin nhạy cảm và các cấu hình khác nhau mà không cần mã hóa cứng trong code.
## auto_route:
* `flutter pub add auto_route`
* Một giải pháp định tuyến mạnh mẽ dựa trên tạo mã tự động. Nó giúp đơn giản hóa việc điều hướng bằng cách tự động tạo ra các route dựa trên các widget trang của bạn, giảm thiểu code boilerplate và cung cấp các đối số an toàn kiểu (type-safe).
#### dio:
* `flutter pub add dio`
* Một HTTP client mạnh mẽ và phổ biến cho Dart. dio cung cấp các tính năng nâng cao như interceptors (để ghi nhật ký, xác thực), cấu hình toàn cục, FormData, hủy yêu cầu và tải lên/tải xuống file với tiến độ.
## http:
* `flutter pub add http`  
* HTTP client chính thức cho Dart. Đơn giản và nhẹ hơn dio, phù hợp cho các yêu cầu HTTP cơ bản (GET, POST, PUT, DELETE, v.v.). 
## http_parser:
* `flutter pub add http_parser` 
* Cung cấp các tiện ích để phân tích cú pháp và thao tác với dữ liệu liên quan đến HTTP, như headers và loại nội dung. Thường là một dependency của các thư viện mạng khác. 
## retrofit:
* `flutter pub add retrofit` 
* Một trình tạo HTTP client an toàn kiểu cho Dart và Flutter. Nó sử dụng các chú thích để tạo ra mã boilerplate cho các cuộc gọi API, giúp lớp mạng của bạn sạch sẽ, mạnh mẽ và dễ bảo trì khi sử dụng cùng với dio.
## hive:
* `flutter pub add hive`
* Một cơ sở dữ liệu khóa-giá trị cực kỳ nhẹ và nhanh cho Flutter và Dart. Hive rất tốt cho việc lưu trữ dữ liệu cục bộ, cung cấp sự đơn giản, hiệu suất cao và tương thích đa nền tảng.
## hive_flutter:
* `flutter pub add hive_flutter`  
* Cung cấp các tiện ích và widget đặc thù cho Flutter của Hive, chẳng hạn như ValueListenableBuilder để cập nhật giao diện người dùng một cách phản ứng khi dữ liệu Hive thay đổi.
## shared_preferences:
* `flutter pub add shared_preferences`
* Giải pháp phổ biến để lưu trữ các cặp khóa-giá trị đơn giản trên thiết bị (ví dụ: cài đặt người dùng, token đăng nhập). Phù hợp cho lượng nhỏ dữ liệu không yêu cầu truy vấn phức tạp.
## flutter_hooks:
* `flutter pub add flutter_hooks`
* Mang khái niệm React Hooks vào Flutter. Nó cho phép bạn tái sử dụng logic có trạng thái giữa các widget mà không thay đổi cấu trúc widget của bạn, đơn giản hóa việc quản lý trạng thái và giảm code boilerplate trong các widget chức năng.
## hooks_riverpod:
* `flutter pub add hooks_riverpod`
* Một giải pháp quản lý trạng thái mạnh mẽ và linh hoạt cho Flutter, được xây dựng trên nền tảng Riverpod. Khi kết hợp với flutter_hooks, nó cung cấp một cách mạnh mẽ và dễ kiểm thử để quản lý trạng thái ứng dụng, các phụ thuộc và logic nghiệp vụ.
## permission_handler:
* `flutter pub add permission_handler`
* Cung cấp API đa nền tảng để kiểm tra và yêu cầu các quyền truy cập thiết bị khác nhau (ví dụ: camera, vị trí, bộ nhớ, micro). Cần thiết cho các ứng dụng cần truy cập các tính năng nhạy cảm của thiết bị.
## pay:
* `flutter pub add pay`
* Có thể dùng để tích hợp với các cổng thanh toán (ví dụ: Google Pay, Apple Pay). Nó đơn giản hóa quá trình thêm chức năng thanh toán vào ứng dụng Flutter của bạn.
## flutter_svg:
* `flutter pub add flutter_svg`
* Cho phép bạn hiển thị hình ảnh SVG (Scalable Vector Graphics) trong ứng dụng Flutter của mình. SVG là độc lập với độ phân giải và lý tưởng cho các biểu tượng và hình minh họa cần mở rộng mà không bị vỡ.
## carousel_slider:
* `flutter pub add carousel_slider`
* Cung cấp một widget thanh trượt (carousel) có thể tùy chỉnh cao. Hữu ích để hiển thị thư viện ảnh, banner hoặc bất kỳ nội dung nào ở định dạng có thể vuốt.
## flutter_verification_code:
* `flutter pub add flutter_verification_code`
* Cung cấp một widget tùy chỉnh được thiết kế đặc biệt để nhập mã xác minh (ví dụ: OTP cho xác minh điện thoại). Nó thường cung cấp một chuỗi các trường nhập liệu cho mỗi chữ số.
## video_player:
* `flutter pub add video_player`
* Plugin Flutter chính thức để phát video. Nó cung cấp một bộ điều khiển và chức năng cơ bản để nhúng phát video vào ứng dụng của bạn.
## chewie:
* `flutter pub add chewie`
* Một trình phát video mạnh mẽ cho Flutter, được xây dựng trên video_player. Chewie cung cấp giao diện người dùng toàn diện và có thể tùy chỉnh hơn cho việc phát video, bao gồm các điều khiển phát/tạm dừng, âm lượng, toàn màn hình và tiến độ.
## webview_flutter:
* `flutter pub add webview_flutter`
* Cho phép bạn nhúng widget WebView trực tiếp vào ứng dụng Flutter của mình. Điều này hữu ích để hiển thị nội dung web, liên kết bên ngoài hoặc tích hợp các dịch vụ dựa trên web mà không cần rời khỏi ứng dụng.
## flutter_widget_from_html:
* `flutter pub add flutter_widget_from_html`
* Hiển thị nội dung HTML dưới dạng các widget Flutter. Điều này rất có giá trị khi bạn cần hiển thị văn bản đa dạng thức, các bài viết được định dạng hoặc nội dung từ CMS cung cấp HTML.
## url_launcher:
* `flutter pub add url_launcher`
* Cho phép ứng dụng Flutter của bạn mở URL bằng ứng dụng mặc định của nền tảng. Có thể dùng để mở trang web trong trình duyệt, gửi email, thực hiện cuộc gọi điện thoại hoặc mở các liên kết dành riêng cho ứng dụng khác.
## cached_network_image:
* `flutter pub add cached_network_image`
* Một thư viện cần thiết để tải, lưu vào bộ nhớ cache và hiển thị hình ảnh từ internet một cách hiệu quả. Nó giúp cải thiện hiệu suất và trải nghiệm người dùng bằng cách tránh tải xuống nhiều lần cùng một hình ảnh.
## firebase_crashlytics:
* `flutter pub add firebase_crashlytics`
* Một dịch vụ báo cáo sự cố thời gian thực từ Firebase. Nó giúp bạn theo dõi, ưu tiên và khắc phục các sự cố ổn định trong ứng dụng của mình bằng cách cung cấp các báo cáo sự cố chi tiết.
## firebase_core:
* `flutter pub add firebase_core`
* Plugin Firebase cốt lõi cho Flutter. Đây là một dependency nền tảng cho bất kỳ dịch vụ Firebase nào khác mà bạn muốn sử dụng trong ứng dụng của mình, xử lý việc khởi tạo Firebase.
## firebase_analytics:
* `flutter pub add firebase_analytics`
* Tích hợp Firebase Analytics vào ứng dụng Flutter của bạn. Điều này cho phép bạn theo dõi hành vi người dùng, sự kiện và các chỉ số tùy chỉnh, cung cấp thông tin chi tiết có giá trị về cách người dùng tương tác với ứng dụng của bạn.
## image_picker:
* `flutter pub add image_picker`
* Cung cấp một cách thức đa nền tảng để chọn hình ảnh và video từ thư viện của thiết bị hoặc chụp chúng bằng camera.
## syncfusion_flutter_datagrid:
* `flutter pub add syncfusion_flutter_datagrid`
* Một phần của bộ UI Syncfusion Flutter. Gói này cung cấp một widget DataGrid mạnh mẽ và giàu tính năng, thường được sử dụng để hiển thị dữ liệu dạng bảng với các chức năng như sắp xếp, lọc, nhóm và chỉnh sửa.
## dropdown_button2:
* `flutter pub add dropdown_button2`
* Một widget DropdownButton có thể tùy chỉnh cao. Nó cung cấp nhiều tính linh hoạt và tính năng hơn so với DropdownButton tiêu chuẩn của Flutter, chẳng hạn như chức năng tìm kiếm, đa lựa chọn và tùy chỉnh kiểu dáng.
## syncfusion_flutter_datepicker:
* `flutter pub add syncfusion_flutter_datepicker`
* Một thành phần khác từ Syncfusion. Gói này cung cấp một widget chọn ngày có thể tùy chỉnh cao, cho phép người dùng chọn một ngày, khoảng ngày hoặc nhiều ngày với các chế độ xem khác nhau (tháng, năm, thập kỷ, thế kỷ).
## device_info_plus:
* `flutter pub add device_info_plus`
* Cung cấp thông tin chi tiết về thiết bị mà ứng dụng Flutter của bạn đang chạy, chẳng hạn như kiểu thiết bị, phiên bản hệ điều hành, thương hiệu và các định danh duy nhất. Hữu ích cho phân tích, gỡ lỗi hoặc điều chỉnh các tính năng cho các thiết bị cụ thể.
