import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;




public class DataAnalysis {

    // função que soma os active de todos os países em que confirmed é maior ou igual que n1
    public static int somaAtivosComConfirmadosAcima(int n1, List<DadosPais> dadosList) {
        return dadosList.stream()
                        .filter(pais -> pais.getConfirmed() >= n1)
                        .mapToInt(DadosPais::getActive)
                        .sum();
    }

    // função que, dentre os n2 países com maiores valores de active, soma as deaths dos n3 países com menores valores de confirmed
    public static int somaMortesComMenoresConfirmados(int n2, int n1, List<DadosPais> dadosList) {
        List<DadosPais> topActive = dadosList.stream()
                                             .sorted(Comparator.comparingInt(DadosPais::getActive).reversed())
                                             .limit(n2)
                                             .collect(Collectors.toList());

        List<DadosPais> topConfirmed = topActive.stream()
                                                .sorted(Comparator.comparingInt(DadosPais::getConfirmed))
                                                .limit(n1)
                                                .collect(Collectors.toList());

        return topConfirmed.stream()
                           .mapToInt(DadosPais::getDeaths)
                           .sum();
    }

    // função que retorna os n4 países com mais confirmed em ordem alfabética        
    public static List<String> maioresConfirmadosAlfabetica(int n, List<DadosPais> dadosList) {
        return dadosList.stream()
                        .sorted(Comparator.comparingInt(DadosPais::getConfirmed).reversed())
                        .limit(n)
                        .sorted(Comparator.comparing(DadosPais::getCountry))
                        .map(DadosPais::getCountry)
                        .collect(Collectors.toList());
    }

    // função que printa país por país
    public static void printPaises(List<String> paises) {
        paises.forEach(System.out::println);
    }
}
