import java.io.IOException;
import java.util.List;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) throws IOException {
        Scanner scanner = new Scanner(System.in);
        String input = scanner.nextLine();
        String[] inputs = input.split(" ");
        int n1 = Integer.parseInt(inputs[0]);
        int n2 = Integer.parseInt(inputs[1]);
        int n3 = Integer.parseInt(inputs[2]);
        int n4 = Integer.parseInt(inputs[3]);

        String filePath = "dados.csv";
        List<DadosPais> listaPaises = CsvReader.leCSV(filePath);

        System.out.println(DataAnalysis.somaAtivosComConfirmadosAcima(n1, listaPaises));
        System.out.println(DataAnalysis.somaMortesComMenoresConfirmados(n2, n3, listaPaises));
        DataAnalysis.printPaises(DataAnalysis.maioresConfirmadosAlfabetica(n4, listaPaises));
    }
}
