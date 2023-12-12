R = 0;
G = 255;
B = 0;

rectWidth = 100;
rectHeight = 100;

greenColor = uint8(cat(3, R * ones(rectHeight, rectWidth), G * ones(rectHeight, rectWidth), B * ones(rectHeight, rectWidth)));

imshow(greenColor);
