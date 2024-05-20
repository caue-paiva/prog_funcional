
def jogadas_aux(
      list_jogadas:list, 
      index:int, 
      list_bonus:list,
      arremeso_ante_rodada:int,
      rodada_atual:int,
      score:int 
   )->tuple[list, int]:

   if index >= len(list_jogadas):
      return score

   pinos_derrubados: int = list_jogadas[index]
   if list_bonus:
      novo_score = score + ((list_bonus[0] + 1) * pinos_derrubados )   # vai adicionar a quantidade correta de pontos 
   else:
      novo_score = score +  pinos_derrubados
   
   novo_arremeso_ante:int

   if arremeso_ante_rodada == -1: #primeira jogada
      if pinos_derrubados == 10 and rodada_atual < 10: #strike sem ser no 10
         nova_list_bonus = calcula_bonus(list_bonus[1:], 2)   #strike normal
         nova_rodada = rodada_atual + 1
         novo_arremeso_ante = -1
      else:
         nova_list_bonus = calcula_bonus(list_bonus[1:], 0)  
         nova_rodada = rodada_atual
         novo_arremeso_ante = pinos_derrubados

 
   else: #segunda jogada
      nova_rodada = rodada_atual + 1
      novo_arremeso_ante = -1

      if arremeso_ante_rodada + pinos_derrubados == 10 and rodada_atual < 10 : #spare
         nova_list_bonus = calcula_bonus(list_bonus[1:], 1)
      else:
         nova_list_bonus = calcula_bonus(list_bonus[1:], 0)  

   # não teve bônus
   return jogadas_aux(list_jogadas, index + 1, nova_list_bonus, novo_arremeso_ante,nova_rodada, novo_score)



#calculo de qual sera os bonus seguintes              
def calcula_bonus(list_bonus:list[int], opcao:int)->list[int]: #0 -> norma, 1 -> spare, 2-> strike
     if not list_bonus:
         lista_intermed = [0]
     else:
         lista_intermed = list_bonus

     if opcao == 0:
          return list_bonus
     
     elif opcao == 1: #spare 
         nova_lista = [lista_intermed[0] + 1]
         return nova_lista
     else: #strike 
          nova_lista = [lista_intermed[0] + 1, 1]
          return nova_lista
          
def joga_boliche(lista_jogadas:list[int])->int:
    return jogadas_aux(lista_jogadas,0,[0],-1,1,0)  

jogadas:list = [ 1, 4, 4, 5, 6, 4, 5, 5, 10, 0, 1, 7, 3, 6, 4, 10, 2, 8, 6 ]
jogadas2:list = [10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10]
print(joga_boliche(jogadas2))
   
