
/* 
public class CsvReader {
    public static List<DadosPais> leCSV(String filePath) throws IOException {
        try (BufferedReader br = new BufferedReader(new FileReader(filePath))) {
            // mapeia o csv pegando valor a valor e colocando dentro da struct criada DadosPais
            return br.lines()
                     .map(line -> line.split(","))
                     .map(values -> new DadosPais(values[0], Integer.parseInt(values[1]),
                            Integer.parseInt(values[2]), Integer.parseInt(values[3]),
                            Integer.parseInt(values[4])))
                     .collect(Collectors.toList());
        }
    }
}
*/