
main :: IO()
main = do
   putStrLn "ola"
   l <- getLine
   let    v :: Integer 
          v = read l
   putStrLn  "saiu"