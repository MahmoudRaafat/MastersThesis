function out=privatizeImage(I, rows, columns);

F=fft2(I);
F2=fftshift(F);
y = [rows, columns];
x = 1;
noisyFreqCount = 1500;
array = randl(2, noisyFreqCount);
%normalize
for i = 1:2
m = min(array(i, :));
range = max(array(i, :)) - m;
array(i, :) = (array(i, :) - m) / range;

% Then scale to [x,y]:
range2 = y(i) - x;
normalized(i, :) = (array(i, :)*range2) + x;
end

normalized = round(normalized);
for i = 1: noisyFreqCount
    row = normalized(1,i);
    column = normalized(2,i);
    %noise = rand(1);
    noise = 0.8;
    if (column ~= 1 && row ~= 1)
        F2(row, column) = noise * F2(row, column);
        F2(rows+2-row, columns+2-column) = noise * F2(rows+2 - row, columns+2-column);
    end
end

z = ifft2(ifftshift(F2));
noisyFace = uint8(z);
out = noisyFace;
%figure, imshow(noisyFace);

%figure,imshow(log(1+abs(F2)),[])
%mesh(log(1+abs(F2)))


