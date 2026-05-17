TWEAK_NAME = PvZFusionMenu

# Quét toàn bộ các file .cpp và .mm trong dự án
PvZFusionMenu_FILES = ImGuiDrawView.mm $(wildcard *.cpp) $(wildcard ImGui/*.cpp) $(wildcard KittyMemory/*.cpp)
PvZFusionMenu_FRAMEWORKS = UIKit Foundation CoreGraphics QuartzCore
PvZFusionMenu_LIBRARIES = substrate

ARCHS = arm64
TARGET = iphone:clang:latest:14.0

# Bổ sung cờ -fno-modules và -fno-modules-search-all để ép hệ thống dịch C++ truyền thống, sửa sạch lỗi std_ios
PvZFusionMenu_CFLAGS = -Wno-deprecated-declarations -Wno-error -IKittyMemory -IImGui -fno-modules -fno-modules-search-all
PvZFusionMenu_CCFLAGS = -std=c++11 -IKittyMemory -IImGui -fno-modules -fno-modules-search-all

include $(THEOS)/makefiles/common.mk
include $(THEOS)/makefiles/tweak.mk
