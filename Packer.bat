@rem SaherElm IT Center Packer Tool 
@rem -----------------------------------
@rem this tools help to increase the speed of
@rem Packing Javascript Codes using 
@rem Babel & Obfuscator tool. 
@rem 
@rem Packing Proccess Includes 2 major steps :
@rem 	- compiling Javascript File using Babel ...
@rem 	- obfuscating Compiled File using Obfuscator ...
@rem
@rem Note: before using this tool you have to 
@rem install babel-cli, babel-preset-env and javascript-obfuscator.
 
@ECHO off

@rem Check if user don't enter atleast one Arg
IF [%1]==[] GOTO noArg

@rem Defining Global Vars ...
SET inputFile=%1
SET outputBabelFile=%2
SET outputObfFile=%3

@rem counting input args :
SET argCount=0
FOR %%i in (%*) do (
	SET /A argCount+=1	
 	)


@rem Validating Args Max Count ...
IF %argCount% GTR 3 GOTO invalidArgs

@rem Handle help arg ...
IF %argCount% EQU 1 (	
		@rem Handle Help Commands ...
		IF "%1" == "-h" GOTO showHelp
		IF "%1" == "--h" GOTO showHelp
		IF "%1" == "/h" GOTO showHelp

		@rem Handle Generate Output File Name ...
		GOTO generateOutputBabelFile
	)

@rem Handling two arg state ...
IF %argCount% EQU 2 (
		@rem Handle Help Exists Error ...
		IF "%1" == "-h" GOTO invalidArgs
		IF "%1" == "--h" GOTO invalidArgs
		IF "%1" == "/h" GOTO invalidArgs
		IF "%2" == "-h" GOTO invalidArgs
		IF "%2" == "--h" GOTO invalidArgs
		IF "%2" == "/h" GOTO invalidArgs

		IF %inputFile% == %outputBabelFile% GOTO sameFileError

		@rem Handle Work with Input and Output Files ...
		GOTO generateOutputObfFileFromSecondArg
	)

@rem Handling three arg state ...
IF %argCount% EQU 3 (
		@rem Handle Help Exists Error ...
		IF "%1" == "-h" GOTO invalidArgs
		IF "%1" == "--h" GOTO invalidArgs
		IF "%1" == "/h" GOTO invalidArgs
		IF "%2" == "-h" GOTO invalidArgs
		IF "%2" == "--h" GOTO invalidArgs
		IF "%2" == "/h" GOTO invalidArgs
		IF "%3" == "-h" GOTO invalidArgs
		IF "%3" == "--h" GOTO invalidArgs
		IF "%3" == "/h" GOTO invalidArgs

		IF %inputFile% == %outputBabelFile% GOTO sameFileError
		IF %inputFile% == %outputObfFile% GOTO sameFileError
		IF %outputBabelFile% == %outputObfFile% GOTO sameFileError

		@rem Handle Work with Input and Output Files ...
		GOTO startApp
	)

GOTO invalidArgs


@rem Generate Babel Output File ...
:generateOutputBabelFile
SET inputFileWithoutExt=%~n1
SET inputFileExt=%~x1
SET outputBabelFile=%inputFileWithoutExt%.Babel%inputFileExt%
GOTO generateOutputObfFile


@rem Generate Obfuscator Output File ...
:generateOutputObfFile
SET inputFileWithoutExt=%~n1
SET inputFileExt=%~x1
SET outputObfFile=%inputFileWithoutExt%.Obf%inputFileExt%
GOTO startApp


@rem Generate Obfuscator Output File from Babel Output File ...
:generateOutputObfFileFromSecondArg
SET inputFileWithoutExt=%~n2
SET inputFileExt=%~x2
SET outputObfFile=%inputFileWithoutExt%.Obf%inputFileExt%
GOTO startApp








@rem Start Application Logic ...
:startApp
ECHO.
ECHO SaherElm IT Center Packer Tool  
ECHO --------------------------------
GOTO validateInputFile
GOTO end


@rem Validating Input File ...
:validateInputFile
ECHO.
ECHO Start Validating %inputFile% ...

IF NOT EXIST %inputFile% (
		ECHO %inputFile% not exists.
		GOTO showHelpAndEndError
	)


@rem Validating Babel File ...
:validateOutPutBabelFile
ECHO.
ECHO Start Validating %outputBabelFile% ...

IF NOT EXIST %outputBabelFile% GOTO validateOutPutObfFile

ECHO %outputBabelFile% exists ...
SET /P commandDelBabel="Delete [y/n]: "

IF %commandDelBabel% == y GOTO handleDeleteBabelFile
IF %commandDelBabel% == Y GOTO handleDeleteBabelFile

GOTO showHelpAndEndFinish


@rem Delete Babel File if Exists ...
:handleDeleteBabelFile
ECHO Deleting %outputBabelFile% ...
DEL %outputBabelFile%


@rem Validating Obfuscator Output File ...
:validateOutPutObfFile
ECHO.
ECHO Stat Validating %outputObfFile% ...

IF NOT EXIST %outputObfFile% GOTO startBabelizing

ECHO %outputObfFile% exists ...
SET /P commandDelObf="Delete [y/n]: "

IF %commandDelObf% == y GOTO handleDeleteObfFile
IF %commandDelObf% == Y GOTO handleDeleteObfFile

GOTO showHelpAndEndFinish


@rem Delete Babel File if Exists ...
:handleDeleteObfFile
ECHO Deleting %outputObfFile% ...
DEL %outputObfFile%


@rem start Babelize file
:startBabelizing
ECHO.
ECHO Start Babelizing ...
SET runCommand=npx babel %inputFile% --out-file %outputBabelFile% --presets=env
@ECHO OFF
CALL %runCommand% >> SaherElmTool.log 2>&1
IF %errorlevel% NEQ 0 GOTO endError

ECHO Finish Babelizing ...


@rem start Obfuscating file
:startObfuscating
ECHO.
ECHO Start Obfuscating ...
SET runCommand=javascript-obfuscator %outputBabelFile% --output %outputObfFile% --compact true --identifier-names-generator mangled --dead-code-injection true --dead-code-injection-threshold 0.4 --string-array true --rotate-string-array true --string-array-encoding base64 --string-array-threshold 0.8 --unicode-escape-sequence true --disable-console-output true --debug-protection true --debug-protection-interval true --source-map true --source-map-mode inline --seed 0 --target browser
@ECHO OFF
CALL %runCommand% >> SaherElmTool.log 2>&1
IF %errorlevel% NEQ 0 GOTO endError

ECHO Finish Obfuscating ...
ECHO.
GOTO end






@rem a Handler which calls when user don't add any args ...
:noArg
ECHO.
ECHO SaherElm IT Center Packer Tool  
ECHO --------------------------------
ECHO.
ECHO this tools help to increase the speed of
ECHO Packing Javascript Codes using 
ECHO Babel and Obfuscator tool. 
ECHO. 
ECHO Packing Proccess Includes 2 major steps :
ECHO 	- compiling Javascript File using Babel ...
ECHO 	- obfuscating Compiled File using Obfuscator ...
ECHO.
ECHO Note: before using this tool you have to 
ECHO install babel-cli, babel-preset-env and javascript-obfuscator.
GOTO showHelpAndEndFinish


@rem show Help of Usage ...
:showHelp
ECHO.
ECHO SaherElm IT Center Packer Tool  
ECHO --------------------------------
ECHO.
ECHO Help :
ECHO ======
ECHO.
ECHO usage syntax :
ECHO.
ECHO 	Packer inputFile [outputBabelFile] [outputObfFile] [-h]
ECHO. 
ECHO Note: 
ECHO -----
ECHO this tools help to increase the speed of
ECHO Packing Javascript Codes using 
ECHO Babel and Obfuscator tool. 
ECHO. 
ECHO Packing Proccess Includes 2 major steps :
ECHO 	- compiling Javascript File using Babel ...
ECHO 	- obfuscating Compiled File using Obfuscator ...
ECHO.
ECHO before using this tool you have to 
ECHO install babel-cli, babel-preset-env and javascript-obfuscator.
ECHO.
ECHO How Babel :
ECHO ===========
ECHO.
ECHO 	- Create a Folder for Your Project and Go Inside.
ECHO 	- Create your Modern Javascript Files.
ECHO 	- run 'npm init' for creating a 'package.json' file.
ECHO 	- run 'npm install --save-dev babel-cli' command to install 'babel-cli' package.
ECHO 	- run 'npm install babel-preset-env --save-dev' command to install 'env' preset package.
ECHO 	- now you can easily compile your modern javascript files using following syntax :
ECHO.	
ECHO 		^> npx babel [your_modern_javascript_file.js] [--out-file [the_compiled_file.js]] [--presets=env]
ECHO.
ECHO 	for example:
ECHO 	------------
ECHO.
ECHO 	^> npx babel BaseWidget.js --out-file BaseWidget.Babel.js --presets=env
ECHO.
ECHO 	descrition:
ECHO 	-----------
ECHO 	above example going to find BaseWidget.js file and compile it into old js structure and put final
ECHO 	code in BaseWidget.Babel.js file in current folder. 
ECHO.
ECHO How To Obfuscator :
ECHO ===================
ECHO.
ECHO 	- Create a Folder for Your Project & Go Inside.
ECHO 	- Create your Javascript Files.
ECHO 	- run 'npm install --save-dev javascript-obfuscator' for installing tool or 'npm i -g javascript-obfuscator'.
ECHO 	- now you can easily obfuscate your javascript files using following syntax :
ECHO.
ECHO 	^> javascript-obfuscator [input_file_name.js] [--output [output_file_name.js]] [options]
ECHO.
ECHO Options :
ECHO =========
ECHO.
ECHO 	--compact ^<boolean^>
ECHO 	--config ^<string^>
ECHO 	--control-flow-flattening ^<boolean^>
ECHO 	--control-flow-flattening-threshold ^<number^>
ECHO 	--dead-code-injection ^<boolean^>
ECHO 	--dead-code-injection-threshold ^<number^>
ECHO 	--debug-protection ^<boolean^>
ECHO 	--debug-protection-interval ^<boolean^>
ECHO 	--disable-console-output ^<boolean^>
ECHO 	--domain-lock '^<list^>' (comma separated)
ECHO 	--exclude '^<list^>' (comma separated)
ECHO 	--identifier-names-generator ^<string^> [hexadecimal, mangled]
ECHO 	--identifiers-prefix ^<string^>
ECHO 	--log ^<boolean^>
ECHO 	--rename-globals ^<boolean^>
ECHO 	--reserved-names '^<list^>' (comma separated)
ECHO 	--reserved-strings '^<list^>' (comma separated)
ECHO 	--rotate-string-array ^<boolean^>
ECHO 	--seed ^<number^>
ECHO 	--self-defending ^<boolean^>
ECHO 	--source-map ^<boolean^>
ECHO 	--source-map-base-url ^<string^>
ECHO 	--source-map-file-name ^<string^>
ECHO 	--source-map-mode ^<string^> [inline, separate]
ECHO 	--string-array ^<boolean^>
ECHO 	--string-array-encoding ^<boolean^|string^> [true, false, base64, rc4]
ECHO 	--string-array-threshold ^<number^>
ECHO 	--target ^<string^> [browser, browser-no-eval, node]
ECHO 	--transform-object-keys ^<boolean^>
ECHO 	--unicode-escape-sequence ^<boolean^>
ECHO.
ECHO for reviewing each options job see 'https://obfuscator.io/'.
ECHO.
ECHO 	for example:
ECHO 	------------
ECHO 		^> javascript-obfuscator BaseWidget.Babel.js 
ECHO 					--output BaseWidget.Obf.js 
ECHO 					--compact true 
ECHO 					--identifier-names-generator mangled 
ECHO 					--dead-code-injection true 
ECHO 					--dead-code-injection-threshold 0.4 
ECHO 					--string-array true 
ECHO 					--rotate-string-array true
ECHO 					--string-array-encoding base64
ECHO 					--string-array-threshold 0.8 
ECHO 					--unicode-escape-sequence true 
ECHO 					--disable-console-output true 
ECHO 					--debug-protection true 
ECHO 					--debug-protection-interval true 
ECHO 					--source-map true --source-map-mode inline 
ECHO 					--seed 0 
ECHO 					--target browser
ECHO.
ECHO 	description:
ECHO 	------------
ECHO 	above example going to completely missundrestandable, uglified and obfuscated BaseWidget.Babel.js 
ECHO 	file content and put final code into BaseWidget.Obf.js file.
ECHO.
ECHO.
ECHO Reference
ECHO ----------
ECHO 	https://babeljs.io/
ECHO 	https://obfuscator.io/
ECHO.
ECHO Contact Info
ECHO -------------
ECHO 	Author: Hadi Khazaee Asl
ECHO 	Email: Hadi_Khazaee_asl@yahoo.com
ECHO.
ECHO Donate
ECHO -------
ECHO 	- Bitcoin: 1Nfm5ZYXXfUZk4pzDN7KzZBFnuxDNUMvKo
ECHO.

GOTO end








@rem a Handler which calls when user input invalid args ...
:invalidArgs
ECHO.
ECHO SaherElm IT Center Packer Tool  
ECHO --------------------------------
ECHO.
ECHO Invalid Args ...
GOTO showHelpAndEndError


@rem Calls When Input File Doesn't Exists ...
:inputFileNotFound
ECHO.
ECHO input file doesn't exists ...
GOTO showHelpAndEndError


@rem if inputFile and output file are same file ...
:sameFileError
ECHO.
ECHO SaherElm IT Center Packer Tool 
ECHO --------------------------------
ECHO.
ECHO Enter Same File as input and output File name ...
GOTO showHelpAndEndError








@rem a Handler which shown help param and end execute with success code ...
:showHelpAndEndFinish
ECHO. 
ECHO.for review usage of this tool using -h
ECHO.
GOTO end


@rem a Handler which shown help param and end execute with error code ...
:showHelpAndEndError
ECHO. 
ECHO.for review usage of this tool using -h
ECHO.
GOTO endError









@rem end of Application ...
:end
EXIT /B 0

@rem End if an Error Happens ... 
:endError
EXIT /B 1
