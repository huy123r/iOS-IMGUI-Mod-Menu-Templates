TWEAK_NAME = PvZFusionMenu

# Biên dịch các tệp nguồn chính
PvZFusionMenu_FILES = ImGuiDrawView.mm $(wildcard *.cpp) $(wildcard ImGui/*.cpp) $(wildcard KittyMemory/*.cpp)
PvZFusionMenu_FRAMEWORKS = UIKit Foundation CoreGraphics QuartzCore
PvZFusionMenu_LIBRARIES = substrate

ARCHS = arm64
TARGET = iphone:clang:latest:14.0

# Sử dụng các cờ tối ưu hóa giúp trình biên dịch ưu tiên gọi thư viện C++ gốc của Apple thay vì tìm trong thư mục con
PvZFusionMenu_CFLAGS = -Wno-deprecated-declarations -Wno-error -I. -IKittyMemory -IImGui -fno-modules -fno-modules-search-all
PvZFusionMenu_CCFLAGS = -std=c++11 -I. -IKittyMemory -IImGui -fno-modules -fno-modules-search-all

include $(THEOS)/makefiles/common.mk
include $(THEOS)/makefiles/tweak.mk
