for i=1:10
    file1 = strcat('words/vw', int2str(i), '.wav');
    file2 = strcat('words/ggw', int2str(i), '.wav');
    [aw_dtw, gw_dtw, f] = kultmatter(file1, file2);
    size(aw_dtw)
    wavwrite(aw_dtw, f, strcat('words/vw_dtw', int2str(i),'.wav'));
    wavwrite(gw_dtw, f, strcat('words/ggw_dtw', int2str(i), '.wav'));
end