TWEAK_NAME = PvZFusionMenu

PvZFusionMenu_FILES = ImGuiDrawView.mm $(wildcard *.cpp) $(wildcard ImGui/*.cpp) $(wildcard KittyMemory/*.cpp)
PvZFusionMenu_FRAMEWORKS = UIKit Foundation CoreGraphics QuartzCore
PvZFusionMenu_LIBRARIES = substrate

ARCHS = arm64
TARGET = iphone:clang:latest:14.0
# Dòng lệnh bắt buộc phải có để triệt tiêu lỗi ldid command not found:
_THEOS_TARGET_SIGNING_COMMAND = echo "Bo qua buoc ldid mac dinh"

PvZFusionMenu_CFLAGS = -Wno-deprecated-declarations -Wno-error -I. -IKittyMemory -IImGui -fno-modules -fno-modules-search-all
PvZFusionMenu_CCFLAGS = -std=c++11 -I. -IKittyMemory -IImGui -fno-modules -fno-modules-search-all

include $(THEOS)/makefiles/common.mk
include $(THEOS)/makefiles/tweak.mk
