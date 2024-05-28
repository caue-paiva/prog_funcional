
--função principal para calcular o bonus de cada jogada
jogadasAux :: [Int] -> [Int] -> Int -> Int -> Int -> Int
jogadasAux [] _ _ _ score = score
jogadasAux (pinosDerrubados:xs) listBonus arremesoAnteRodada rodadaAtual score =
  let novoScore = if not (null listBonus)
                  then score + ((head listBonus + 1) * pinosDerrubados)
                  else score + pinosDerrubados
      (novaListBonus, novaRodada, novoArremesoAnte)
        | arremesoAnteRodada == -1 =
            if pinosDerrubados == 10 && rodadaAtual < 10
            then let bs = if null listBonus then [] else tail listBonus
                 in (calculaBonus bs 2, rodadaAtual + 1, -1)
            else let bs = if null listBonus then [] else tail listBonus
                 in (calculaBonus bs 0, rodadaAtual, pinosDerrubados)
        | arremesoAnteRodada + pinosDerrubados == 10 && rodadaAtual < 10 =
            let bs = if null listBonus then [] else tail listBonus
            in (calculaBonus bs 1, rodadaAtual + 1, -1)
        | otherwise =
            let bs = if null listBonus then [] else tail listBonus
            in (calculaBonus bs 0, rodadaAtual + 1, -1)
  in jogadasAux xs novaListBonus novoArremesoAnte novaRodada novoScore

--função auxiliar para calcular os bonus de pontos da jogada
calculaBonus :: [Int] -> Int -> [Int]
calculaBonus [] opcao
  | opcao == 0 = []
  | opcao == 1 = [1]
  | otherwise = [1, 1]
calculaBonus (x:xs) opcao
  | opcao == 0 = x:xs
  | opcao == 1 = (x + 1):xs
  | otherwise = (x + 1):1:xs

--função wrapper para calcular os pontos da jogada
calculaPontos :: [Int] -> Int
calculaPontos listaJogadas = jogadasAux listaJogadas [0] (-1) 1 0

--função principal para calcular a representaçao de string da jogada
stringJogadaAux :: [Int] -> Int -> String -> Int -> String
stringJogadaAux [] _ stringRetorno _ = stringRetorno
stringJogadaAux (pinosDerrubados:xs) arremesoAnteRodada stringRetorno rodadaAtual =
  let strPrimeiraJogada = show pinosDerrubados ++ " "
      (strStrike, strSparr, strFimRodada) --ve qual vai ser a string para representar cada ação no jogo
        | rodadaAtual < 10 = ("X _ | ", "/ | ", show pinosDerrubados ++ " | ")
        | otherwise = ("X ", "/ ", strPrimeiraJogada)
      (novaString, novoArremesoAnte, proxRodada)
        | arremesoAnteRodada == -1 =
            if pinosDerrubados == 10 --strike
            then (stringRetorno ++ strStrike, -1, rodadaAtual + 1)
            else (stringRetorno ++ strPrimeiraJogada, pinosDerrubados, rodadaAtual)
        | arremesoAnteRodada + pinosDerrubados == 10 =
            (stringRetorno ++ strSparr, -1, rodadaAtual + 1) --spare
        | otherwise =
            (stringRetorno ++ strFimRodada, -1, rodadaAtual + 1)
  in stringJogadaAux xs novoArremesoAnte novaString proxRodada

stringJogada :: [Int] -> String --função wrapper para imprimir a string
stringJogada listJogada = stringJogadaAux listJogada (-1) "" 1 ++ "|"

leInteiros :: String -> [Int] --função para ler vários inteiros da linha de comando
leInteiros input = map read $ words input 

main :: IO ()
main = do
 
  linhaComando <- getLine --le os numeros da linha de comando
  let numeros = leInteiros linhaComando --transforma linha lida em uma lista de números 
  putStrLn $ stringJogada numeros ++ " " ++ show (calculaPontos numeros) --printa o resultado na tela
