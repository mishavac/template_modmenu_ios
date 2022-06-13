ARCHS = arm64 

DEBUG = 0
FINALPACKAGE = 1
FOR_RELEASE = 1

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = hudware

hudware_FILES = Menu.mm Source.xm SwitchesTemplate.mm $(wildcard KittyMemory/*.cpp) $(wildcard SCLAlertView/*.m)
hudware_CFLAGS = -fobjc-arc #-w #-Wno-deprecated -Wno-deprecated-declarations
hudware_CCFLAGS = -std=c++11 -fno-rtti -fno-exceptions -DNDEBUG

include $(THEOS_MAKE_PATH)/tweak.mk
include $(THEOS_MAKE_PATH)/aggregate.mk