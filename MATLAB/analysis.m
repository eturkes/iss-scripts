%    This file is part of iss-microglia.
%    Copyright (C) 2020  Emir Turkes, Sebastiaan De Schepper, UK DRI at UCL
%
%    This program is free software: you can redistribute it and/or modify
%    it under the terms of the GNU General Public License as published by
%    the Free Software Foundation, either version 3 of the License, or
%    (at your option) any later version.
%
%    This program is distributed in the hope that it will be useful,
%    but WITHOUT ANY WARRANTY; without even the implied warranty of
%    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%    GNU General Public License for more details.
%
%    You should have received a copy of the GNU General Public License
%    along with this program.  If not, see <http://www.gnu.org/licenses/>.
%
%    Emir Turkes can be contacted at emir.turkes@eturkes.com

%% Prep Data
load(fullfile('results', 'data', 'o.mat'));
Roi = round([1, max(o.SpotGlobalYX(:,2)), 1, max(o.SpotGlobalYX(:,1))]);

%% Plot All Spots
o.plot(o.BigDapiFile, Roi, 'Pixel');
caxis([0,25000]);
set(gca, 'YDir', 'reverse');
set(gca, 'XDir', 'reverse');

iss_change_plot(o,'Pixel');
saveas(gcf, fullfile('results', 'figures', 'allgenes', 'all'), 'png');
iss_change_plot_allgenes_MG(o,'Pixel');
saveas(gcf, fullfile('results', 'figures', 'allgenes', 'MG'), 'png');
iss_change_plot_allgenes_MG2(o,'Pixel');
saveas(gcf, fullfile('results', 'figures', 'allgenes', 'MG2'), 'png');
iss_change_plot_allgenes_MG3(o,'Pixel');
saveas(gcf, fullfile('results', 'figures', 'allgenes', 'MG3'), 'png');

%% All Spots Clusters
SpotSetClustered = get_gene_clusters(o, 'Pixel');

iss_change_plot(o, 'Pixel', o.GeneNames, SpotSetClustered);
saveas(gcf, fullfile('results', 'figures', 'allgenes', 'clusters', 'all'), 'png');
iss_change_plot_allgenes_MG(o, 'Pixel', o.GeneNames, SpotSetClustered);
saveas(gcf, fullfile('results', 'figures', 'allgenes', 'clusters', 'MG'), 'png');
iss_change_plot_allgenes_MG2(o, 'Pixel', o.GeneNames, SpotSetClustered);
saveas(gcf, fullfile('results', 'figures', 'allgenes', 'clusters', 'MG2'), 'png');
iss_change_plot_allgenes_MG3(o, 'Pixel', o.GeneNames, SpotSetClustered);
saveas(gcf, fullfile('results', 'figures', 'allgenes', 'clusters', 'MG3'), 'png');

%% MG genes
% Read in codebook.
%%%%%%%%%%%%%%%%%%%
fp = fopen(fullfile('assets', 'codebooks', 'codebook_Seppe.txt'), 'r');
tmp = textscan(fp, '%s %s', inf);
GeneNamesMG = tmp{1};
fclose(fp);
%%%%%%%%%%%%%%%%%%%

GeneNamesMGFilt = GeneNamesMG([4:6,8,9,13,14,20]); % MG specific genes.
GeneNamesMGFilt2 = setdiff(GeneNamesMG, GeneNamesMGFilt); % Non-specific MG genes.

iss_change_plot_allgenes_MG3(o,'Pixel', GeneNamesMG);
saveas(gcf, fullfile('results', 'figures', 'MG', 'all'), 'svg');

iss_change_plot_MG(o,'Pixel', GeneNamesMG);
saveas(gcf, fullfile('results', 'figures', 'MG', 'MG', 'all'), 'svg');
iss_change_plot_MG(o,'Pixel', GeneNamesMGFilt);
saveas(gcf, fullfile('results', 'figures', 'MG', 'MG', 'specific'), 'svg');
iss_change_plot_MG(o,'Pixel', GeneNamesMGFilt2);
saveas(gcf, fullfile('results', 'figures', 'MG', 'MG', 'non-specific'), 'svg');

iss_change_plot_MG2(o,'Pixel', GeneNamesMG);
saveas(gcf, fullfile('results', 'figures', 'MG', 'MG2', 'all'), 'svg');
iss_change_plot_MG2(o,'Pixel', GeneNamesMGFilt);
saveas(gcf, fullfile('results', 'figures', 'MG', 'MG2', 'specific'), 'svg');
iss_change_plot_MG2(o,'Pixel', GeneNamesMGFilt2);
saveas(gcf, fullfile('results', 'figures', 'MG', 'MG2', 'non-specific'), 'svg');

iss_change_plot_MG3(o,'Pixel', GeneNamesMG);
saveas(gcf, fullfile('results', 'figures', 'MG', 'MG3', 'all'), 'svg');
iss_change_plot_MG3(o,'Pixel', GeneNamesMGFilt);
saveas(gcf, fullfile('results', 'figures', 'MG', 'MG3', 'specific'), 'svg');
iss_change_plot_MG3(o,'Pixel', GeneNamesMGFilt2);
saveas(gcf, fullfile('results', 'figures', 'MG', 'MG3', 'non-specific'), 'svg');

%% MG Clusters
spot_no = find(ismember(o.GeneNames, GeneNamesMG));
spots_to_cluster = o.quality_threshold('Pixel') & ismember(o.pxSpotCodeNo, spot_no);
k = [2;3;5;10;15;25;50];

for i = 1:length(k)
    SpotSetClustered = get_gene_clusters(o, 'Pixel', 75, k(i), spots_to_cluster);

    iss_change_plot_MG(o, 'Pixel', GeneNamesMG, SpotSetClustered);
    saveas(gcf, fullfile('results', 'figures', 'MG', 'MG', 'all', 'clusters', ...
        strcat('k', num2str(k(i)))), 'svg');
    iss_change_plot_MG2(o, 'Pixel', GeneNamesMG, SpotSetClustered);
    saveas(gcf, fullfile('results', 'figures', 'MG', 'MG2', 'all', 'clusters', ...
        strcat('k', num2str(k(i)))), 'svg');
    iss_change_plot_MG3(o, 'Pixel', GeneNamesMG, SpotSetClustered);
    saveas(gcf, fullfile('results', 'figures', 'MG', 'MG3', 'all', 'clusters', ...
        strcat('k', num2str(k(i)))), 'svg');
end

spots_to_cluster = find(ismember(o.GeneNames, GeneNamesMGFilt));
spots_to_cluster = o.quality_threshold('Pixel') & ismember(o.pxSpotCodeNo, spots_to_cluster);
k = [2;3;5;10;15];

for i = 1:length(k)
    SpotSetClustered = get_gene_clusters(o, 'Pixel', 75, k(i), spots_to_cluster);

    iss_change_plot_MG(o, 'Pixel', GeneNamesMG, SpotSetClustered);
    saveas(gcf, fullfile('results', 'figures', 'MG', 'MG', 'specific', 'clusters', ...
        strcat('k', num2str(k(i)))), 'svg');
    iss_change_plot_MG2(o, 'Pixel', GeneNamesMG, SpotSetClustered);
    saveas(gcf, fullfile('results', 'figures', 'MG', 'MG2', 'specific', 'clusters', ...
        strcat('k', num2str(k(i)))), 'svg');
    iss_change_plot_MG3(o, 'Pixel', GeneNamesMG, SpotSetClustered);
    saveas(gcf, fullfile('results', 'figures', 'MG', 'MG3', 'specific', 'clusters', ...
        strcat('k', num2str(k(i)))), 'svg');
end

spots_to_cluster = find(ismember(o.GeneNames, GeneNamesMGFilt2));
spots_to_cluster = o.quality_threshold('Pixel') & ismember(o.pxSpotCodeNo, spots_to_cluster);
k = [2;3;5;10;15;25;50];

for i = 1:length(k)
    SpotSetClustered = get_gene_clusters(o, 'Pixel', 75, k(i), spots_to_cluster);

    iss_change_plot_MG(o, 'Pixel', GeneNamesMG, SpotSetClustered);
    saveas(gcf, fullfile('results', 'figures', 'MG', 'MG', 'non-specific', 'clusters', ...
        strcat('k', num2str(k(i)))), 'svg');
    iss_change_plot_MG2(o, 'Pixel', GeneNamesMG, SpotSetClustered);
    saveas(gcf, fullfile('results', 'figures', 'MG', 'MG2', 'non-specific', 'clusters', ...
        strcat('k', num2str(k(i)))), 'svg');
    iss_change_plot_MG3(o, 'Pixel', GeneNamesMG, SpotSetClustered);
    saveas(gcf, fullfile('results', 'figures', 'MG', 'MG3', 'non-specific', 'clusters', ...
        strcat('k', num2str(k(i)))), 'svg');
end

%% Individual Genes
% For all genes.
%%%%%%%%%%%%%%%%
fp = fopen(fullfile('codebook_comb.txt'), 'r');
tmp = textscan(fp, '%s %s', inf);
GeneNamesAll = tmp{1};
fclose(fp);

for i = 1:length(GeneNamesAll)
    iss_change_plot_individual(o, 'Pixel', GeneNamesAll(i));
    saveas(gcf, fullfile('results', 'figures', 'allgenes', 'individual', GeneNamesAll{i}), 'svg');
end
%%%%%%%%%%%%%%%%

% For MG genes.
%%%%%%%%%%%%%%%
for i = 1:length(GeneNamesMG)
    iss_change_plot_individual(o, 'Pixel', GeneNamesMG(i));
    saveas(gcf, fullfile('results', 'figures', 'MG', 'individual', GeneNamesMG{i}), 'svg');
end
%%%%%%%%%%%%%%%

%% Spatial Cross-correlation
genes = {'Synpr', 'Wfs1'};
spot_no = find(ismember(o.GeneNames, genes));
thresh = o.quality_threshold('Pixel') & ismember(o.pxSpotCodeNo, spot_no);

spots = o.pxSpotGlobalYX(thresh,:);
codes = o.pxSpotCodeNo(thresh,:);
subset = size(spots);
rng(1);
subset = randsample(subset(1), subset(1));
sub_spots = spots(subset,:);
sub_codes = codes(subset,:);

SpotSet = o.quality_threshold('Pixel') & ismember(o.pxSpotGlobalYX, sub_spots, 'rows');
iss_change_plot(o, 'Pixel', GeneNamesAll, SpotSet);

genes = 'Synpr';
spot_no = find(ismember(o.GeneNames, genes));
[~, groups] = ismember(sub_codes, spot_no);
groups = groups + 1;
[ccg_out, Pairs, gs, cum_dens, rel_cum_dens, ripley, local_density] = ...
    CCG_2d(sub_spots, groups, 200, 30);

scatter(ccg_out(:,1,1), ccg_out(:,2,1));
hold on;
scatter(ccg_out(:,2,2), ccg_out(:,1,2));

bar(ccg_out(:,1,1));
hold on;
bar(ccg_out(:,2,2));

bar(cum_dens(:,1,1));
hold on;
bar(cum_dens(:,2,2));

bar(rel_cum_dens(:,1,1));
hold on;
bar(rel_cum_dens(:,2,2));

bar(ripley(:,1,1));
hold on;
bar(ripley(:,2,2));

bar(local_density(:,1,1));
hold on;
bar(local_density(:,2,2));

%% Contour Plots
% For all genes.
%%%%%%%%%%%%%%%%
for i = 1:length(GeneNamesAll)
    iss_change_plot_contour(o, 'Pixel', GeneNamesAll(i));
    saveas(gcf, fullfile('results', 'figures', 'contour', 'allgenes', 'individual', ...
        GeneNamesAll{i}), 'svg');
end
%%%%%%%%%%%%%%%%

% For MG genes.
%%%%%%%%%%%%%%%
for i = 1:length(GeneNamesMG)
    iss_change_plot_contour(o, 'Pixel', GeneNamesMG(i));
    saveas(gcf, fullfile('results', 'figures', 'contour', 'MG', 'individual', ...
        GeneNamesMG{i}), 'svg');
end
%%%%%%%%%%%%%%%
