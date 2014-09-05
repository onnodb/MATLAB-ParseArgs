# parseArgs.m / parseClassArgs.m #

These are two small utility functions for parsing function arguments in
MATLAB.

See the corresponding [post on the Writing Better Code](http://www.writingbettercode.nl/blog/cleaning-up-matlab-function-arguments-using-parseargs.html) for an introduction.


## How to use ``parseArgs`` ##

Example code for a function using ``parseArgs`` to provide optional arguments:

    function [age] = calculateAgeOfTheUniverse(grandmaAge, nDinosaurs, varargin)

    args = parseArgs(varargin, struct('nPlanets', 9, 'electronCharge', 1, ...
            'andAnotherArgument', [], 'andAnotherOne', []));

    if args.useGeneralRelativity
        age = age + 1E6 * args.nPlanets;      % not that this makes any sense :)
    end
    
    end
    
Then call the function using, for example:

    >> calculateAgeOfTheUniverse(78, 4E7);
    >> calculateAgeOfTheUniverse(78, 4E7, 'nPlanets', 8)
    >> calculateAgeOfTheUniverse(78, 4E7, 'nPlanets', 8, 'andAnotherOne', 'boo')

You simply pass the ``varargin`` cell array into ``parseArgs``, together with a struct with optional arguments. It returns the input struct, amended with the arguments passed into the function.

Note that argument names are **case insensitive**.


## Flag arguments ##

As a nice little extra, ``parseArgs`` also provides the option of **flag arguments**: arguments that don't need a value, and will just toggle the corresponding default value to ``true``:

	function myFunc(varargin)
	
	args = parseArgs(varargin, struct('doSomething', false), {'doSomething'})
	   % pass a cell array of flag arguments into parseArgs as the 3rd parameters
		
	% Then call the function using:
	>> myFunc()   % it's still optional
	>> myFunc('doSomething')   % "true" assumed
	>> myFunc('doSomething',  true)   % but you can also give it explicitly## Tips & Caveats ##

We personally prefer to format our ``parseArgs`` code the following way. YMMV :-)

    function [age] = calculateAgeOfTheUniverse(grandmaAge, nDinosaurs, varargin)

    defArgs = struct(...
                      'nPlanets',                           9 ...
                    , 'electronCharge',                     1 ...
                    , 'andAnotherArgument',                 [] ...
                    , 'andAnotherOne',                      [] ...
                    , 'useGeneralRelativity',               false ...
                    );
    args = parseArgs(varargin, defArgs, {'useGeneralRelativity'});

Another suggested format would be:

    function [age] = calculateAgeOfTheUniverse(grandmaAge, nDinosaurs, varargin)

    defArgs = struct();
    defArgs.nPlanets             = 9;
    defArgs.electronCharge       = 1;
    defArgs.andAnotherArgument   = [];
    defArgs.andAnotherOne        = [];
    defArgs.useGeneralRelativity = false;

    args = parseArgs(varargin, defArgs, {'useGeneralRelativity'});

If an argument has a cell array as a default value, and you're not using the latter format: be careful. Due to the way the ``struct`` function works, you'll have to use *double* braces:

    defArgs = struct(...
                      'cellArray',              {{1, 'two', [3 3 3]}} ...
                    );


## ``parseClassArgs`` for classes ##

As a bonus, an additional function ``parseClassAgs`` has been included in this repo. It's similar to ``parseArgs``, but applies to class properties instead of function arguments. Note that this one is *case sensitive*.


## License ##

This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.

In jurisdictions that recognize copyright laws, the author or authors
of this software dedicate any and all copyright interest in the
software to the public domain. We make this dedication for the benefit
of the public at large and to the detriment of our heirs and
successors. We intend this dedication to be an overt act of
relinquishment in perpetuity of all present and future rights to this
software under copyright law.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
