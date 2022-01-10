function g3 = s2p(g,npts,hmin,hmax,dh,tt,x,y,nx,ny,dx,iter)
hmax = hmax-hmin;
hmin = hmin-hmin;
nh = (hmax-hmin)/dh+1;
h = hmin:dh:hmax;
[X,Y] = meshgrid(x,y);
[X3,Y3,Z3] = meshgrid(x,y,h);
g1 = g;
for j = 1:iter
    gg(:,:,1) = g1;
    for i = 2:nh
       	h = hmin+(i-1)*dh;
    	gu = upcon(g1,npts,nx,ny,dx,-h);
        gg(:,:,i) = gu;
    end
    g2 = interp3(X3,Y3,Z3,gg,X,Y,tt);
    g4 = g-g2;
    g3 = g1+tt.^1.5.*g4; 
    g1 = g3;
end