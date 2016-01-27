include ./XLWVERSION.mak

LIBRARY = xlcall32

ifeq ($(PLATFORM), x64)
INSTALL_DIR = ../../bin64
else
INSTALL_DIR = ../../bin
endif


LIBTYPE=SHARE

INCLUDE_DIR = ../../include
CXXFLAGS = -fexceptions
LDEXTRAFLAGS=--enable-stdcall-fixup

SRC_DIR = ../../xlcall32stub
DEFFILE=../../xlcall32stub/xlcall32gcc.def
LIBSRC = xlcall32.cpp
	 

MAKEDIR = ../../make
include $(MAKEDIR)/make.rules
include $(MAKEDIR)/make.targets
