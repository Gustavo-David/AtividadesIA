import java.util.HashMap;

public class Teste {
    public static void main(String[] args) {
        // Criação da tabela hash
        HashMap<String, Integer> tabelaHash = new HashMap<>();

        // Inserindo elementos
        tabelaHash.put("Maçã", 10);
        tabelaHash.put("Banana", 5);
        tabelaHash.put("Laranja", 7);

        // Acessando um valor
        System.out.println("Quantidade de Maçãs: " + tabelaHash.get("Maçã"));

        // Verificando se contém uma chave
        if (tabelaHash.containsKey("Banana")) {
            System.out.println("Temos bananas no estoque.");
        }

        // Removendo um item
        tabelaHash.remove("Laranja");

        // Iterando pelos elementos
        for (String chave : tabelaHash.keySet()) {
            System.out.println(chave + ": " + tabelaHash.get(chave));
        }
    }
}
