    !include "MUI2.nsh"
	!include ".\version.nsh"
	!include "LogicLib.nsh"


;------------------------------------------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------------------------------------------
;Definitions

    !define APP "xlwCppCLITemplateExtractor"
	Name "${APP}"
    OutFile "${APP}.exe"
	RequestExecutionLevel user
	BrandingText "${APP}"
	InstallDir "$DOCUMENTS\XLL_Project"


;------------------------------------------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------------------------------------------
;Interface Settings

	!define MUI_PAGE_HEADER_TEXT "Select Installation Directory"
	!define MUI_PAGE_HEADER_SUBTEXT "Select the directory where the template project will be placed"
	!define MUI_DIRECTORYPAGE_TEXT_TOP "When the project is extracted, you should start by changing the name of the project folder and any relevant project files"
    !define MUI_ABORTWARNING
    !define MUI_ICON "xlw\docs\images\xlw_32x32.ico"
    !define MUI_UNICON "xlw\docs\images\xlw_32x32.ico"
	!define MUI_HEADERIMAGE

	!define MUI_HEADERIMAGE_BITMAP "xlw\docs\images\logo.bmp"
	
	



;------------------------------------------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------------------------------------------
;Pages

	Page custom ExtractorPage ;Custom page

    !insertmacro MUI_PAGE_DIRECTORY
    !insertmacro MUI_PAGE_INSTFILES

	
;------------------------------------------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------------------------------------------
;Languages

    !insertmacro MUI_LANGUAGE "English"
	
;------------------------------------------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------------------------------------------

;------------------------------------------------------------------------------------------------------------------------
;------------------------------------------------------------------------------------------------------------------------

Var DIALOG
Var HEADLINE
Var TEXT
Var IMAGECTL
Var IMAGE
Var DIRECTORY
Var FREESPACE

Var HEADLINE_FONT
Var STATE

Var VC11	
Var VC10

Var VC11_STATE
Var VC10_STATE


	
Function ExtractorPage

	!insertmacro MUI_HEADER_TEXT "XLW C++/CLI Template Extractor"  "Select the Dev environment for which the template project is to be extracted"

	GetDlgItem $0 $HWNDPARENT 1
	EnableWindow $0 0

	nsDialogs::Create 1018
	Pop $DIALOG

	GetFunctionAddress $0 RadioChanged
	
	${NSD_CreateRadioButton} 100 30 100% 10% "Visual C++ 2012 (VC11)"    
	Pop $VC11
	nsDialogs::OnClick  $VC11 $0
	${NSD_CreateRadioButton} 100 60 100% 10% "Visual C++ 2010 (VC10)"    
	Pop $VC10
	nsDialogs::OnClick  $VC10 $0

	
	nsDialogs::Show

FunctionEnd

Var RadioStatus

Function RadioChanged
	Pop $0 # dir hwnd

	GetDlgItem $0 $HWNDPARENT 1
	EnableWindow $0 1

	${NSD_GetState} $VC10 $VC10_STATE
	${NSD_GetState} $VC11 $VC11_STATE


	
	
FunctionEnd

Var DIR

!macro projectfiles dir
		SetOutPath "$INSTDIR"
		File /nonfatal /r "xlw\Template_Projects\C++CLR\${dir}\*.vcxproj"
		File /nonfatal /r "xlw\Template_Projects\C++CLR\${dir}\*.vcxproj.filters"
		File /nonfatal /r "xlw\Template_Projects\C++CLR\${dir}\*.vcproj"
		File /nonfatal /r "xlw\Template_Projects\C++CLR\${dir}\*.sln"
		File /nonfatal /r "xlw\Template_Projects\C++CLR\${dir}\*.mak"
		File /nonfatal /r "xlw\Template_Projects\C++CLR\${dir}\*.nmake"
		CreateDirectory  "$INSTDIR\AutoGeneratedSource"

	!macroend
	
		
	!macro sourcefiles dir
		SetOutPath "$INSTDIR"
		File /nonfatal /r "xlw\Template_Projects\C++CLR\${dir}\*.cpp"
		File /nonfatal /r "xlw\Template_Projects\C++CLR\${dir}\*.h"
		File /nonfatal /r "xlw\Template_Projects\C++CLR\${dir}\*.snk"
	!macroend



!macro GETDIR  STATEFLAG TDIR

	${If} ${STATEFLAG} ==  ${BST_CHECKED}

			!insertmacro projectfiles ${TDIR}
			!insertmacro sourcefiles  ${TDIR}
			 Exec "explorer.exe $INSTDIR" 
	${Endif}


!macroend

Section #
    !insertmacro GETDIR $VC11_STATE "vc11"
	!insertmacro GETDIR $VC10_STATE "vc10"
SectionEnd 










