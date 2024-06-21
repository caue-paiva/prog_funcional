import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

public class CsvReader {
    public static List<DadosPais> leCSV(String filePath) throws IOException {
        try (BufferedReader br = new BufferedReader(new FileReader(filePath))) {
            return br.lines()
                     .map(line -> line.split(","))
                     .map(values -> new DadosPais(values[0], Integer.parseInt(values[1]),
                            Integer.parseInt(values[2]), Integer.parseInt(values[3]),
                            Integer.parseInt(values[4])))
                     .collect(Collectors.toList());
        }
    }
}
