from typing import Callable, Any


def recursive_loop(value:Any, counter:int , break_condition:Callable[..., bool], increment_condi:Callable[[int],int ], value_change: Callable[[Any],Any])->Any:
    if break_condition(counter):
        return value
    next_counter = increment_condi(counter)

    new_value = value_change(value) 

    return (value +recursive_loop(new_value,next_counter,break_condition,increment_condi, value_change))


#print( recursive_loop(1,1, lambda x : x >= 2, lambda x : x+1, lambda x : x+1)  )

def soma_iter(n:int)->int:
    soma: int = 0
    for i in range(1,n+1):
        soma += i
    return soma



def soma_rec(a:int,n:int)->int:
    if (a > n):
        return 0
    
    return a + soma_rec(a+1,n)

def soma_rec2(i:int, soma:int, n:int):
      if i > n:
          return soma
      return soma_rec2(i+1,soma+i,n)

def func_maluca_rec(a,b,x,c,s):
    if x <= s-b:
        return x +c
    
    func_maluca_rec(a,b,a+b+c,c*x,s+a)


def func_maluca(a,b)->int:
     func_maluca_rec(a,b,a,a+1,0)

def somavec_rec(i,n,arr):
    if i >= n:
        return 0
    return arr[i] + somavec_rec(i+1,n,arr)

def somavec(arr):
    return somavec_rec(0,len(arr),arr)

def maior_vecrec(arr,i,n,maior,menor):
    if i >= n:
        return maior - menor
    
    if arr[i] > maior:
        maior = arr[i]
    if arr[i] < menor:
        menor = arr[i]
    return maior_vecrec(arr,i+1,n,maior,menor)

def maior_vec(arr):
    return maior_vecrec(arr,0,len(arr),-1_000_000, 1_000_000)

def teste(lista,func):
    return func(lista[0],lista[1])

#print(teste([1,2], lambda x,y: y if x > y else x ))

def select(a,func:Callable[[int], list]):
    if len(a) == 0:
        return []

    cabeca = func(a[0])
    #cabeca = [a[0]] if a[0] > 0 else []
    cauda = select(a[1:],func)

    return cabeca + cauda

def quick_sort(vec:list,compa_func:Callable)->list:
    if len(vec) <= 1:
        return vec
    
    pivot = vec[int(len(vec)/2)]
    return  (
            quick_sort(select(vec,lambda x : [x] if x < pivot else []), compa_func) +
            select(vec,lambda x : [x] if x == pivot else []) +
            quick_sort(select(vec,lambda x : [x] if x > pivot else []),compa_func)
            )

print(quick_sort([1,6,-1,9,7],lambda x: x))