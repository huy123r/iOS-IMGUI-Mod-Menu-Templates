TWEAK_NAME = PvZFusionMenu

# Sử dụng lệnh wildcard để ép trình biên dịch tự động tìm và dịch TẤT CẢ các file .cpp, .mm của ImGui và KittyMemory có sẵn trong thư mục dự án của bạn
PvZFusionMenu_FILES = ImGuiDrawView.mm $(wildcard *.cpp) $(wildcard ImGui/*.cpp) $(wildcard KittyMemory/*.cpp)

# Các thư viện đồ họa hệ thống bắt buộc của ứng dụng iOS
PvZFusionMenu_FRAMEWORKS = UIKit Foundation CoreGraphics QuartzCore

# Cấu hình biên dịch chip 64-bit cho thiết bị iOS
ARCHS = arm64
TARGET = iphone:clang:latest:14.0

include $(THEOS)/makefiles/common.mk
include $(THEOS)/makefiles/tweak.mk
