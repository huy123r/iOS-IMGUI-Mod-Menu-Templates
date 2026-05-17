TWEAK_NAME = PvZFusionMenu

PvZFusionMenu_FILES = ImGuiDrawView.mm $(wildcard *.cpp) $(wildcard ImGui/*.cpp) $(wildcard KittyMemory/*.cpp)
PvZFusionMenu_FRAMEWORKS = UIKit Foundation CoreGraphics QuartzCore

# Dòng mới thêm vào để sửa lỗi _MSHookFunction:
PvZFusionMenu_LIBRARIES = substrate

ARCHS = arm64
TARGET = iphone:clang:latest:14.0

PvZFusionMenu_CFLAGS = -Wno-deprecated-declarations -Wno-error
PvZFusionMenu_CCFLAGS = -std=c++11

include $(THEOS)/makefiles/common.mk
include $(THEOS)/makefiles/tweak.mk
