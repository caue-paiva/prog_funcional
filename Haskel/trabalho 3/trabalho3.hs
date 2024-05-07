

segmentoCrescAux :: [Int] -> Int -> Int -> Int -> Int --função auxiliar que implementa a lógica do programa
segmentoCrescAux [] _ maiorSequencia _ = maiorSequencia -- caso base de uma lista vazia, retorna a maior sequencia
segmentoCrescAux [anterior] _ maiorSequencia sequenciaAtual = max maiorSequencia sequenciaAtual --caso base de um item sobrando, compara a sequencia atual com a maior sequencia e pega o max
segmentoCrescAux (anterior:atual:resto) index maiorSequencia sequenciaAtual -- caso normal da recursão,    
  | atual > anterior = let sequenciaAtualizada = sequenciaAtual + 1 --se o atual é maior que o anterior, cria um var com a sequencia antiga + 1
                       in if sequenciaAtualizada > maiorSequencia --se a sequencia atualizada é maior que a maior sequencia chama a função com essa sequencia como maiorSequencia
                            then segmentoCrescAux (atual:resto) (index + 1) sequenciaAtualizada sequenciaAtualizada
                            else segmentoCrescAux (atual:resto) (index + 1) maiorSequencia sequenciaAtualizada --senão, chama a função com a maiorSequencia anterior
  | otherwise = segmentoCrescAux (atual:resto) (index + 1) maiorSequencia 1 --caso o atual n seja maior que o anterior, reseta a sequencia atual para 1

segmentoCrescente :: [Int] -> Int --Função final para o usuário, que chama a função aux com parâmetros corretos da recursão
segmentoCrescente [] = 0  --Caso base de lista vazia, retorna 0
segmentoCrescente [_] = 1 --Caso base de uma lista com um elemento, retorna 1
segmentoCrescente (x:xs) = segmentoCrescAux (x:xs) 1 1 1 --Caso normal, chama a função aux

leInteiros :: String -> [Int] --função para ler vários inteiros da linha de comando
leInteiros input = map read $ words input 

main :: IO ()
main = do
   linhaComando <- getLine --le os numeros da linha de comando
   let numeros = leInteiros linhaComando --transforma linha lida em uma lista de números

   let resultado = show $ segmentoCrescente numeros --aplica a lista de numeros na função  e depois no show, para virar str
   putStrLn resultado --printa o resultado na tela 
