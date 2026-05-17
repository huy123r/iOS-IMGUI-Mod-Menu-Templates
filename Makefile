TWEAK_NAME = PvZFusionMenu

PvZFusionMenu_FILES = ImGuiDrawView.mm $(wildcard *.cpp) $(wildcard ImGui/*.cpp) $(wildcard KittyMemory/*.cpp)
PvZFusionMenu_FRAMEWORKS = UIKit Foundation CoreGraphics QuartzCore

ARCHS = arm64
TARGET = iphone:clang:latest:14.0

# Dòng mới thêm vào để sửa lỗi sprintf:
PvZFusionMenu_CFLAGS = -Wno-deprecated-declarations -Wno-error

include $(THEOS)/makefiles/common.mk
include $(THEOS)/makefiles/tweak.mk
