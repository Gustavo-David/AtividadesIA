# Grade fixa: I = inicio, O = objeto, # = parede, . = livre

grade = [ # original do professor
    list("I..#"),
    list(".#.."),
    list("...O")
]


#  Cenário 1: Caminho possível

# grade = [
#     list("I..."),
#     list(".#.."),
#     list("...O")
# ]
# Neste caso, há um caminho livre da posição I (0,0) até o O (2,3). Só há uma parede em (1,1), mas não bloqueia a passagem.
# Custo =5, Passos = 5


#Cenário 2: Caminho bloqueado (sem solução)

# grade = [
#    list("I#.."),
#    list("##.#"),
#    list("..#O")
# ]
# Aqui, o I está isolado: não há como chegar até o O. As paredes bloqueiam todas as possibilidades de rota.
#Custo = oo, passos = 0





inicio = (0,0)
objetivo = (2,3)

# Funcäo heuristica: distäncia de manhattan

def h(pos): # A heurística usada é a distância de Manhattan (|x1 - x2| + |y1 - y2|), adequada para movimentação em 4 direções.
    return abs(pos[0] - objetivo[0]) + abs(pos[1] - objetivo[1])

# A* simplificado (lista_aberta é lista comum)
lista_aberta = [inicio] # lista_aberta: Contém os nós que ainda serão explorados. Funciona como a fronteira do algoritmo. Nós são inseridos aqui quando são candidatos a uma nova expansão.

custo_g = {inicio:0} # custo_g: Dicionário que guarda o custo acumulado desde o início (`I`) até cada nó. Representa `g(n)` na função de avaliação.

veio_de = {} # veio_de: Dicionário que mapeia cada nó para o nó de onde veio. Serve para reconstruir o caminho ao final.

conjunto_fechado = set() # conjunto_fechado: Conjunto dos nós que já foram processados. Um nó, depois de expandido, é adicionado aqui para não ser visitado novamente.


while lista_aberta:
    # escolhe no com menor f = custo_g + h
    #    # Isso garante que o nó mais promissor (menor custo estimado total) seja expandido primeiro.

    atual = min(lista_aberta, key=lambda p: custo_g[p]+h(p)) # <- ESCOLHA DO NÓ ATUAL

    if atual == objetivo:
        break # Encontrol um caminho ótimo até o objetivo
    
    lista_aberta.remove(atual)
    conjunto_fechado.add(atual)

    # Expansão dos vizinhos do nó atual
    for di, dj in [(1,0),(-1,0), (0,1),(0,-1)]:

        vizinho = (atual[0]+ di, atual[1] +dj)
        i,j = vizinho
        # verifica limites e obståculos
        if not (0<= i < len(grade) and 0 <= j < len(grade[0])):
            continue
        if grade[i][j] == "#":
            continue
        if vizinho in conjunto_fechado:
            continue

        #Cálculo do custo acumulado g(n) até o vizinho
        g_tentativo = custo_g[atual] +1
        
        # Se for a primeira vez visitando ou encontramos um caminho melhor
        if vizinho not in custo_g or g_tentativo < custo_g [vizinho]:
            custo_g[vizinho] = g_tentativo
            veio_de[vizinho] = atual
            if vizinho not in lista_aberta:
                lista_aberta.append(vizinho)

#g_tentativo = custo_g[atual] + 1
# Explicação:
#O valor g(n) representa o custo do caminho do início até o nó n.
#A cada vizinho (vizinho) do nó atual (atual), o algoritmo tenta calcular o novo custo acumulado (g_tentativo), somando o custo do nó atual (custo_g[atual]) com o custo de mover para o vizinho, que nesse caso é 1 (caminho uniforme).
#Se o vizinho ainda não tem um custo registrado ou se esse novo custo for menor que o anterior, ele será atualizado:
#custo_g[vizinho] = g_tentativo


# Reconströi o caminho
caminho = []
no = objetivo
while no in veio_de:
    caminho.append(no)
    no = veio_de[no]
caminho.append(inicio)
caminho.reverse()

# Marca o caminho na grade
for(i, j) in caminho:
    if grade[i][j] == ".":
        grade[i][j] = "*"



for linha in grade:
    print("".join(linha))
print(f"Custo = {custo_g.get(objetivo,'oo')}, passos = {len(caminho)-1}")





# Cenário 1: Caminho possível
# O A* encontra o objetivo com eficiência, porque, ele sempre prioriza os nós com menor custo estimado f(n) = g(n) + h(n), assim que chega ao objetivo, ele interrompe o laço.

# Cenário 2: Caminho bloqueado
# no cenário 2 não existe caminho possível até o objetivo,o algoritmo explora todas as rotas acessíveis a partir do ponto inicial, tentando encontrar qualquer caminho viável, como o objetivo nunca é alcançado, o A* varre todos os nós possíveis até esgotar a lista_aberta.

# O tamanho de conjunto_fechado é maior no cenário bloqueado.

# Justificativa:
# Quando não há solução, o algoritmo precisa explorar todo o espaço de busca acessível antes de concluir que o objetivo é inalcançável. Isso resulta em mais expansões de nós do que no cenário com solução, onde o caminho ótimo é encontrado rapidamente e o processo para.