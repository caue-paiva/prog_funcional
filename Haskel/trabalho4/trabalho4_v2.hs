
--função principal para calcular o bonus de cada jogada
jogadasAux :: [Int] -> [Int] -> Int -> Int -> Int -> Int
jogadasAux [] _ _ _ score = score --caso base
jogadasAux (pinosDerrubados:xs) (b:bs) arremesoAnteRodada rodadaAtual score = --caso com bonus
  let novoScore = score + ((b + 1) * pinosDerrubados) --conta com o bonus
      (novaListBonus, novaRodada, novoArremesoAnte)
        | arremesoAnteRodada == -1 =
            if pinosDerrubados == 10 && rodadaAtual < 10 --strike
            then (calculaBonus bs 2, rodadaAtual + 1, -1)
            else (calculaBonus bs 0, rodadaAtual, pinosDerrubados)
        | arremesoAnteRodada + pinosDerrubados == 10 && rodadaAtual < 10 = --spare
            (calculaBonus bs 1, rodadaAtual + 1, -1)
        | otherwise =
            (calculaBonus bs 0, rodadaAtual + 1, -1)
  in jogadasAux xs novaListBonus novoArremesoAnte novaRodada novoScore
jogadasAux (pinosDerrubados:xs) [] arremesoAnteRodada rodadaAtual score = -- caso sem bonus
  let novoScore = score + pinosDerrubados --so conta os pinos derrubados
      (novaListBonus, novaRodada, novoArremesoAnte)
        | arremesoAnteRodada == -1 =
            if pinosDerrubados == 10 && rodadaAtual < 10 --strike
            then (calculaBonus [] 2, rodadaAtual + 1, -1)
            else (calculaBonus [] 0, rodadaAtual, pinosDerrubados)
        | arremesoAnteRodada + pinosDerrubados == 10 && rodadaAtual < 10 = --spare
            (calculaBonus [] 1, rodadaAtual + 1, -1)
        | otherwise =
            (calculaBonus [] 0, rodadaAtual + 1, -1)
  in jogadasAux xs novaListBonus novoArremesoAnte novaRodada novoScore

--função auxiliar para calcular os bonus de pontos da jogada
calculaBonus :: [Int] -> Int -> [Int]
calculaBonus [] opcao --bonus vazio
  | opcao == 0 = [] --caso normal
  | opcao == 1 = [1] --spare
  | otherwise = [1, 1] --strike
calculaBonus (x:xs) opcao --tem lista de bonus
  | opcao == 0 = x:xs --normal
  | opcao == 1 = (x + 1):xs --spare
  | otherwise = (x + 1):1:xs --strike

--função wrapper para calcular os pontos da jogada
calculaPontos :: [Int] -> Int
calculaPontos listaJogadas = jogadasAux listaJogadas [0] (-1) 1 0 --inicializa com os parâmetros iniciais da recursão

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
