
arr1 = [1,1,2,2,3,3]
arr2 = [3,5,6,8,4]
arr3 = [5,5,5]


def segmento_cresc_aux(arr:list, index:int, maior_sequencia:int, sequencia_atual:int)->int:
   if (len(arr) <= index):
      return maior_sequencia
   
   anterior = arr[index-1]
   atual = arr[index]

   if atual > anterior:
      sequencia_atual+=1
   else:
      sequencia_atual = 1
      
   if sequencia_atual > maior_sequencia:
      maior_sequencia = sequencia_atual

   return segmento_cresc_aux(arr,index+1,maior_sequencia,sequencia_atual)

def segmento_crescente(arr)->int:
   return segmento_cresc_aux(arr,1,1,1)

print(segmento_crescente(arr3))