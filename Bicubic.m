function Bicubic(original_image, k)
    [row,col, d] = size(original_image);
    new_row= floor(k*row);
    new_col = floor(k*col);
    s = k;
    new_image= cast(zeros(new_row, new_col, d), 'uint8');
    im = zeros(row+4, col+4, d);
    im(2:row+1, 2:col+1, :) = original_image;
    im = cast(im, 'double');
    for i = 1:new_row
        x_1 = ceil(i/s);
        x_2 = x_1+1;
        x_3 = x_2+1;
        p = cast(x_1, 'uint16');
        if s>1
            m_1 = ceil(s*(x_1-1));
            m_2 = ceil(s*x_1);
            m_3 = ceil(s*x_2);
            m_4 = ceil(s*x_3);
        else
            m_1 = s*(x_1-1);
            m_2 = s*(x_1);
            m_3 = s*(x_2);
            m_4 = s*(x_3);
        end
        X = [(i-m_2)*(i-m_3)*(i-m_4)/((m_1-m_2)*(m_1-m_3)*(m_1-m_4))...
            (i-m_1)*(i-m_3)*(i-m_4)/((m_2-m_1)*(m_2-m_3)*(m_2-m_4))...
            (i-m_1)*(i-m_2)*(i-m_4)/ ((m_3-m_1)*(m_3-m_2)*(m_3-m_4))...
            (i-m_1)*(i-m_2)*(i-m_3)/((m_4-m_1)*(m_4-m_2)*(m_4-m_3))];
        for j = 1:new_col
            y_1 = ceil(j/s);
            y_2 = y_1+1;
            y_3 = y_2 +1;
            if s>1
                n_1 = ceil(s*(y_1-1));
                n_2 = ceil(s*(y_1));
                n_3 = ceil(s*(y_2));
                n_4 = ceil(s*(y_3));
            else
                n_1 = s*(y_1-1);
                n_2 = s*(y_1);
                n_3 = s*(y_2);
                n_4 = s*(y_3);
            end
            Y = [(j-n_2)*(j-n_3)*(j-n_4)/((n_1-n_2)*(n_1-n_3)*(n_1-n_4));...
            (j-n_1)*(j-n_3)*(j-n_4)/((n_2-n_1)*(n_2-n_3)*(n_2-n_4));...
            (j-n_1)*(j-n_2)*(j-n_4)/ ((n_3-n_1)*(n_3-n_2)*(n_3-n_4));...
            (j-n_1)*(j-n_2)*(j-n_3)/((n_4-n_1)*(n_4-n_2)*(n_4-n_3))];
            q = cast(y_1, 'uint16');
            sam = im(p:p+3, q:q+3, :);
            new_image(i,j,1)= X*sam(:,:,1)*Y;
            if d~=1
                new_image(i,j,2)= X.*sam(:,:,2).*Y;
                new_image(i,j,3)= X*sam(:,:,3)*Y;
            end
        end
    end
    new_image = cast(new_image, 'uint8');
    figure,subplot(121),imshow(original_image);title('BEFORE INTERPOLATION'); axis([0,max(k*col, col),0,max(k*row, row)]);axis on;
    subplot(122),imshow(new_image);title('AFTER INTERPOLATION');  axis([0,max(k*col, col),0,max(k*row, row);axis on;
end