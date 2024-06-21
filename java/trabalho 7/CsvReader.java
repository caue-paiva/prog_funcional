import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;



public class CsvReader {
    public static List<DadosPais> leCSV(String filePath) throws IOException {
        List<DadosPais> dadosList = new ArrayList<>();
        try (BufferedReader br = new BufferedReader(new FileReader(filePath))) {

        // mapeia o csv pegando valor a valor e colocando dentro da struct criada DadosPais
            String line;
            while ((line = br.readLine()) != null) {
                String[] values = line.split(",");
                DadosPais dadosPais = new DadosPais(values[0], Integer.parseInt(values[1]),
                        Integer.parseInt(values[2]), Integer.parseInt(values[3]),
                        Integer.parseInt(values[4]));
                dadosList.add(dadosPais);
            }
        }
        return dadosList;
    }
}