function B = modelcov(backgrd)
B = zeros(912,912);
lx = 19;
ly = 48;
fm = .5;
em = .1;
N = 3; %the size of the 'box' used to compute exponentially decaying spatial correlation between background values.
for i=1:912
    for j=i:912
        ix = floor(i/48);
        iy = i - ix*48;
        if ix == 0
            ix = ix + 1;
        end
        if iy == 0
            iy = iy + 48;
        end
        jx = floor(j/48);
        jy = j - jx*48;
        if jx == 0
            jx = jx + 1;
        end
        if jy == 0
            jy = jy + 48;
        end
        dx=abs(ix-jx);
        dy=abs(iy-jy);
        if dx < N && dy < N
          B(i,j) = exp(-dx^2/lx^2/2-dy^2/ly^2/2);
            B(i,j)=B(i,j)*(backgrd(i)*fm+em)*(backgrd(j)*fm+em);
        else
           B(i,j) = 0;
        end
        B(j,i) = B(i,j);
    end
end