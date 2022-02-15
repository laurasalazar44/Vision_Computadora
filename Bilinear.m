function Bilinear(original_image, k)
    [row, col, d] = size(original_image);
    new_row= floor(k*row);
    new_col = floor(k*col);
    s = k;
    new_image= zeros(new_row, new_col, d);
    for i=1:new_row
        x_1 = cast(floor(i/s), 'uint32');
        x_2 = cast(ceil(i/s), 'uint32');
        if x_1 == 0
            x_1 = 1;
        end
        x_1 = rem(i/s, 1);
        for j = 1:new_col
            y_1 = cast(floor(j/s), 'uint32');
            y_2 = cast(ceil(j/s), 'uint32');
            if y_1==0
                y_1 = 1;
            end
            ctl = original_image(x_1,y_1, :);
            ctr = original_image(x_1,y_2, :);
            cbl = original_image(x_2,y_1, :);
            cbr = original_image(x_2,y_2, :);
            y = rem(j/s, 1);
            t = (ctr*y)+(ctl*(1-y));
            b = (cbr*y)+(cbl*(1-y));
            new_image(i,j,:)= (b*x)+(t*(1-x))
        end
    end
    new_image1 = cast(new_image, 'uint8')
    figure,subplot(121),imshow(original_image);title('BEFORE INTERPOLATION'); axis([0,max(k*col, col),0,max(k*row, row)]);axis on;
    subplot(122),imshow(new_image1);title('AFTER INTERPOLATION');  axis([0,max(k*col, col),0,max(k*row, row)]);axis on;
end