# Tên của dự án sau khi xuất bản
TWEAK_NAME = PvZFusionMenu

# Danh sách các tệp tin mã nguồn cần biên dịch trong dự án của bạn
PvZFusionMenu_FILES = ImGuiDrawView.mm $(wildcard KittyMemory/*.cpp)

# Các thư viện hệ thống cần thiết để giao diện đồ họa hiển thị trên màn hình iOS
PvZFusionMenu_FRAMEWORKS = UIKit Foundation CoreGraphics QuartzCore

# Thiết lập chế độ biên dịch và kiến trúc chip xử lý cho thiết bị iOS 64-bit
ARCHS = arm64
TARGET = iphone:clang:latest:14.0

include $(THEOS)/makefiles/common.mk
include $(THEOS)/makefiles/tweak.mk
