main :-
    statistics(cputime, T1),
    modelo(Solucao),
    imprime_lista(Solucao),
    statistics(cputime, T2),
    TempoExecucao is T2 - T1,
    write('\nTempo de execucao: '), write(TempoExecucao), write(' segundos\n').


modelo(Solucao) :- 
    Solucao = [
        (Mochila1, Nome1, Mes1, Jogo1, Materia1, Suco1),
        (Mochila2, Nome2, Mes2, Jogo2, Materia2, Suco2),
        (Mochila3, Nome3, Mes3, Jogo3, Materia3, Suco3),
        (Mochila4, Nome4, Mes4, Jogo4, Materia4, Suco4),
        (Mochila5, Nome5, Mes5, Jogo5, Materia5, Suco5)
    ],
    
    % Domínios
    Mochilas = [amarela, azul, branca, verde, vermelha],
    Nomes = [denis, joao, lenin, otavio, will],
    Meses = [agosto, dezembro, janeiro, maio, setembro],
    Jogos = [tres_ou_mais, caca_palavras, cubo_vermelho, forca, problemas_logica],
    Materias = [biologia, geografia, historia, matematica, portugues],
    Sucos = [laranja, limao, maracuja, morango, uva],
    
    % Restrições de valores distintos
    all_different([Mochila1, Mochila2, Mochila3, Mochila4, Mochila5]),
    all_different([Nome1, Nome2, Nome3, Nome4, Nome5]),
    all_different([Mes1, Mes2, Mes3, Mes4, Mes5]),
    all_different([Jogo1, Jogo2, Jogo3, Jogo4, Jogo5]),
    all_different([Materia1, Materia2, Materia3, Materia4, Materia5]),
    all_different([Suco1, Suco2, Suco3, Suco4, Suco5]),
    
    % Restrições do problema
    Nome5 = lenin,
    Nome4 = will,
    Nome2 = joao,
    Materia2 = historia,
    Suco3 = morango,
    Materia5 = portugues,
    Mes3 = setembro,
    Mes2 = janeiro,
    Mes4 = maio,
    Mes5 = dezembro,
    Jogo1 = cubo_vermelho,
    Jogo3 = forca,
    Jogo5 = problemas_logica,
    Suco5 = uva,
    Materia4 = matematica,
    Suco4 = maracuja,
    Mochila2 = azul,
    Mochila3 = branca,
    Mochila1 = amarela,
    
    % Regras posicionais
    ao_lado(Mes3, Suco1, setembro, laranja, Solucao),
    ao_lado(Nome4, Jogo5, will, problemas_logica, Solucao),
    ao_lado(Jogo3, Jogo1, forca, tres_ou_mais, Solucao),
    ao_lado(Jogo3, Mochila5, forca, vermelha, Solucao),
    ao_lado(Mes3, Jogo1, setembro, cubo_vermelho, Solucao),
    exatamente_a_esquerda(Suco5, Materia5, uva, portugues, Solucao),
    exatamente_a_esquerda(Mochila3, Nome4, branca, will, Solucao),
    ao_direita(Suco5, Mochila2, uva, azul, Solucao),
    
    % Otávio em uma das pontas
    (Nome1 = otavio; Nome5 = otavio).

imprime_lista([]) :- write('\nFIM do imprime_lista\n').
imprime_lista([H|T]) :- 
    write('\n......................................\n'),
    write(H), write(' : '),
    imprime_lista(T).

% Regras auxiliares
ao_lado(A, B, VA, VB, Lista) :- 
    nextto((_, _, _, _, _, VA), (_, _, _, _, _, VB), Lista);
    nextto((_, _, _, _, _, VB), (_, _, _, _, _, VA), Lista).

exatamente_a_esquerda(A, B, VA, VB, Lista) :- 
    append(_, [( _, _, _, _, _, VA), ( _, _, _, _, _, VB)|_], Lista).

ao_direita(A, B, VA, VB, Lista) :- 
    append(_, [( _, _, _, _, _, VB), ( _, _, _, _, _, VA)|_], Lista).
