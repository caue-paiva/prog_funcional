import Prelude 

raizQuadrada :: Floating a => a -> a
raizQuadrada x = sqrt x -- função de raiz quadrada padrão da linguagem


__eh_primo_aux :: Integer -> Integer -> Bool
__eh_primo_aux num_verificado comparacao
    | num_verificado <= 2 = True -- caso base 
    | comparacao > floor (sqrt (fromIntegral num_verificado)) = True -- se chegou em um valor após a raiz quadrada do valor
    | num_verificado `mod` comparacao == 0 = False -- se divisível então false
    | otherwise = __eh_primo_aux num_verificado (comparacao + 1) -- próxima comparação

__eh_primo :: Integer -> Bool
__eh_primo num = __eh_primo_aux num 2 -- começa verificando com 2 e segue até a raiz quadrada do número



__prox_primo_aux :: Integer -> Integer -> (Integer -> Integer) -> Integer
__prox_primo_aux num_inicial num_atual func_percorrer
    | __eh_primo num_atual && num_inicial /= num_atual = num_atual -- se é o próximo primo, retorna ele
    | otherwise = __prox_primo_aux num_inicial (func_percorrer num_atual) func_percorrer -- vai para o próximo

-- retorna o próximo primo a partir de um número (sem incluir ele)
__prox_primo :: Integer -> (Integer -> Integer) -> Integer
__prox_primo numero func_percorrer = __prox_primo_aux numero numero func_percorrer



__testa_intervalos_consec :: Integer -> Integer -> Integer -> Integer
__testa_intervalos_consec atual_primo maior_intervalo final = 
    let prox_num_primo = __prox_primo atual_primo (+1)
    in if prox_num_primo > final -- se o próximo passa do intervalo, o maior intervalo até agora é a resposta
        then maior_intervalo
        else let distan = prox_num_primo - atual_primo
            in if distan > maior_intervalo
                then __testa_intervalos_consec prox_num_primo distan final
                else __testa_intervalos_consec prox_num_primo maior_intervalo final 
-- procura o maior intervalo entre dois primos consecutivos dentro do intervalo dado


__maior_intervalo_consecutivo :: Integer -> Integer -> Integer
__maior_intervalo_consecutivo x y =
    let primeiro_primo = __prox_primo (x - 1) (+1)
    in __testa_intervalos_consec primeiro_primo 0 y
-- função base para iniciar procura









main :: IO ()
main = do
    
    
    l <- getLine
    let x = read l :: Integer -- lê x

    l <- getLine
    let y = read l :: Integer -- lê y

    let resposta = __maior_intervalo_consecutivo x y -- calcula o maior intervalor
    let saida = show resposta
    putStrLn saida -- exibe no terminal a resposta

-- Código feito por:
-- João Pedro Alves Notari Godoy - NUSP: 14582076
-- Cauê Paiva Lira - NUSP: 14675416
   