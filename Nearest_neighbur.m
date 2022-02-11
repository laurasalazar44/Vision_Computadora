function Nearest_neighbur(original_image, k)
    [row, col] = size(original_image);
    for i=1:k*row
        for j= 1:k*col
            new_row = round((i-1)*(row-1)/(k*row-1)+1);
            new_col = round((j-1)*(col-1)/(k*col-1)+1);
            new_image(i,j) = original_image(new_row, new_col);
        end
    end
    figure,subplot(121),imshow(original_image);title('BEFORE INTERPOLATION'); axis([0,k*col,0,k*row]);axis on;
    subplot(122),imshow(new_image);title('AFTER INTERPOLATION');  axis([0,k*col,0,k*row]);axis on;
end

