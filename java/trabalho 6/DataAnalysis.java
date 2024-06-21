import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;


public class DataAnalysis {
    public static int somaAtivosComConfirmadosAcima(int n1, List<DadosPais> dadosList) {
        return dadosList.stream()
                        .filter(pais -> pais.getConfirmed() > n1)
                        .mapToInt(DadosPais::getActive)
                        .sum();
    }

    public static int somaMortesComMenoresConfirmados(int n_paises, int n1, List<DadosPais> dadosList) {
        List<DadosPais> topActive = dadosList.stream()
                                             .sorted(Comparator.comparingInt(DadosPais::getActive).reversed())
                                             .limit(n_paises)
                                             .collect(Collectors.toList());

        List<DadosPais> topConfirmed = topActive.stream()
                                                .sorted(Comparator.comparingInt(DadosPais::getConfirmed))
                                                .limit(n1)
                                                .collect(Collectors.toList());

        return topConfirmed.stream()
                           .mapToInt(DadosPais::getDeaths)
                           .sum();
    }

    public static List<String> maioresConfirmadosAlfabetica(int n, List<DadosPais> dadosList) {
        return dadosList.stream()
                        .sorted(Comparator.comparingInt(DadosPais::getConfirmed).reversed())
                        .limit(n)
                        .sorted(Comparator.comparing(DadosPais::getCountry))
                        .map(DadosPais::getCountry)
                        .collect(Collectors.toList());
    }

    public static void printPaises(List<String> paises) {
        paises.forEach(System.out::println);
    }
}
