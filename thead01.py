# Importação de biblioteca
import threading # Permite criar e gerenciar threads
import time      # Contém funções relacionadas a tempo, como a pausa
import math      # Importada, mas não é usada neste código

# Estrutura da Thread
def estrutura(nome, inicio, fim):
  # Define uma função que será executada por cada thread
  for i in range(inicio, fim + 1):
    # Loop que itera de 'inicio' até 'fim'
    print(f"{nome} -> {i} ")
    # Imprime o nome da thread e o número atual do loop
    # pausa entre as durações de contagem
    time.sleep(1) # Causa uma pausa de 1 segundo a cada iteração do loop

# Criar Thread
thread1 = threading.Thread(target=estrutura, args=("Thread-1", 1, 10))
# Cria a primeira thread. Ela irá executar a função 'estrutura'
# com o nome "Thread-1" e o intervalo de 1 a 10.
thread2 = threading.Thread(target=estrutura, args=("Thread-2", 50, 60))
# Cria a segunda thread. Ela irá executar a função 'estrutura'
# com o nome "Thread-2" e o intervalo de 50 a 60.

# Rodar
thread1.start()
# Inicia a execução da primeira thread.
thread2.start()
# Inicia a execução da segunda thread.

# Estado de Espera
thread1.join()
# O programa principal espera a 'thread1' terminar sua execução.
thread2.join()
# O programa principal espera a 'thread2' terminar sua execução.