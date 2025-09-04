function gauss_solver()
    format short

    Ab = input('');

    [n, m] = size(Ab);
    if m ~= n+1
        error('A matriz está com formato incorreto');
    end

    A = Ab(:, 1:n);

    Ab_escalonada = escalona_gauss(Ab);

    rankA = rank(A);
    rankAb = rank(Ab);

    tipo = tipo_solucao(Ab_escalonada, A);

    x = [];
    if tipo == 1
        x = solucao(Ab_escalonada);
    end

    disp(Ab_escalonada)
    disp(rankA)
    disp(rankAb)
    disp(tipo)
    if ~isempty(x)
        disp(x)
    end
end

function Ab = escalona_gauss(Ab)
    [n, ~] = size(Ab);

    for k = 1:n
        [val, idx] = max(abs(Ab(k:n, k)));
        idx = idx + k - 1;

        if val == 0
            continue;  
        end

        if idx ~= k
            temp = Ab(k,:);
            Ab(k,:) = Ab(idx,:);
            Ab(idx,:) = temp;
        end

        for i = k+1:n
            if Ab(i,k) ~= 0
                fator = Ab(i,k)/Ab(k,k);
                Ab(i,:) = Ab(i,:) - fator*Ab(k,:);
            end

                Ab(i,k) = 0;
        end
        
    end
    tol = 1e-12;  
    Ab(abs(Ab) < tol) = 0;
end

function tipo = tipo_solucao(Ab, A)
    rankA = rank(A);
    rankAb = rank(Ab);
    [numVariaveis, ~] = size(A);

    if rankA < rankAb 
        tipo = 0;         
    elseif rankA == rankAb && rankA == numVariaveis
        tipo = 1;         
    else
        tipo = 2;        
    end
end

function x = solucao(Ab)
    [n, ~] = size(Ab);
    x = zeros(n,1);

    for i = n:-1:1
        x(i) = (Ab(i,end) - Ab(i,i+1:n)*x(i+1:n)) / Ab(i,i);
    end
end

gauss_solver()