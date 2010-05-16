#Describes the xll 
BUILD=DEBUG
LIBRARY = ExampleAutoGenerated
LIBTYPE=SHARE
LIBPREFIX=
EXT_SHARE=xll

#Describes the Linker details
LIBDIRS = ../../../lib
ifeq ($(BUILD),DEBUG)
LIBS=xlw-gcc-s-gd-4_1_0a0
else
LIBS=xlw-gcc-s-4_1_0a0
endif 

#Describes the Compiler details
INCLUDE_DIR =../common_source  ../../../include
CXXFLAGS = -DBUILDING_DLL=1  -fexceptions 


#The source
SRC_DIR=../common_source
LIBSRC = PayOff.cpp \
		 PayOffConcrete.cpp \
		 PayOffRegistration.cpp \
		 Test.cpp \
		 xlwTest.cpp 
		
MAKEDIR = ../../../make
include $(MAKEDIR)/make.rules
include $(MAKEDIR)/make.targets