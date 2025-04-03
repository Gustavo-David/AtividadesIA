% Definição de domínio para cada categoria
mochilas([amarela, azul, branca, verde, vermelha]).
nomes([denis, joao, lenin, otavio, will]).
meses([agosto, dezembro, janeiro, maio, setembro]).
jogos([tres_ou_mais, caca_palavras, cubo_vermelho, forca, problemas_logica]).
materias([biologia, geografia, historia, matematica, portugues]).
sucos([laranja, limao, maracuja, morango, uva]).

% Predicado principal
main :- 
    statistics(cputime, T1),
    modelo(Solucao),
    write('\nSolução Encontrada:\n'),
    imprime_lista(Solucao),
    statistics(cputime, T2),
    TempoExecucao is T2 - T1,
    write('\nTempo de execução: '), write(TempoExecucao), write(' segundos\n').

% Definição do modelo lógico
modelo(Solucao) :- 
    mochilas(Mochilas), nomes(Nomes), meses(Meses), jogos(Jogos), materias(Materias), sucos(Sucos),

    Solucao = [
        (Mochila1, Nome1, Mes1, Jogo1, Materia1, Suco1),
        (Mochila2, Nome2, Mes2, Jogo2, Materia2, Suco2),
        (Mochila3, Nome3, Mes3, Jogo3, Materia3, Suco3),
        (Mochila4, Nome4, Mes4, Jogo4, Materia4, Suco4),
        (Mochila5, Nome5, Mes5, Jogo5, Materia5, Suco5)
    ],

    % Garante que todos os elementos em cada categoria são distintos
    permutation(Mochilas, [Mochila1, Mochila2, Mochila3, Mochila4, Mochila5]),
    permutation(Nomes, [Nome1, Nome2, Nome3, Nome4, Nome5]),
    permutation(Meses, [Mes1, Mes2, Mes3, Mes4, Mes5]),
    permutation(Jogos, [Jogo1, Jogo2, Jogo3, Jogo4, Jogo5]),
    permutation(Materias, [Materia1, Materia2, Materia3, Materia4, Materia5]),
    permutation(Sucos, [Suco1, Suco2, Suco3, Suco4, Suco5]),

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
    ao_lado(Mes3, Suco1, Solucao),
    ao_lado(Nome4, Jogo5, Solucao),
    ao_lado(Jogo3, Jogo1, Solucao),
    ao_lado(Jogo3, Mochila5, Solucao),
    ao_lado(Mes3, Jogo1, Solucao),
    exatamente_a_esquerda(Suco5, Materia5, Solucao),
    exatamente_a_esquerda(Mochila3, Nome4, Solucao),
    ao_direita(Suco5, Mochila2, Solucao),

    % Otávio em uma das pontas
    (Nome1 = otavio; Nome5 = otavio).

% Predicado para imprimir a solução formatada
imprime_lista([]).
imprime_lista([(Mochila, Nome, Mes, Jogo, Materia, Suco) | T]) :- 
    write('\n-----------------------------------\n'),
    write('Mochila: '), write(Mochila), write('\n'),
    write('Nome: '), write(Nome), write('\n'),
    write('Mês: '), write(Mes), write('\n'),
    write('Jogo: '), write(Jogo), write('\n'),
    write('Matéria: '), write(Materia), write('\n'),
    write('Suco: '), write(Suco), write('\n'),
    imprime_lista(T).

% Regras auxiliares para verificar posições relativas
ao_lado(A, B, Lista) :- 
    nextto((A, _, _, _, _, _), (B, _, _, _, _, _), Lista);
    nextto((B, _, _, _, _, _), (A, _, _, _, _, _), Lista).

exatamente_a_esquerda(A, B, Lista) :- 
    append(_, [(A, _, _, _, _, _), (B, _, _, _, _, _)|_], Lista).

ao_direita(A, B, Lista) :- 
    append(_, [(B, _, _, _, _, _), (A, _, _, _, _, _)|_], Lista).
