SaherElm IT Center Packer Tool
===============================

Help
------

usage syntax :

        Packer inputFile [outputBabelFile] [outputObfFile] [-h]

Note
-----

this tools help to increase the speed of
Packing Javascript Codes using
Babel and Obfuscator tool.

Packing Proccess Includes 2 major steps :
        - compiling Javascript File using Babel ...
        - obfuscating Compiled File using Obfuscator ...

before using this tool you have to
install babel-cli, babel-preset-env and javascript-obfuscator.

How To Babel
-----------

        - Create a Folder for Your Project and Go Inside.
        - Create your Modern Javascript Files.
        - run 'npm init' for creating a 'package.json' file.
        - run 'npm install --save-dev babel-cli' command to install 'babel-cli' package.
        - run 'npm install babel-preset-env --save-dev' command to install 'env' preset package.
        - now you can easily compile your modern javascript files using following syntax :

                > npx babel [your_modern_javascript_file.js] [--out-file [the_compiled_file.js]] [--presets=env]

        for example:
        ------------

        > npx babel BaseWidget.js --out-file BaseWidget.Babel.js --presets=env

        descrition:
        -----------
        above example going to find BaseWidget.js file and compile it into old js structure and put final
        code in BaseWidget.Babel.js file in current folder.

How To Obfuscator
--------------------

        - Create a Folder for Your Project
'Go' is not recognized as an internal or external command,
operable program or batch file.
        - Create your Javascript Files.
        - run 'npm install --save-dev javascript-obfuscator' for installing tool or 'npm i -g javascript-obfuscator'.
        - now you can easily obfuscate your javascript files using following syntax :

        > javascript-obfuscator [input_file_name.js] [--output [output_file_name.js]] [options]

Options
----------

        --compact <boolean>
        --config <string>
        --control-flow-flattening <boolean>
        --control-flow-flattening-threshold <number>
        --dead-code-injection <boolean>
        --dead-code-injection-threshold <number>
        --debug-protection <boolean>
        --debug-protection-interval <boolean>
        --disable-console-output <boolean>
        --domain-lock '<list>' (comma separated)
        --exclude '<list>' (comma separated)
        --identifier-names-generator <string> [hexadecimal, mangled]
        --identifiers-prefix <string>
        --log <boolean>
        --rename-globals <boolean>
        --reserved-names '<list>' (comma separated)
        --reserved-strings '<list>' (comma separated)
        --rotate-string-array <boolean>
        --seed <number>
        --self-defending <boolean>
        --source-map <boolean>
        --source-map-base-url <string>
        --source-map-file-name <string>
        --source-map-mode <string> [inline, separate]
        --string-array <boolean>
        --string-array-encoding <boolean|string> [true, false, base64, rc4]
        --string-array-threshold <number>
        --target <string> [browser, browser-no-eval, node]
        --transform-object-keys <boolean>
        --unicode-escape-sequence <boolean>

for reviewing each options job see 'https://obfuscator.io/'.

        for example:
        ------------
                > javascript-obfuscator BaseWidget.Babel.js
                                        --output BaseWidget.Obf.js
                                        --compact true
                                        --identifier-names-generator mangled
                                        --dead-code-injection true
                                        --dead-code-injection-threshold 0.4
                                        --string-array true
                                        --rotate-string-array true
                                        --string-array-encoding base64
                                        --string-array-threshold 0.8
                                        --unicode-escape-sequence true
                                        --disable-console-output true
                                        --debug-protection true
                                        --debug-protection-interval true
                                        --source-map true --source-map-mode inline
                                        --seed 0
                                        --target browser

        description:
        ------------
        above example going to completely missundrestandable, uglified and obfuscated BaseWidget.Babel.js
        file content and put final code into BaseWidget.Obf.js file.

Reference
----------

- https://babeljs.io/
- https://obfuscator.io/

Contact Info
-----------

- Author: Hadi Khazaee Asl
- Email: Hadi_Khazaee_asl@yahoo.com

Donate
-------

    - Bitcoin: 1Nfm5ZYXXfUZk4pzDN7KzZBFnuxDNUMvKo