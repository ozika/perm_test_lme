function [GS, Gkey, S, Skey, mle] = get_stats(varargin)
    %%% Careful, the ORDER of output may differ from input, so any
    %%% individual difference analyses have to be cross-referreences via ID
    mle =[];
    
    data = varargin{1};
    dv   = varargin{2};
    vars = varargin{3};
    if length(varargin)>3
        eq = varargin{4};
    end
    
    mestat = @(x)[nanmean(x,1) stderror(x)];

    firstlvl_vars = [{'id'}, vars];

    % first level
    [g, Skey] = findgroups(data(:,firstlvl_vars)); 
    for i = 1:size(dv,2)
        [S(:,i) ]=[splitapply(@nanmean, dv(:,i), g)];
    end

    % second level
    if size(S,2) == 1
        [G, Gkey] = findgroups(Skey(:, vars));
        [GS]=[splitapply(mestat, S(:,1), G)];
    elseif size(S,2) > 1
        [G, Gkey] = findgroups(Skey(:, vars));
        for i = 1:size(S,2)
            [GS(:,i,1)]=[splitapply(@nanmean, S(:,i), G)];
            [GS(:,i,2)]=[splitapply(@stderror, S(:,i), G)];
        end
    end
    
    
    if length(varargin)>3
        % run mle model 
        mle = fitlme(data, eq);
    end


end

