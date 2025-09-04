x = input('');
n = input('');

total = x * 3;  % transforma tudo em "terços"
for i = 1:n
    total = total + 1;  % soma 1/3 como 1 unidade de "terço"
    if mod(total, 3) == 0  % se for múltiplo de 3, é inteiro
        disp(int16(total / 3));
    end
end
