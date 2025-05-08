% Definição dos domínios
mochila(amarela). mochila(azul). mochila(branca). mochila(verde). mochila(vermelha).
nome(denis). nome(joao). nome(lenin). nome(otavio). nome(will).
mes(agosto). mes(dezembro). mes(janeiro). mes(maio). mes(setembro).
jogo(tres_ou_mais). jogo(caca_palavras). jogo(cubo_vermelho). jogo(jogo_da_forca). jogo(prob_logica).
materia(biologia). materia(geografia). materia(historia). materia(matematica). materia(portugues).
suco(laranja). suco(limao). suco(maracuja). suco(morango). suco(uva).

% Restrição de valores únicos
alldifferent([]).
alldifferent([H|T]) :- not(member(H, T)), alldifferent(T).

% Definição do modelo
modelo([
    (M1, N1, Mes1, J1, Mat1, S1), 
    (M2, N2, Mes2, J2, Mat2, S2),
    (M3, N3, Mes3, J3, Mat3, S3), 
    (M4, N4, Mes4, J4, Mat4, S4),
    (M5, N5, Mes5, J5, Mat5, S5)
]) :-
    % Definição dos domínios
    mochila(M1), mochila(M2), mochila(M3), mochila(M4), mochila(M5),
    nome(N1), nome(N2), nome(N3), nome(N4), nome(N5),
    mes(Mes1), mes(Mes2), mes(Mes3), mes(Mes4), mes(Mes5),
    jogo(J1), jogo(J2), jogo(J3), jogo(J4), jogo(J5),
    materia(Mat1), materia(Mat2), materia(Mat3), materia(Mat4), materia(Mat5),
    suco(S1), suco(S2), suco(S3), suco(S4), suco(S5),
    
    % Todos os valores devem ser distintos
    alldifferent([M1, M2, M3, M4, M5]),
    alldifferent([N1, N2, N3, N4, N5]),
    alldifferent([Mes1, Mes2, Mes3, Mes4, Mes5]),
    alldifferent([J1, J2, J3, J4, J5]),
    alldifferent([Mat1, Mat2, Mat3, Mat4, Mat5]),
    alldifferent([S1, S2, S3, S4, S5]),
    
    % Aplicação das restrições dadas no problema
    Mes5 = setembro, 
    (S4 = laranja; S3 = laranja),
    N2 = joao, Mat2 = historia,
    M2 = azul, 
    (Mes3 = maio; Mes4 = maio; Mes5 = maio),
    N5 = will, 
    (J4 = prob_logica; J3 = prob_logica),
    M3 = branca, N4 = will,
    S3 = morango,
    S4 = uva, J4 = prob_logica,
    (J2 = jogo_da_forca, J3 = tres_ou_mais; J3 = jogo_da_forca, J4 = tres_ou_mais),
    M1 = azul, Mes1 = janeiro,
    (J1 = cubo_vermelho; J5 = cubo_vermelho),
    Mat1 = biologia, S1 = morango,
    (Mes3 = janeiro, Mes4 = setembro; Mes4 = janeiro, Mes5 = setembro),
    (S3 = uva, Mat4 = portugues),
    Mes2 = dezembro, Mat2 = matematica,
    (J1 = prob_logica, M2 = amarela; J2 = prob_logica, M3 = amarela),
    N5 = lenin,
    (N1 = otavio; N5 = otavio).

% Impressão da solução
imprime_lista([]) :- write('\nFIM\n').
imprime_lista([H|T]) :- write(H), nl, imprime_lista(T).

% Predicado principal para execução do programa
main :- 
    statistics(cputime, T1),
    modelo(Solucao),
    imprime_lista(Solucao),
    statistics(cputime, T2),
    TempoExecucao is T2 - T1,
    write('Tempo de execucao: '), write(TempoExecucao), write(' segundos\n'),
    fail.
main :- write('\nFim da execucao.\n').
