

jogadas:list = [ 1, 4, 4, 5, 6, 4, 5, 5, 10, 0, 1, 7, 3, 6, 4, 10, 2, 8, 6 ]

def jogadas_aux(
      list_jogadas:list, 
      index:int, 
      qntd_bonus:int,
      poder_bonus:int, 
      arremeso_ante_rodada:int,
      score:int 
   )->tuple[list, int]:

   pinos_derrubados: int = list_jogadas[index]

   if arremeso_ante_rodada == -1: #primeira jogada
      if pinos_derrubados == 10: #strike
         novo_poder_bonus = poder_bonus + 1
         novo_tem_bonus  = True
   else: #segunda jogada
      if arremeso_ante_rodada + pinos_derrubados == 10 : #sparrow
         novo_poder_bonus = poder_bonus + 1
         novo_tem_bonus  = True
   
   if qntd_bonus > 0:
      novo_score = score  + (pinos_derrubados * (poder_bonus +1)) 
      novo_qntd_bonus = qntd_bonus - 1
   else:
      novo_score = score + pinos_derrubados
      
   

