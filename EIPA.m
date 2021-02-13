nx = 50;
ny = 50;
V = zeros(nx, ny);
G = sparse(nx*ny, nx*ny);

for i = 1:nx
    for j = 1:ny
        n = j+(i-1)*ny;
        nxm = j+(i-2)*ny;
        nxp = j+i*ny;
        nym = (j-1)+(i-1)*ny;
        nyp = (j+1)+(i-1)*ny;
        
        %Boundary Condition
        if i == 1 || i == nx
            G(n,:) = 0;
            G(n,n) = 1;
        elseif j == 1 || j == ny
            G(n,:) = 0;
            G(n,n) = 1;
        elseif (i < 20) && (i > 10) && (j < 20) && (j > 10)
            G(n,n) = -2;
            G(n,nxm) = 1;
            G(n,nxp) = 1;
            G(n,nym) = 1;
            G(n,nyp) = 1;
        else
            G(n,n) = -4;
            G(n,nxm) = 1;
            G(n,nxp) = 1;
            G(n,nym) = 1;
            G(n,nyp) = 1;
        end
    end
end

figure('name', 'Matrix')
spy(G)

nmodes = 9;
[E,D] = eigs(G,nmodes,'SM');

figure('name', 'EigenValues')
plot(diag(D), '*');

np = ceil(sqrt(nmodes));
figure('name', 'Modes')
for k = 1:nmodes
    M = E(:,k);
    for i = 1:nx
        for j = 1:ny
            n = i+(j-1)*nx;
            V(i,j) = M(n);
        end
        subplot(np,np,k), surf(V, 'linestyle', 'none')
        title(['EV = ' num2str(D(k,k))])
    end
end