function [C_true] = clusterize(sigT_true,T_true)


if sum(sigT_true) > 0
    [cl_logic, cl_starts, cl_end] = deal([]);
    cl_logic = sigT_true(2:end) - sigT_true(1:end-1);
    cl_starts = find(cl_logic==1)+1;
    if sigT_true(1) == 1
        cl_starts = [1 cl_starts];
    end
    cl_end = find(cl_logic==-1)+1;  
    if length(cl_end) < length(cl_starts)
        cl_end = [cl_end length(sigT_true)];
    end
    C_true =[];
    for c = 1:numel(cl_starts)
        %if cl_end(c)-cl_starts(c) < 0
        %    a=1;
        %end
        %try
        C_true = [C_true; [cl_end(c)-cl_starts(c), sum(T_true(cl_starts(c):cl_end(c)-1)), 0, cl_starts(c), cl_end(c)]];
        %catch
        %    a=1;
        %end
    end
else
    C_true =[];

end
end

