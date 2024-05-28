-- Define the auxiliary function for calculating scores
jogadasAux :: [Int] -> [Int] -> Int -> Int -> Int -> Int
jogadasAux [] _ _ _ score = score
jogadasAux (pinosDerrubados:xs) listBonus arremesoAnteRodada rodadaAtual score =
  let novoScore = case listBonus of
                    (b:bs) -> score + ((b + 1) * pinosDerrubados)
                    []     -> score + pinosDerrubados
      (novaListBonus, novaRodada, novoArremesoAnte)
        | arremesoAnteRodada == -1 =
            if pinosDerrubados == 10 && rodadaAtual < 10
            then case listBonus of
                   (_:bs) -> (calculaBonus bs 2, rodadaAtual + 1, -1)
                   []     -> (calculaBonus [] 2, rodadaAtual + 1, -1)
            else case listBonus of
                   (_:bs) -> (calculaBonus bs 0, rodadaAtual, pinosDerrubados)
                   []     -> (calculaBonus [] 0, rodadaAtual, pinosDerrubados)
        | arremesoAnteRodada + pinosDerrubados == 10 && rodadaAtual < 10 =
            case listBonus of
              (_:bs) -> (calculaBonus bs 1, rodadaAtual + 1, -1)
              []     -> (calculaBonus [] 1, rodadaAtual + 1, -1)
        | otherwise =
            case listBonus of
              (_:bs) -> (calculaBonus bs 0, rodadaAtual + 1, -1)
              []     -> (calculaBonus [] 0, rodadaAtual + 1, -1)
  in jogadasAux xs novaListBonus novoArremesoAnte novaRodada novoScore

-- Define the function for calculating bonuses
calculaBonus :: [Int] -> Int -> [Int]
calculaBonus [] opcao
  | opcao == 0 = []
  | opcao == 1 = [1]
  | otherwise = [1, 1]
calculaBonus (x:xs) opcao
  | opcao == 0 = x:xs
  | opcao == 1 = (x + 1):xs
  | otherwise = (x + 1):1:xs

-- Define the function for calculating total points
calculaPontos :: [Int] -> Int
calculaPontos listaJogadas = jogadasAux listaJogadas [0] (-1) 1 0

stringJogadaAux :: [Int] -> Int -> String -> Int -> String
stringJogadaAux [] arremesoAnteRodada stringRetorno rodadaAtual = stringRetorno
stringJogadaAux (pinosDerrubados:xs) arremesoAnteRodada stringRetorno rodadaAtual =
  let strPrimeiraJogada = show pinosDerrubados ++ " "
      (strStrike, strSparr, strFimRodada)
        | rodadaAtual < 10 = ("X _ | ", "/ | ", show pinosDerrubados ++ " | ")
        | otherwise = ("X ", "/ ", strPrimeiraJogada)
      (novaString, novoArremesoAnte, proxRodada)
        | arremesoAnteRodada == -1 =
            if pinosDerrubados == 10
            then (stringRetorno ++ strStrike, -1, rodadaAtual + 1)
            else (stringRetorno ++ strPrimeiraJogada, pinosDerrubados, rodadaAtual)
        | arremesoAnteRodada + pinosDerrubados == 10 =
            (stringRetorno ++ strSparr, -1, rodadaAtual + 1)
        | otherwise =
            (stringRetorno ++ strFimRodada, -1, rodadaAtual + 1)
  in stringJogadaAux xs novoArremesoAnte novaString proxRodada

stringJogada :: [Int] -> String
stringJogada listJogada = stringJogadaAux listJogada (-1) "" 1 ++ "|"


leInteiros :: String -> [Int] --função para ler vários inteiros da linha de comando
leInteiros input = map read $ words input 

main :: IO ()
main = do
  
  linhaComando <- getLine --le os numeros da linha de comando
  let numeros = leInteiros linhaComando --transforma linha lida em uma lista de números 

  putStrLn $ stringJogada numeros ++ show (calculaPontos numeros) --printa o resultado na tela
