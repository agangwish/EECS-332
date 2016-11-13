figure;
imshow(MorphologicalOperators('palm.bmp', 'b', 'c'));
imwrite(MorphologicalOperators('palm.bmp', 'b', 'c'), 'p_c.png');
figure;
imshow(MorphologicalOperators('palm.bmp', 'b', ''));
imwrite(MorphologicalOperators('palm.bmp', 'b', ''), 'p.png');
figure;
imshow(MorphologicalOperators('palm.bmp', 'b', 'l'));
imwrite(MorphologicalOperators('palm.bmp', 'b', 'l'), 'p_l.png');