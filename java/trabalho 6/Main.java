import java.io.IOException;
import java.util.List;
import java.util.Scanner;
import java.io.BufferedReader;
import java.io.FileReader;
import java.util.stream.Collectors;
import java.util.stream.Stream;
import java.util.Comparator;


class CsvReader {
    public static List<CountryData> readCsv(String filePath) throws IOException { //le csv e retorna uma lista de CountryData
        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) { //tenta ler o arquivo 
            // mapeia o csv pegando valor a valor e colocando dentro da struct criada CountryData
            return reader.lines() //pega as linhas do arquivo e transforma em stream
                     .map(line -> line.split(",")) //separa os valores por virgula, transforma uma lista simples em lista de listas, com uma lista sendo um campo
                     .map(fields -> new CountryData(fields[0], Integer.parseInt(fields[1]),  //dado uma lista (linha), cria o objeto dados pais com os valores
                            Integer.parseInt(fields[2]), Integer.parseInt(fields[3]),
                            Integer.parseInt(fields[4])))
                     .collect(Collectors.toList()); //transforma a stream em lista
        }
    }
}

class CountryData {
    // definição da classe que representa os dados de cada pais

    private final String country; //campos constantes, pois não haverá mudança de estado nos objetos
    private final int confirmed;
    private final int deaths;
    private final int recovered;
    private final int active;

    public CountryData(String country, int confirmed, int deaths, int recovered, int active) {
        this.country = country;
        this.confirmed = confirmed;
        this.deaths = deaths;
        this.recovered = recovered;
        this.active = active;
    }

    // funções getter para as informações de cada conjunto de dados de um país, usado também como argumentos para outras funções
    
    public String getCountry() {
        return country;
    }

    public int getConfirmed() {
        return confirmed;
    }

    public int getDeaths() {
        return deaths;
    }

    public int getRecovered() {
        return recovered;
    }

    public int getActive() {
        return active;
    }
}

class DataOperations {
    //classe com as operações sobre os de dados que serão coletado a partir do csv lido

    // método que soma os active de todos os países em que confirmed é maior ou igual que n1
    public static int sumActivesGreaterEqualN1(int n1, List<CountryData> countriesList) {
        return countriesList.stream()
                        .filter(pais -> pais.getConfirmed() >= n1) //filtra os países com confirmed maior ou igual a n1
                        .mapToInt(CountryData::getActive) //transforma pelo map em uma stream de inteiros
                        .sum(); //soma
    }

    // método que dentre os n2 países com maiores valores de active, soma as deaths dos n1 países com menores valores de confirmed
    public static int sumDeathsMostActives(int n2, int n1, List<CountryData> countriesList) {
        Stream<CountryData> topActive = countriesList.stream()
                                            .sorted(Comparator.comparingInt(CountryData::getActive).reversed()) //ordena por active
                                            .limit(n2); //pega n2 países
                                             
                            return topActive
                                            .sorted(Comparator.comparingInt(CountryData::getConfirmed)) //ordena pelos confirmed
                                            .limit(n1) //pega n1 países
                                            .mapToInt(CountryData::getDeaths) //transforma em int soma
                                            .sum(); //retorna a soma
    }

    // método que retorna os n4 países com mais confirmed em ordem alfabética        
    public static List<String> mostConfirmedAlphaNumOrder(int n4, List<CountryData> countriesList) {
        return countriesList.stream()
                        .sorted(Comparator.comparingInt(CountryData::getConfirmed).reversed()) //ordenar por confirmed
                        .limit(n4) //pega n4 países
                        .sorted(Comparator.comparing(CountryData::getCountry)) //ordena por nome do país
                        .map(CountryData::getCountry) //pega o nome do país
                        .collect(Collectors.toList()); //transforma em lista e retorna
    }

    // método que printa país por país
    public static void printCountries(List<String> paises) {
        paises.forEach(System.out::println);
    }
}


public class Main {
    public static void main(String[] args) throws IOException {
        
        // leitura dos inputs n1, n2, n3 e n4
        Scanner scanner = new Scanner(System.in);
        String input = scanner.nextLine();
        String[] inputs = input.split(" ");
        int n1 = Integer.parseInt(inputs[0]); //parsings nos inputs
        int n2 = Integer.parseInt(inputs[1]);
        int n3 = Integer.parseInt(inputs[2]);
        int n4 = Integer.parseInt(inputs[3]);

        // leitura do csv
        String filePath = "dados.csv";
        List<CountryData> countriesList = CsvReader.readCsv(filePath);
        
        // print das saídas
        System.out.println(DataOperations.sumActivesGreaterEqualN1(n1, countriesList));
        System.out.println(DataOperations.sumDeathsMostActives(n2, n3, countriesList));
        DataOperations.printCountries(DataOperations.mostConfirmedAlphaNumOrder(n4, countriesList));

        scanner.close(); //fecha o scanner
    }
}
