Cấu Hình Phân Tích Mã Nguồn
Chạy lệnh flutter analyze để kiểm tra lỗi trong mã nguồn.
Kế Thừa Quy Tắc

Kế thừa bộ quy tắc đề xuất từ flutter_lints để áp dụng các quy tắc cơ bản cho Flutter:include: package:flutter_lints/flutter.yaml



Cấu Hình Analyzer



Phần
Mô Tả



Plugins
- custom_lint: Kích hoạt plugin custom_lint để hỗ trợ các quy tắc tùy chỉnh


Errors
- missing_required_param: error - Thiếu tham số bắt buộc trong hàm hoặc constructor- invalid_annotation_target: error - Sử dụng annotation không đúng đối tượng- deprecated_member_use: warning - Cảnh báo khi sử dụng API đã deprecated


Quy Tắc Linter



Quy Tắc
Mô Tả



always_declare_return_types
Bắt buộc khai báo kiểu trả về cho hàm, tránh nhầm lẫn


avoid_empty_else
Tránh khối else rỗng, dễ gây hiểu nhầm hoặc lỗi logic


avoid_init_to_null
Tránh khởi tạo biến bằng null, không cần thiết trong Dart null safety


avoid_relative_lib_imports
Tránh import tương đối trong thư viện, đảm bảo tính nhất quán


avoid_returning_null_for_future
Không trả null cho Future, tránh lỗi async


avoid_slow_async_io
Tránh sử dụng I/O async chậm trong luồng chính


avoid_unused_constructor_parameters
Phát hiện tham số constructor không dùng, tránh lãng phí


await_only_futures
Chỉ dùng await với Future, tránh lỗi runtime


camel_case_types
Tên lớp phải theo kiểu camelCase, đảm bảo chuẩn code


cancel_subscriptions
Hủy subscription để tránh rò rỉ bộ nhớ


close_sinks
Đóng StreamController để giải phóng tài nguyên


comment_references
Đảm bảo comment tham chiếu đúng đối tượng


constant_identifier_names
Tên hằng số phải viết HOA, theo chuẩn Dart


curly_braces_in_flow_control_structures
Bắt buộc dùng {} cho if/else, tránh lỗi logic


empty_catches
Tránh khối catch rỗng, dễ bỏ sót lỗi


empty_constructor_bodies
Tránh constructor rỗng, gây khó hiểu


empty_statements
Tránh câu lệnh rỗng (;), dễ gây lỗi


file_names
Tên file phải theo chuẩn snake_case


hash_and_equals
Bắt buộc override hashCode khi override equals


implementation_imports
Tránh import implementation, đảm bảo tính đóng gói


invariant_booleans
Tránh điều kiện boolean không thay đổi


iterable_contains_unrelated_type
Tránh kiểm tra contains với kiểu không liên quan


join_return_with_assignment
Kết hợp return và gán giá trị để code gọn hơn


literal_only_boolean_expressions
Tránh biểu thức boolean thừa thãi


missing_whitespace_between_adjacent_strings
Thêm khoảng trắng giữa các chuỗi liền kề


no_adjacent_strings_in_list
Tránh danh sách chuỗi liền kề, nên gộp lại


no_duplicate_case_values
Tránh giá trị case trùng lặp trong switch


non_constant_identifier_names
Tên biến/phương thức theo camelCase


null_check_on_nullable_type_parameter
Tránh kiểm tra null không cần thiết


package_api_docs
Yêu cầu tài liệu API cho package


package_prefixed_library_names
Tên thư viện phải có tiền tố package


prefer_adjacent_string_concatenation
Ưu tiên nối chuỗi liền kề


prefer_collection_literals
Sử dụng cú pháp ngắn cho List, Map, Set


prefer_conditional_assignment
Dùng gán điều kiện thay vì if


prefer_const_constructors
Dùng const cho constructor khi có thể, tối Silent Ưu hiệu suất


prefer_const_declarations
Dùng const cho biến không đổi


prefer cama final_fields
Dùng final cho trường không thay đổi, tránh lỗi logic


prefer_final_in_for_each
Dùng final trong vòng lặp for-each


prefer_final_locals
Dùng final cho biến cục bộ, giảm lỗi vô tình thay đổi


prefer_function_declarations_over_variables
Ưu tiên khai báo hàm thay vì biến hàm


prefer_if_elements_to_conditional_expressions
Dùng if thay vì biểu thức điều kiện phức tạp


prefer_null_aware_operators
Dùng toán tử null-aware để code ngắn gọn


prefer_single_quotes
Dùng dấu nháy đơn, chuẩn Flutter


prefer_spread_collections
Dùng spread operator cho collection


prefer_void_to_null
Dùng void thay vì Null cho kiểu trả về


sized_box_for_whitespace
Dùng SizedBox thay vì Container cho khoảng trắng


sort_child_properties_last
Sắp xếp thuộc tính child cuối cùng trong widget


sort_constructors_first
Sắp xếp constructor đầu tiên trong lớp


sort_unnamed_constructors_first
Constructor không tên đứng đầu


test_types_in_equals
Kiểm tra kiểu trong phương thức equals


throw_in_finally
Tránh throw trong khối finally, gây lỗi khó debug


unawaited_futures
Cảnh báo Future không được await, tránh bỏ sót


unnecessary_await_in_return
Tránh await không cần thiết trong return


unnecessary_brace_in_string_interps
Tránh dấu {} thừa trong string interpolation


unnecessary_getters_setters
Tránh getter/setter không cần thiết


unnecessary_lambdas
Tránh lambda khi có thể dùng phương thức trực tiếp


unnecessary_new
Tránh dùng từ khóa new, không cần thiết


unnecessary_null_checks
Tránh kiểm tra null thừa thãi


unnecessary_nullable_for_final_variable_declarations
Tránh khai báo nullable cho final


unnecessary_overrides
Tránh override không cần thiết


unnecessary_parenthesis
Tránh dấu ngoặc thừa


unnecessary_statements
Tránh câu lệnh không có tác dụng


unnecessary_this
Tránh dùng this khi không cần thiết


use_build_context_synchronously
Tránh dùng BuildContext sau async, gây crash


use_function_type_syntax_for_parameters
Dùng cú pháp kiểu hàm cho tham số


use_key_in_widget_constructors
Bắt buộc dùng key trong constructor widget


use_rethrow_when_possible
Dùng rethrow để giữ stack trace


use_setters_to_change_properties
Dùng setter thay vì phương thức để đổi thuộc tính


use_string_buffers
Dùng StringBuffer cho nối chuỗi nhiều lần


use_super_parameters
Dùng super parameters để giảm lặp code


valid_regexps
Đảm bảo regex hợp lệ


void_checks
Tránh gán giá trị cho void


always_put_required_named_parameters_first
Tham số bắt buộc đứng đầu


avoid_bool_literals_in_conditional_expressions
Tránh dùng boolean literals trong điều kiện


avoid_redundant_argument_values
Tránh giá trị tham số dư thừa


avoid_setters_without_getters
Tránh setter không có getter tương ứng


avoid_types_on_closure_parameters
Tránh khai báo kiểu cho tham số closure


avoid_unnecessary_containers
Tránh dùng Container thừa, gây phình widget tree


avoid_web_libraries_in_flutter
Tránh dùng thư viện web trong Flutter


diagnostic_describe_all_properties
Yêu cầu mô tả tất cả thuộc tính trong debug


flutter_style_todos
Định dạng TODO theo chuẩn Flutter


prefer_const_constructors_in_immutables
Dùng const cho widget không đổi


prefer_mixin
Dùng mixin thay vì abstract class khi phù hợp


sort_child_properties_last
Thuộc tính child của widget đứng cuối


use_colored_box
Dùng ColoredBox thay vì Container cho màu nền


use_decorated_box
Dùng DecoratedBox cho decoration


use_full_hex_values_for_flutter_colors
Dùng mã hex đầy đủ cho màu


use_named_constants
Dùng hằng số có tên thay vì giá trị cứng


use_to_and_as_if_applicable
Dùng to/as khi chuyển đổi kiểu

