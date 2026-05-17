TWEAK_NAME = PvZFusionMenu

# Tự động quét và gộp tất cả các file .cpp, .mm tham gia biên dịch trong các thư mục con
PvZFusionMenu_FILES = ImGuiDrawView.mm $(wildcard *.cpp) $(wildcard ImGui/*.cpp) $(wildcard KittyMemory/*.cpp)
PvZFusionMenu_FRAMEWORKS = UIKit Foundation CoreGraphics QuartzCore
PvZFusionMenu_LIBRARIES = substrate

ARCHS = arm64
TARGET = iphone:clang:latest:14.0

# Thêm cờ -I để ép trình biên dịch tìm kiếm file tiêu đề gốc (.h) trong các thư mục con
PvZFusionMenu_CFLAGS = -Wno-deprecated-declarations -Wno-error -IKittyMemory -IImGui
PvZFusionMenu_CCFLAGS = -std=c++11 -IKittyMemory -IImGui

include $(THEOS)/makefiles/common.mk
include $(THEOS)/makefiles/tweak.mk
