import System.Environment (getArgs)




segmentoCrescAux :: [Int] -> Int -> Int -> Int -> Int
segmentoCrescAux [] _ maiorSequencia _ = maiorSequencia
segmentoCrescAux [_] _ maiorSequencia _ = maiorSequencia
segmentoCrescAux (anterior:atual:resto) index maiorSequencia sequenciaAtual
  | atual > anterior = let sequenciaAtualizada = sequenciaAtual + 1
                       in if sequenciaAtualizada > maiorSequencia
                            then segmentoCrescAux (atual:resto) (index + 1) sequenciaAtualizada sequenciaAtualizada
                            else segmentoCrescAux (atual:resto) (index + 1) maiorSequencia sequenciaAtualizada
  | otherwise = segmentoCrescAux (atual:resto) (index + 1) maiorSequencia 1

segmentoCrescente :: [Int] -> Int
segmentoCrescente [] = 0
segmentoCrescente [_] = 1
segmentoCrescente (x:xs) = segmentoCrescAux (x:xs) 1 1 1

leInteiros :: String -> [Int]
leInteiros input = map read $ words input

main :: IO ()
main = do
   
    
   args <- getLine
    
   let numbers = leInteiros args

   let resultado = show $ segmentoCrescente numbers

   putStrLn resultado
