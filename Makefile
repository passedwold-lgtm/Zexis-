ARCHS = arm64
DEBUG = 0
FINALPACKAGE = 1
FOR_RELEASE = 1
IGNORE_WARNINGS = 1
THEOS_PACKAGE_SCHEME = rootless
TARGET = iphone:clang:latest:16.5

TWEAK_NAME = FFH4X

$(TWEAK_NAME)_CCFLAGS = -std=c++17 -fno-rtti -DNDEBUG -Wall -Wno-deprecated-declarations -Wno-unused-variable -Wno-unused-value -Wno-unused-function -fvisibility=hidden
$(TWEAK_NAME)_CFLAGS = -fobjc-arc -Wall -Wno-deprecated-declarations -Wno-unused-variable -Wno-unused-value -Wno-unused-function -fvisibility=hidden

ifeq ($(IGNORE_WARNINGS),1)
  $(TWEAK_NAME)_CFLAGS += -w
  $(TWEAK_NAME)_CCFLAGS += -w
endif

$(TWEAK_NAME)_FRAMEWORKS = AudioToolbox UIKit Foundation Security QuartzCore CoreGraphics CoreText AVFoundation Accelerate GLKit SystemConfiguration GameController

# ✅ JRMemory
$(TWEAK_NAME)_CFLAGS += -I./JRMemory.framework/Headers
$(TWEAK_NAME)_LDFLAGS += -F./ -framework JRMemory

$(TWEAK_NAME)_FILES = lostwq.mm \
    JRMemory.framework/JRMemory.mm 
    $(wildcard IMGUI/*.cpp) $(wildcard IMGUI/*.mm) \
    $(wildcard hook/*.c)

include $(THEOS)/makefiles/common.mk
include $(THEOS)/makefiles/tweak.mk
