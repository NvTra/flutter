📌 FVM là gì?
## FVM giúp:

- Cài đặt nhiều phiên bản Flutter khác nhau.
- Chỉ định phiên bản Flutter cho từng project.
- Quản lý version Flutter mà không ảnh hưởng đến hệ thống chính.

## Hướng dẫn cài đặt FVM
### 1. Cài đặt qua pub global (cách phổ biến nhất)
- Chạy lệnh sau:
```
dart pub global activate fvm
```
- Sau đó thêm vào PATH:
 - Với macOS / Linux:
```
export PATH="$PATH:$HOME/.pub-cache/bin"
```
 - Với Windows:
Thêm đường dẫn vào biến môi trường PATH.:
```
%USERPROFILE%\AppData\Local\Pub\Cache\bin
```

### 2. Kiểm tra cài đặt thành công
```
fvm --version

```
Nếu hiện version là OK.

### 3. Cài đặt các phiên bản
fvm install 3.22.2
fvm use 3.22.2
fvm flutter doctor

## Các lệnh FVM cơ bản
| Lệnh                    | Chức năng                                               |
| :---------------------- | :------------------------------------------------------ |
| `fvm install <version>` | Cài 1 version Flutter (ví dụ: `fvm install 3.22.2`)     |
| `fvm list`              | Liệt kê các bản Flutter đã cài                          |
| `fvm use <version>`     | Chỉ định version Flutter cho project                    |
| `fvm flutter <command>` | Chạy lệnh Flutter với FVM (ví dụ: `fvm flutter doctor`) |



