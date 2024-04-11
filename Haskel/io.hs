
main :: IO()
main = do
   putStrLn "ola"
   l <- getLine
   let    v :: Integer 
          v = read l

   l2 <- getLine
   let    v2 :: Integer 
          v2 = read l2
   let soma = v + v2

   let str = show soma

   putStrLn str