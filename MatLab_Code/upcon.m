function up=upcon(data,npts,nx,ny,dx,h)
xdiff=floor((npts-nx)/2); ydiff=floor((npts-ny)/2);
data1=taper2d(data,npts,ny,nx,ydiff,xdiff);
f=fft2(data1); fz=f;
wn=2.0*pi/(dx*(npts-1));
f=fftshift(f);
cx=npts/2+1; cy=cx;
for I=1:npts
    ky=(I-cy)*wn;
    for J=1:npts
        kx=(J-cx)*wn;
        k=sqrt(kx*kx+ky*ky);
        k=exp(h*k);
        fz(I,J)=f(I,J)*k;
    end
end
fz=fftshift(fz); fzinv=ifft2(fz);
up=real(fzinv(1+ydiff:ny+ydiff,1+xdiff:nx+xdiff));
