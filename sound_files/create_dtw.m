for i=1:50
    file1 = strcat('words/aaaw', int2str(i), '.wav');
    file2 = strcat('words/gggw', int2str(i), '.wav');
    [aw_dtw, gw_dtw, f] = kultmatter(file1, file2);
    size(aw_dtw)
    wavwrite(aw_dtw, f, strcat('words/aaaw_dtw', int2str(i),'.wav'));
    wavwrite(gw_dtw, f, strcat('words/gggw_dtw', int2str(i), '.wav'));
end