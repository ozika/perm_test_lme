function [s_error] = stderror(data)
%[row, col] = find(isnan(data));
%data(row, :)=[];
if size(data,2) ~= 1 && size(data,1) ~= 1
    for i = 1:size(data,2)
        d = data(:,i);
        s_error(i) = std(d, 'omitnan')/sqrt(length(d(~isnan(d))));
    end
else
    s_error = std(data, 'omitnan')/sqrt(length(data(~isnan(data))));
end


end

