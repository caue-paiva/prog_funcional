from typing import Callable
import math

#comparacao é chamada com 2



def __eh_primo(num_verificado:int,comparacao:int)->bool:
    if num_verificado <= 2: #caso base simples
        return True

    if comparacao > int(math.sqrt(num_verificado)):
        return True
   
    if num_verificado % comparacao == 0:
        return False
    
    return __eh_primo(num_verificado,comparacao+1)

def eh_primo(numero:int)->bool:
   return __eh_primo(numero,2)

def __prox_primo(num_inicial:int,num_atual:int,func_percorrer: Callable[[int],int])->int:   
   if eh_primo(num_atual) and num_inicial != num_atual:
       return num_atual
   
   novo_index: int = func_percorrer(num_atual)
   return __prox_primo(num_inicial ,novo_index,func_percorrer)

#retorna o prox primo a partir de um numero (sem incluir ele)
def prox_primo(numero:int, func_percorrer: Callable[[int],int])->int:
    return __prox_primo(numero,numero,func_percorrer)

def maior_intervalo_geral(x:int,y:int)->int:
    primo_perto_x: int = prox_primo(x-1,  lambda x: x+1)
    primo_perto_y: int = prox_primo(y+1,  lambda x: x-1)

    return primo_perto_y - primo_perto_x


"""
def testa_intervalos_consec(atual_primo:int,maior_intervalo:int ,final:int)->int:
   if atual_primo >= final:
      return maior_intervalo
   
   prox_num_primo:int = prox_primo(atual_primo,lambda x: x+1)
   distan:int = prox_num_primo - atual_primo

   if distan > maior_intervalo:
       return testa_intervalos_consec(prox_num_primo,distan,final) #novo maior intervalo sera a distancia
   else:
       return testa_intervalos_consec(prox_num_primo,maior_intervalo,final)#intervalo antigo é maior


def maior_intervalo_consecutivo(x:int,y:int)->int:
    primeiro_primo:int = prox_primo(x-1 , lambda x: x+1) #primeiro primo a partir de x-1, então vamos incluir o x caso ele seja primo
    return testa_intervalos_consec(primeiro_primo,-1,y)
"""

x = int(input())
y = int(input())

print(maior_intervalo_geral(x,y))

