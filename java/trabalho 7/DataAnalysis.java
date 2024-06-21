import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;
import java.util.ArrayList;
import java.util.Collections;

public class DataAnalysis {

    // função que soma os active de todos os países em que confirmed é maior ou igual que n1
    public static int somaAtivosComConfirmadosAcima(int n1, List<DadosPais> dadosList) {
        int soma = 0;

        for (DadosPais dados : dadosList) {
            if (dados.getConfirmed() >= n1) {
                soma += dados.getActive();
            }
        }

        return soma;
    }

    // função que, dentre os n2 países com maiores valores de active, soma as deaths dos n3 países com menores valores de confirmed
    public static int somaMortesComMenoresConfirmados(int n2, int n3, List<DadosPais> dadosList) {
        List<DadosPais> copiaDadosList = new ArrayList<>(dadosList);

        Collections.sort(copiaDadosList, new Comparator<DadosPais>() {
            @Override
            public int compare(DadosPais d1, DadosPais d2) {
                return Integer.compare(d2.getActive(), d1.getActive()); // Ordem decrescente
            }
        });

        List<DadosPais> topActive = copiaDadosList.subList(0, Math.min(n2, copiaDadosList.size()));

        Collections.sort(topActive, new Comparator<DadosPais>() {
            @Override
            public int compare(DadosPais d1, DadosPais d2) {
                return Integer.compare(d1.getConfirmed(), d2.getConfirmed()); // Ordem crescente
            }
        });

        List<DadosPais> menoresConfirmados = topActive.subList(0, Math.min(n3, topActive.size()));

        int somaMortes = 0;
        for (DadosPais dados : menoresConfirmados) {
            somaMortes += dados.getDeaths();
        }

        return somaMortes;
    }

    // função que retorna os n4 países com mais confirmed em ordem alfabética        
    public static List<String> maioresConfirmadosAlfabetica(int n4, List<DadosPais> dadosList) {
        List<DadosPais> copiaDadosList = new ArrayList<>(dadosList);
        Collections.sort(copiaDadosList, new Comparator<DadosPais>() {
            @Override
            public int compare(DadosPais d1, DadosPais d2) {
                return Integer.compare(d2.getConfirmed(), d1.getConfirmed()); // Ordem decrescente
            }
        });
        List<DadosPais> n4_paises = copiaDadosList.subList(0, Math.min(n4, copiaDadosList.size()));

        Collections.sort(n4_paises, new Comparator<DadosPais>() {
            @Override
            public int compare(DadosPais d1, DadosPais d2) {
                return d1.getCountry().compareTo(d2.getCountry()); // Ordem crescente
            }
        });

        List<String> result = new ArrayList<>();
        for (DadosPais dados : n4_paises) {
            result.add(dados.getCountry());
        }

        return result;


    }

    // função que printa país por país
    public static void printPaises(List<String> paises) {
        paises.forEach(System.out::println);
    }
}
