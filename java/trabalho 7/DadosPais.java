public class DadosPais {

    // definição da estrutura que será utilizada ao ler o csv 

    private final String country;
    private final int confirmed;
    private final int deaths;
    private final int recovered;
    private final int active;

    public DadosPais(String country, int confirmed, int deaths, int recovered, int active) {
        this.country = country;
        this.confirmed = confirmed;
        this.deaths = deaths;
        this.recovered = recovered;
        this.active = active;
    }


    // funções de retorno para as informações de cada conjunto de dados de um país
    
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
