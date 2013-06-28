function B = modelcovfrac(backgrd)
nr = 912*3;
B = zeros(nr,nr);
lx = 19;
ly = 48;
fm = .5;
em = .1;
N = 3; %the size of the 'box' used to compute exponentially decaying spatial correlation between background values.
for is=1:nr
    for js=1:is
        if rem(is,2) ==1
            i = fix(is/3) + 1;
        elseif rem(is,2) ==1
            i = fix(is/3) + 2;
        else
            i =is/3;
        end
         if rem(js,3) ==1
            j = fix(js/3) + 1;
        elseif rem(js,3) ==1
            j = fix(js/3) + 2;
        else
            j =js/3;
         end
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
          B(is,js) = exp(-dx^2/lx^2/2-dy^2/ly^2/2);
            B(is,js)=B(is,js)*(backgrd(is)*fm+em)*(backgrd(js)*fm+em);
        else
           B(is,js) = 0;
        end
        B(js,is) = B(is,js);
    end
end