%% Data set 1
nosubs = 10;
notimepoitns = 5;
reps = 10;
sub_means = 75+randi(25,nosubs,1);
cond_effs = [-10 -1 20 21];
dv = repmat(reshape(sub_means+cond_effs, nosubs*4,1)+rand(nosubs*length(cond_effs),1)*15, reps,1);
for i = 2:notimepoitns
    dv = [dv dv(:,i-1)+8*randn(nosubs*length(cond_effs)*reps,1)] ;
end
iv = repmat([[repmat([1:nosubs]',4,1)],[repmat(1, nosubs*2,1); repmat(2, nosubs*2,1)], repmat([repmat(1, nosubs,1); repmat(2, nosubs,1)] ,2,1)], reps,1);
iv = array2table(iv, 'VariableNames', {'id', 'bgcol', 'congruency'});
iv.congruency =categorical(iv.congruency);
iv.bgcol =categorical(iv.bgcol);
iv.id =categorical(iv.id);

[GS, Gkey, S, Skey, mle] = get_stats(iv, dv, {'bgcol', 'congruency'});
map = colormap('jet');

col4  = [map(2,:) ; map(12,:); map(43,:); map(47,:)];


f=figure;
for cn = 1:2
    for bg = 1:2
        idx = (bg-1)*2+cn;
       gme = GS(Gkey.bgcol==num2str(bg) & Gkey.congruency == num2str(cn),:,1);
       gse = GS(Gkey.bgcol==num2str(bg) & Gkey.congruency == num2str(cn),:,2);
       plot(1:numel(gme), gme, 'LineWidth', 2, 'Color', col4(idx,:));
       hold on 
       shade_area_bet_curves(1:numel(gme), gme-gse, gme+gse, col4(idx,:), 0.2);

    end
end
t=gca; t.XTick = 1:notimepoitns;
legend({'low cong - low bgcol','low cong - high bgcol', 'hi cong - low bgcol','hi cong - high bgcol'},  'location', 'best');
ylabel('pupil dilation (a.u.)')
xlabel('timepoint (s)');

%save('../data/dataset1.mat', 'dv', 'iv');

    

