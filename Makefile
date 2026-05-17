TWEAK_NAME = PvZFusionMenu

PvZFusionMenu_FILES = ImGuiDrawView.mm $(wildcard *.cpp) $(wildcard ImGui/*.cpp) $(wildcard KittyMemory/*.cpp)
PvZFusionMenu_FRAMEWORKS = UIKit Foundation CoreGraphics QuartzCore

ARCHS = arm64
TARGET = iphone:clang:latest:14.0

PvZFusionMenu_CFLAGS = -Wno-deprecated-declarations -Wno-error
# Dòng mới thêm vào để sửa lỗi C++11 trong KittyUtils:
PvZFusionMenu_CCFLAGS = -std=c++11

include $(THEOS)/makefiles/common.mk
include $(THEOS)/makefiles/tweak.mk
