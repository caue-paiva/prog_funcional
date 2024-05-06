
main :: IO ()
main = do
    
    
    l <- getLine
    let x = read l :: Integer -- lê x

    l <- getLine
    let y = read l :: Integer -- lê y

    putStrLn saida -- exibe no terminal a resposta