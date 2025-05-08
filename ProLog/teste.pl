% -----------------------------------------------------
% Problema das 8 Rainhas usando Backtracking
% -----------------------------------------------------
% A ideia é colocar uma rainha em cada linha do tabuleiro
% de modo que nenhuma ataque a outra.

% -----------------------------------------------------
% Regra principal: soluciona o problema
% -----------------------------------------------------
solucao(Tabuleiro) :-
    length(Tabuleiro, 8),      % Tabuleiro deve ter 8 colunas (uma por rainha)
    permutation([1,2,3,4,5,6,7,8], Tabuleiro), % Gera uma permutação das colunas
    seguro(Tabuleiro).         % Verifica se a disposição é segura (sem ataques)

% -----------------------------------------------------
% Verifica se o tabuleiro é seguro (nenhuma rainha se ataca)
% -----------------------------------------------------
seguro([]).
seguro([Rainha | OutrasRainhas]) :-
    seguro(OutrasRainhas),       % Verifica recursivamente o restante
    nao_ataca(Rainha, OutrasRainhas, 1). % Confirma que a rainha atual não ataca nenhuma outra

% -----------------------------------------------------
% Verifica se uma rainha não ataca as outras
% 1º parâmetro: posição da rainha atual
% 2º parâmetro: lista de outras rainhas
% 3º parâmetro: distância (quantas linhas abaixo estamos)
% -----------------------------------------------------
nao_ataca(_, [], _).
nao_ataca(Rainha, [OutraRainha | Outras], Distancia) :-
    Rainha =\= OutraRainha,              % Não pode estar na mesma coluna
    abs(Rainha - OutraRainha) =\= Distancia, % Não pode estar na mesma diagonal
    Distancia1 is Distancia + 1,          % Aumenta a distância (indo para a próxima linha)
    nao_ataca(Rainha, Outras, Distancia1).

% -----------------------------------------------------
% Utilitário para calcular o valor absoluto
% -----------------------------------------------------
abs(X, X) :- X >= 0.
abs(X, Y) :- X < 0, Y is -X.

% -----------------------------------------------------
% Exemplo de como executar:
% ?- solucao(Tabuleiro).
% Tabuleiro = [1, 5, 8, 6, 3, 7, 2, 4] ; 
% Tabuleiro = [1, 6, 8, 3, 7, 4, 2, 5] ;
% (e assim por diante)
% -----------------------------------------------------
