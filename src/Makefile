TARGET := iphone:clang:latest:16.0
INSTALL_TARGET_PROCESSES = shabisky

include $(THEOS)/makefiles/common.mk

APPLICATION_NAME = shabisky

shabisky_FILES = main.m XXAppDelegate.m XXRootViewController.m
shabisky_FRAMEWORKS = UIKit CoreGraphics WebKit
shabisky_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/application.mk
