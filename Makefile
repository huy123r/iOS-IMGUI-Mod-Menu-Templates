TWEAK_NAME = PvZFusionMenu

# Khai báo các tệp tin nguồn tham gia vào quá trình dịch
PvZFusionMenu_FILES = ImGuiDrawView.mm $(wildcard KittyMemory/*.cpp)

# Các thư viện giao diện hệ thống của iOS
PvZFusionMenu_FRAMEWORKS = UIKit Foundation CoreGraphics QuartzCore

# Biên dịch cấu trúc chip 64-bit cho các dòng iPhone đời mới
ARCHS = arm64
TARGET = iphone:clang:latest:14.0

include $(THEOS)/makefiles/common.mk
include $(THEOS)/makefiles/tweak.mk
