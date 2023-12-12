I = imread('main.png');

[row_count, col_count, ~] = size(I);

num_rows = 100;  
num_cols = 105;

block_height = floor(row_count / num_rows);
block_width = floor(col_count / num_cols);

block_averages = zeros(num_rows, num_cols, 3);
stage = cell(num_rows, num_cols);

color_image = zeros(row_count, col_count, 3, 'uint8');


for r = 1:num_rows
    for c = 1:num_cols
        
        row_start = (r - 1) * block_height + 1;
        row_end = r * block_height;
        col_start = (c - 1) * block_width + 1;
        col_end = c * block_width;

        block = I(row_start:row_end, col_start:col_end, :);

        block_avg = mean(mean(double(block), 1), 2);

        block_averages(r, c, :) = block_avg;

        if block_avg(1) >= 150 && block_avg(2) >= 150
            stage{r, c} = 'Young';
            color_image(row_start:row_end, col_start:col_end, 1) = 144; 
            color_image(row_start:row_end, col_start:col_end, 2) = 238; 
            color_image(row_start:row_end, col_start:col_end, 3) = 144;  
        elseif block_avg(1) >= 150 && block_avg(2) <= 150
            stage{r, c} = 'Matured state';
            color_image(row_start:row_end, col_start:col_end, 1) = 255;  
            color_image(row_start:row_end, col_start:col_end, 2) = 255; 
            color_image(row_start:row_end, col_start:col_end, 3) = 0; 
        elseif block_avg(1) < 100 && block_avg(2) >= 100 && block_avg(3) < 100
            stage{r, c} = 'Grown';
            color_image(row_start:row_end, col_start:col_end, 1) = 0;  
            color_image(row_start:row_end, col_start:col_end, 2) = 128;  
            color_image(row_start:row_end, col_start:col_end, 3) = 0;
        elseif block_avg(1) >= 100 && block_avg(2) >= 100 && block_avg(3) <= 100
            stage{r, c} = 'Harvested/Sowing';
            color_image(row_start:row_end, col_start:col_end, 1) = 165; 
            color_image(row_start:row_end, col_start:col_end, 2) = 42;  
            color_image(row_start:row_end, col_start:col_end, 3) = 42;  
        else
            stage{r, c} = 'Grown';
            color_image(row_start:row_end, col_start:col_end, 1) = 0; 
            color_image(row_start:row_end, col_start:col_end, 2) = 128;
            color_image(row_start:row_end, col_start:col_end, 3) = 0;
        end
    end
end

for r = 1:num_rows
    for c = 1:num_cols
        fprintf('Block (%d, %d) - Average RGB: %.2f %.2f %.2f, Stage: %s\n', r, c, block_averages(r, c, 1), block_averages(r, c, 2), block_averages(r, c, 3), stage{r, c});
    end
end

imshow(color_image);