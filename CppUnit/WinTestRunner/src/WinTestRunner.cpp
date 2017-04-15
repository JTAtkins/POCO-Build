//
// WinTestRunner.cpp
//
// $Id: //poco/1.4/CppUnit/WinTestRunner/src/WinTestRunner.cpp#1 $
//


#include "WinTestRunner/WinTestRunner.h"
#include "TestRunnerDlg.h"
#include "CppUnit/TestRunner.h"
#include <fstream>


namespace CppUnit {


WinTestRunner::WinTestRunner()
{
}


WinTestRunner::~WinTestRunner()
{
	for (std::vector<Test*>::iterator it = _tests.begin(); it != _tests.end(); ++it)
		delete *it;
}


void WinTestRunner::run()
{
	// Note: The following code is some evil hack to
	// add batch capability to the MFC based WinTestRunner.
#ifdef _UNICODE
	std::wstring cmdLine(AfxGetApp()->m_lpCmdLine);
#else
	std::string cmdLine(AfxGetApp()->m_lpCmdLine);
#endif
	if (cmdLine.size() >= 2 && cmdLine[0] == _T('/') && (cmdLine[1] == _T('b') || cmdLine[1] == _T('B')))
	{
		TestRunner runner;
		for (std::vector<Test*>::iterator it = _tests.begin(); it != _tests.end(); ++it)
			runner.addTest((*it)->toString(), *it);
		_tests.clear();
		std::vector<std::string> args;
		args.push_back("WinTestRunner");
		args.push_back("-all");
		bool success = runner.run(args);
		ExitProcess(success ? 0 : 1);
	}
	else
	{
		// We're running in interactive mode.
		TestRunnerDlg dlg;
		dlg.setTests(_tests);
		dlg.DoModal();
	}
}


void WinTestRunner::addTest(Test* pTest)
{
	_tests.push_back(pTest);
}


BEGIN_MESSAGE_MAP(WinTestRunnerApp, CWinApp)
END_MESSAGE_MAP()


BOOL WinTestRunnerApp::InitInstance()
{	
#ifdef _UNICODE
	std::wstring cmdLine(AfxGetApp()->m_lpCmdLine);
#else
	std::string cmdLine(AfxGetApp()->m_lpCmdLine);
#endif

	if (cmdLine.size() >= 2 && cmdLine[0] == _T('/') && (cmdLine[1] == _T('b') || cmdLine[1] == _T('B')))
	{
		// We're running in batch mode.
		#ifdef _UNICODE
				std::wstring outPath;
		#else
				std::string outPath;
		#endif
		if (cmdLine.size() > 4 && cmdLine[2] == _T(':'))
		{
			outPath = cmdLine.substr(3);
		}
		else
		{
			TCHAR buffer[1024];
			GetModuleFileName(NULL, buffer, sizeof(buffer));
			outPath = buffer;
			outPath += _T(".out");
		}
		_tfreopen(outPath.c_str(), _T("w"), stdout);
		_tfreopen(outPath.c_str(), _T("w"), stderr);
		TestMain();
	}
	else
	{
		AllocConsole();
		SetConsoleTitle(_T("CppUnit WinTestRunner Console"));
		freopen("CONOUT$", "w", stdout);
		freopen("CONOUT$", "w", stderr);
		freopen("CONIN$", "r", stdin);
		TestMain();
		FreeConsole();
	}
	return FALSE;
}


void WinTestRunnerApp::TestMain()
{
}


} // namespace CppUnit
