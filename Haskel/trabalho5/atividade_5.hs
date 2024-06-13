import System.IO
import Control.Exception (evaluate)
import Control.DeepSeq (force)
import Data.List (sortOn, sortBy)
import Data.Ord (comparing, Down(..))

-- struct para manipulação dos dados, cada um deles equivale a uma linha do arquivo CSV
data DadosPais = DadosPais   { country   :: String --campos que vamos ter que ler e operar sobre 
                             , confirmed :: Int
                             , deaths    :: Int
                             , recovered :: Int
                             , active    :: Int
                            } deriving (Show) --consegue converter a struct para string
                        
--função para separar sting da linha de CSV em uma lista de strings separadas por vírgula
splitVirgula :: String -> [String]
splitVirgula str = splitAux str ""
  where
    splitAux [] acc = [reverse acc] --caso base da função aux, reverte a string acumulada e coloca na lista
    splitAux (h:hs) acc --caso normal
      | h == ','  = reverse acc : splitAux hs "" --caso ache uma virgula, reverte o acumulador da str e coloca na lista
      | otherwise = splitAux hs (h : acc) --não é virgula, coloca o caractere no acumulador


-- Função para converter uma linha de strings em DadosPais
criaDadosPais :: [String] -> DadosPais
criaDadosPais [country, confirmed, deaths, recovered, active] = --cria uma estrutura DadosPais com os dados da linha
    DadosPais country (read confirmed) (read deaths) (read recovered) (read active)
criaDadosPais _ = error "Formato de linha incorreto" --caso para não conseguir ler linha 

-- Função para ler o arquivo CSV e separar os dados em uma lista de DadosPais
leCSV :: FilePath -> IO [DadosPais]
leCSV filePath = do
  handle_arq <- openFile filePath ReadMode --abre o arquivo
  contents <- hGetContents handle_arq --pega os contéudos do arquivo
  evaluate $ force contents --força pegar todos os conteúdos do arquivo, sobrescreve o lazyness
  hClose handle_arq --fecha o arquivo
  let rows = lines contents --separa as linhas do arquivo
      parsedRows = map splitVirgula rows --separa por listas de string a cada campo
      dadosList = map criaDadosPais parsedRows --transforma em structs DadosPai
  return dadosList --retorna lista de structs

-- Função para filtrar e somar o campo active dos países com campo confirmed maior que parâmetro n1
somaAtivosComConfirmadosAcima :: Int -> [DadosPais] -> Int
somaAtivosComConfirmadosAcima n1 = sum.map active.filter (\pais -> confirmed pais > n1)

-- Função para somar o campo deaths dos n_países com menores campos confirmed dos n1 países com maiores campos active
somaMortesComMenoresConfirmados :: Int -> Int -> [DadosPais] -> Int
somaMortesComMenoresConfirmados n_paises n1 = sum . map deaths . take n1 . sortOn confirmed . take n_paises . sortBy (comparing (Down . active))

-- Função para obter os nomes dos n países com maiores campos confirmed em ordem alfabética
maioresConfirmadosAlfabetica :: Int -> [DadosPais] -> [String]
maioresConfirmadosAlfabetica n = map country . sortBy (comparing country) . take n . sortOn (Down . confirmed)

printPaises:: [String] -> IO () --função para printar a lista de países ordenados na resposta final, usa recursão
printPaises [] = return () --caso base, retorna vazio
printPaises(h:hs) = do --caso normal
  putStrLn h --print cabeça da lista
  printPaises hs --chama função  com a cauda


main :: IO ()
main = do
  -- Leitura de n1, n2, n3 e n4 da linha de input
  input <- getLine
  let [n1, n2, n3, n4] = map read (words input)

  let filePath = "dados.csv" --caminho do arquivo
  listaPaises <- leCSV filePath --processa conteúdo do CSV em lista de structs DadosPais

  print $ somaAtivosComConfirmadosAcima n1 listaPaises --print normal dos números
  print $ somaMortesComMenoresConfirmados n2 n3 listaPaises
  printPaises $ maioresConfirmadosAlfabetica n4 listaPaises --printa a lista de países ordenados com uma função
