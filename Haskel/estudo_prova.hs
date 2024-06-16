import Data.List


ultimo :: [a] -> a -> a
ultimo [] a = a
ultimo (x:xs) a = ultimo xs x 


main = do
   let list = [1,2,3,4]

   print $ show $ ultimo $ list