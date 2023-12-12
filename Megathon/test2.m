img = imread("C:\Users\Lenovo\OneDrive - International Institute of Information Technology\Pictures\Screenshots\Green.png");

hsvImg = rgb2hsv(img);
hue = hsvImg(:,:,1);

numBins = 256;
histogramData = hist(hue(:), numBins);
histogramData = histogramData / sum(histogramData);

colormapHSV = hsv(numBins);
bar(histogramData, 'FaceColor', 'flat', 'CData', colormapHSV);
title('Color Frequencies in the Image');
xlabel('Hue Value');
ylabel('Frequency');