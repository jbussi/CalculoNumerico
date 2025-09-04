classdef Racionais
    properties
        num  % numerador
        den  % denominador
    end

    methods
        % Construtor
        function obj = Racionais(n, d)
            if nargin == 0
                n = 0; d = 1;
            elseif d == 0
                error('Denominador não pode ser zero.');
            end

            % Simplificar a fração (usar gcd)
            g = gcd(n, d);
            n = n / g;
            d = d / g;

            % Garantir que o denominador seja positivo
            if d < 0
                n = -n;
                d = -d;
            end

            obj.num = n;
            obj.den = d;
        end

        % Multiplicação
        function r = mtimes(a, b)
            if ~isa(a,  'Racionais')
                a = Racionais(a, 1);
            end
            if ~isa(b,  'Racionais')
                b = Racionais(b, 1);
            end
            r = Racionais(a.num * b.num, a.den * b.den);
        end

        % Divisão
        function r = mrdivide(a, b)
            if ~isa(a,  'Racionais')
                a = Racionais(a, 1);
            end
            if ~isa(b,  'Racionais')
                b = Racionais(b, 1);
            end
            if b.num == 0
                error('Divisão por zero');
            end
            r = Racionais(a.num * b.den, a.den * b.num);
        end

        % Mostrar fração
        function disp(obj)
            fprintf('%d/%d\n', obj.num, obj.den);
        end

        % Soma
        function r = plus(a, b)
            if ~isa(a,  'Racionais')
                a = Racionais(a, 1);
            end
            if ~isa(b,  'Racionais')
                b = Racionais(b, 1);
            end

            % Para somar frações: a/b + c/d = (ad + bc) / bd
            n = a.num * b.den + b.num * a.den;
            d = a.den * b.den;

            r = Racionais(n, d); % O construtor já simplifica
        end

        % Subtração
        function r = minus(a, b)
            if ~isa(a,  'Racionais')
                a = Racionais(a, 1);
            end
            if ~isa(b,  'Racionais')
                b = Racionais(b, 1);
            end

            % Para subtrair frações: a/b - c/d = (ad - bc) / bd
            n = a.num * b.den - b.num * a.den;
            d = a.den * b.den;

            r = Racionais(n, d); % Simplificado
        end
    end
end
%A classe Racionais sempre define uma fração para Racionais(n, d), ex: Racionais(3,2) = 3/2
