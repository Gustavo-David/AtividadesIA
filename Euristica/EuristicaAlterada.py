# Grade do labirinto
# 'I' = início, 'O' = objetivo, '#' = obstáculo, '.' = livre
grade = [
    list("I..#"),
    list(".#.."),
    list("...O")
]

inicio = (0, 0)
objetivo = (2, 3)

# Função heurística (Chebyshev) - ideal para movimento em 8 direções
def h(pos):
    return max(abs(pos[0] - objetivo[0]), abs(pos[1] - objetivo[1]))

# Lista aberta (nós a serem avaliados)
lista_aberta = [inicio]

# custo_g guarda o custo do início até o nó atual
custo_g = {inicio: 0}

# veio_de guarda o caminho percorrido
veio_de = {}

# Conjunto de nós já avaliados (fechados)
conjunto_fechado = set()

# Movimentos permitidos: 8 direções (incluindo diagonais)
movimentos = [(1, 0), (-1, 0), (0, 1), (0, -1), 
              (1, 1), (1, -1), (-1, 1), (-1, -1)]

while lista_aberta:
    # Seleciona o nó com menor f(n) = g(n) + h(n)
    atual = min(lista_aberta, key=lambda p: custo_g[p] + h(p))

    # Se chegamos ao objetivo, encerra
    if atual == objetivo:
        break

    lista_aberta.remove(atual)
    conjunto_fechado.add(atual)

    for di, dj in movimentos:
        vizinho = (atual[0] + di, atual[1] + dj)
        i, j = vizinho

        # Verifica se o vizinho está dentro da grade
        if not (0 <= i < len(grade) and 0 <= j < len(grade[0])):
            continue

        # Ignora obstáculos
        if grade[i][j] == "#":
            continue

        # Ignora vizinhos já visitados
        if vizinho in conjunto_fechado:
            continue

        # Custo do início até o vizinho (g)
        g_tentativo = custo_g[atual] + 1

        # Se é um novo caminho ou um caminho mais curto
        if vizinho not in custo_g or g_tentativo < custo_g[vizinho]:
            custo_g[vizinho] = g_tentativo
            veio_de[vizinho] = atual
            if vizinho not in lista_aberta:
                lista_aberta.append(vizinho)

# Reconstrói o caminho do objetivo até o início
caminho = []
no = objetivo
while no in veio_de:
    caminho.append(no)
    no = veio_de[no]
caminho.append(inicio)
caminho.reverse()

# Marca o caminho na grade
for (i, j) in caminho:
    if grade[i][j] == ".":
        grade[i][j] = "*"

# Exibe a grade com o caminho
for linha in grade:
    print("".join(linha))

# Mostra o custo total e o número de passos
print(f"Custo = {custo_g.get(objetivo, 'oo')}, passos = {len(caminho)-1}")
