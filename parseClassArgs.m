function parseClassArgs(args, obj)
% Helper function for parsing args for class constructors.
%
% This is a variant of the 'parseArgs' function, and can be used to
% automatically set object properties from a set of arguments passed into
% a class constructor.
%
% Note that, in contrast to 'parseArgs', key names are case-sensitive. Also,
% this function automatically detects whether an argument is a flag, by
% reading the current value of the corresponding property: if this is a logical
% scalar, the argument is assumed to be a flag.
%
% INPUT:
% args = 'args' 1xN cell array
% obj = object receiving property values

curArgIdx = 1;
while curArgIdx <= length(args)
    if ischar(args{curArgIdx})
        if ~isprop(obj, args{curArgIdx})
            error('Invalid argument "%s": No property found with that name', args{curArgIdx});
        end

        % Identify flag arguments by the data type of their
        % corresponding property:
        if islogical(obj.(args{curArgIdx})) && isscalar(obj.(args{curArgIdx}))
            if (curArgIdx+1) <= length(args) && islogical(args{curArgIdx+1}) && isscalar(args{curArgIdx+1})
                % Value is given explicitly
                obj.(args{curArgIdx}) = args{curArgIdx+1};
                curArgIdx = curArgIdx + 1;
            else
                % No value given, so turn the flag ON
                obj.(args{curArgIdx}) = true;
            end
        else
            % Non-flag properties: value should be given
            if (curArgIdx+1) <= length(args)
                obj.(args{curArgIdx}) = args{curArgIdx+1};
                curArgIdx = curArgIdx + 1;
            else
                error('Argument error: No value specified for argument "%s"', args{curArgIdx});
            end
        end
    else
        error('Invalid argument at position %d: String expected', curArgIdx);
    end

    curArgIdx = curArgIdx + 1;
end

end

