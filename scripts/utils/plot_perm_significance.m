function [] = plot_perm_significance(P, eff, yl, col, op)
disp(['plotting significant clusters for effect: ' P{eff}.name]);
sigCl = P{eff}.clusters(P{eff}.clusters(:,3)==1,:);

for cl = 1:size(sigCl,1)
    [off1, off2] = deal(0.5);
    if cl == 1; off1 = 0; end
    if cl == size(sigCl,1); off2 = 0; end
    xo = sigCl(cl,4)-off1:0.1:sigCl(cl,5)-off2;
    shade_area_bet_curves(xo, repmat(yl(1), 1, length(xo)), repmat(yl(2), 1, length(xo)), col, op);
end

