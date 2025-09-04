function matriz()

    Ab = input('');
    [n, m] = size(Ab);
    A = Ab(:,1:m-1);
    b = Ab(:,m);
    P = eye(n);      
    L = eye(n);      
    U = A;

    [U,L,P,num_trocas] = escalona_gauss_lu(U,L,P);

    Pb = P*b;
    y = zeros(n,1);
    for i = 1:n
        y(i) = Pb(i) - L(i,1:i-1)*y(1:i-1);
    end

    x = solucao(U, y);
    
    detA = determinante_LU(U,num_trocas);
    invA = inversa_LU(L, U, P);

    L = aproximar(L);
    U = aproximar(U);
    P = aproximar(P);
    x = aproximar(x);
    detA = aproximar(detA);
    invA = aproximar(invA);

    format short
    disp(L)
    disp(U)
    disp(P)
    disp(x)
    disp(detA)
    disp(invA)

end

function [U,L,P,num_trocas] = escalona_gauss_lu(U,L,P)
    n = size(U,1);
    num_trocas = 0;  % contador de trocas
    for k = 1:n-1
        [val, idx] = max(abs(U(k:n,k)));
        idx = idx + k - 1;

        if val == 0
            continue;
        end

        if idx ~= k
            % Troca linhas em U
            temp = U(k,:);
            U(k,:) = U(idx,:);
            U(idx,:) = temp;
            
            % Troca linhas em P
            temp = P(k,:);
            P(k,:) = P(idx,:);
            P(idx,:) = temp;

            if k > 1
                temp = L(k,1:k-1);
                L(k,1:k-1) = L(idx,1:k-1);
                L(idx,1:k-1) = temp;
            end

            num_trocas = num_trocas + 1; % conta a troca
        end

        for i = k+1:n
            if U(i,k) ~= 0
                fator = U(i,k)/U(k,k);
                L(i,k) = fator;
                U(i,:) = U(i,:) - fator*U(k,:);
            end
            U(i,k) = 0;
        end
    end
end

function x = solucao(U, y)
    n = length(y);
    x = zeros(n,1);
    for i = n:-1:1
        x(i) = (y(i) - U(i,i+1:n)*x(i+1:n))/U(i,i);
    end
end

function invA = inversa_LU(L,U,P)
    n = size(L,1);
    invA = zeros(n);
    I = eye(n);

    for j = 1:n
        e = I(:,j);           
        y = zeros(n,1);
        Pb = P*e;
        for i = 1:n
            y(i) = Pb(i) - L(i,1:i-1)*y(1:i-1);
        end
        
        x = zeros(n,1);
        for i = n:-1:1
            x(i) = (y(i) - U(i,i+1:n)*x(i+1:n))/U(i,i);
        end

        invA(:,j) = x;
    end
end

function x = aproximar(a)
    x =  round(a .* 10) ./ 10;
end

function detA = determinante_LU(U,num_trocas)
    n = size(U,1);
    prodU = 1;
    for i = 1:n
        prodU = prodU * U(i,i);
    end
    detA = (-1)^num_trocas * prodU;  % agora correto
end
matriz()
