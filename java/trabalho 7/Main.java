import java.io.IOException;
import java.util.List;
import java.util.Scanner;
import java.io.BufferedReader;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.Comparator;

import java.util.Collections;

class CsvReader {
    public static List<CountryData> readCsv(String filePath) throws IOException {
        List<CountryData> countriesList = new ArrayList<>(); //lista de objetos a ser extraido do csv
        try (BufferedReader br = new BufferedReader(new FileReader(filePath))) {

        // mapeia o csv pegando valor a valor e colocando dentro da struct criada CountryData
            String line;
            while ((line = br.readLine()) != null) { //le linhas ate acabar o arquivo
                String[] values = line.split(","); //separa a linha em uma lista de strings pela vírgula
                CountryData CountryData = new CountryData(values[0], Integer.parseInt(values[1]), //cria o objeto CountryData com os valores
                        Integer.parseInt(values[2]), Integer.parseInt(values[3]),
                        Integer.parseInt(values[4]));
                countriesList.add(CountryData); //adiciona o objeto a lista
            }
        }
        return countriesList; //retorna a lista de objetos
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

    // método que soma os active de todos os países em que confirmed é maior ou igual que n1
    public static int sumActivesGreaterEqualN1(int n1, List<CountryData> countriesList) {
        int sum = 0; //acumulador de soma

        // soma as quantidades de valores active com um loop
        for (CountryData country : countriesList) {
            if (country.getConfirmed() >= n1) { //verifica se o confirmed é maior ou igual a n1
                sum += country.getActive();
            }
        }
        return sum;
    }

    // método que, dentre os n2 países com maiores valores de active, soma as deaths dos n3 países com menores valores de confirmed
    public static int sumDeathsMostActives(int n2, int n3, List<CountryData> countriesList) {
        List<CountryData> copyCountriesList = new ArrayList<>(countriesList); //copia lista de países

        //ordena em ordem decrescente os países com mais active para depois pegar os n2 primeiros
        Collections.sort(copyCountriesList, new Comparator<CountryData>() {
            @Override
            public int compare(CountryData d1, CountryData d2) { //função de comparação
                return Integer.compare(d2.getActive(), d1.getActive()); // Ordem decrescente
            }
        });

        // cria uma nova lista com os n2 primeiros países da antiga
        List<CountryData> topActive = copyCountriesList.subList(0, Math.min(n2, copyCountriesList.size()));

        // ajusta em ordem crescente para pegar os n3 países com menores valores de confirmed
        Collections.sort(topActive, new Comparator<CountryData>() {
            @Override
            public int compare(CountryData d1, CountryData d2) { //função de comparação
                return Integer.compare(d1.getConfirmed(), d2.getConfirmed()); // Ordem crescente
            }
        });

        // pega os n3 menores
        List<CountryData> n3LeastConfirmed = topActive.subList(0, Math.min(n3, topActive.size()));

        // soma as quantidades de mortes 
        int sumDeaths = 0;
        for (CountryData country : n3LeastConfirmed) {
            sumDeaths += country.getDeaths();
        }

        return sumDeaths;
    }

    // método que retorna os n4 países com mais confirmed em ordem alfabética        
    public static List<String> mostConfirmedAlphaNumOrder(int n4, List<CountryData> countriesList) {
        List<CountryData> copyCountriesList = new ArrayList<>(countriesList); //copia lista de países

        // ordena em ordem descrescente para pegar os n4 países com mais confirmed
        Collections.sort(copyCountriesList, new Comparator<CountryData>() {
            @Override
            public int compare(CountryData d1, CountryData d2) {
                return Integer.compare(d2.getConfirmed(), d1.getConfirmed()); // Ordem decrescente
            }
        });

        // pega os n4 primeiros países
        List<CountryData> n4Countries = copyCountriesList.subList(0, Math.min(n4, copyCountriesList.size()));

        // ordena em ordem alfabética
        Collections.sort(n4Countries, new Comparator<CountryData>() {
            @Override
            public int compare(CountryData d1, CountryData d2) {
                return d1.getCountry().compareTo(d2.getCountry()); // Ordem crescente alfabética
            }
        });

        // coloca em uma lista de Strings
        List<String> result = new ArrayList<>();
        for (CountryData country : n4Countries) {
            result.add(country.getCountry());
        }

        return result;
    }

    // método que printa país por país
    public static void printCountries(List<String> countries) {
        for (String country : countries) {
            System.out.println(country);
        }
    }
}


public class Main {
    public static void main(String[] args) throws IOException {
        
        // leitura dos inputs n1, n2, n3 e n4
        Scanner scanner = new Scanner(System.in);
        String input = scanner.nextLine();
        String[] inputs = input.split(" ");
        int n1 = Integer.parseInt(inputs[0]);
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
