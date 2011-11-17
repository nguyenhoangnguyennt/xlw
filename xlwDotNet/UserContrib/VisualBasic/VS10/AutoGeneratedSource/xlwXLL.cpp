//// 
//// Autogenerated by xlw 
//// Do not edit this file, it will be overwritten 
//// by InterfaceGenerator 
////

#include "xlw/MyContainers.h"
#include <xlw/CellMatrix.h>
#include "DLL.h"
#include <xlw/xlw.h>
#include <xlw/XlFunctionRegistration.h>
#include <stdexcept>
#include <xlw/XlOpenClose.h>
#include <xlw/HiResTimer.h>
using namespace xlw;

namespace {
const char* LibraryName = "Template";
};


// registrations start here


namespace
{
  XLRegistration::XLFunctionRegistrationHelper
registerHelloWorld("xlHelloWorld",
"HelloWorld",
" Hello World ",
LibraryName,
0,
0
,false
,false
,""
,""
,false
,false
,false
);
}



extern "C"
{
LPXLFOPER EXCEL_EXPORT
xlHelloWorld(
)
{
EXCEL_BEGIN;

	if (XlfExcel::Instance().IsCalledByFuncWiz())
		return XlfOper(true);

std::wstring result(
	HelloWorld());
return XlfOper(result);
EXCEL_END
}
}



//////////////////////////

namespace
{
XLRegistration::Arg
EchoMatrixArgs[]=
{
{ "theMatrix"," Matrix ","XLF_OPER"}
};
  XLRegistration::XLFunctionRegistrationHelper
registerEchoMatrix("xlEchoMatrix",
"EchoMatrix",
" Echo a matrix ",
LibraryName,
EchoMatrixArgs,
1
,false
,false
,""
,""
,false
,false
,false
);
}



extern "C"
{
LPXLFOPER EXCEL_EXPORT
xlEchoMatrix(
LPXLFOPER theMatrixa)
{
EXCEL_BEGIN;

	if (XlfExcel::Instance().IsCalledByFuncWiz())
		return XlfOper(true);

XlfOper theMatrixb(
	(theMatrixa));
CellMatrix theMatrix(
	theMatrixb.AsCellMatrix("theMatrix"));

CellMatrix result(
	EchoMatrix(
		theMatrix)
	);
return XlfOper(result);
EXCEL_END
}
}



//////////////////////////

//////////////////////////
// Methods that will get registered to execute in AutoOpen
//////////////////////////

//////////////////////////
// Methods that will get registered to execute in AutoClose
//////////////////////////

