# Minesweeper

Sua empresa está criando um jogo de campo minado (Minesweeper), e precisa da sua ajuda para construir a engine em Ruby 
que gerencia o estado do jogo e as jogadas. O jogo será lançado em vários dispositivos, e cada um deles será responsável 
pelo tratamento de input e output para o usuário. Sua engine deve fornecer uma interface de métodos que podem ser chamados 
pelo cliente para interagir com o jogo: clicar em uma célula, saber o status do tabuleiro, saber se o jogo já acabou etc.

Nota: usamos a terminologia "clicar" para traçar uma analogia com uma jogada de escolher uma célula no campo minado. 
Clicar, literalmente, não faz parte deste exercício; não é necessária uma interface gráfica.


## Requisitos:

1. No início do jogo, a engine deve aceitar parâmetros de altura, largura e número de bombas no tabuleiro. As bombas 
devem ser distribuídas aleatoriamente, de forma que todas as combinações de posições possíveis tenham a mesma probabilidade 
de acontecer.

2. Sua engine deve expor um conjunto mínimo de métodos para o cliente:

  - play: recebe as coordenadas x e y do tabuleiro e clica na célula correspondente; a célula passa a ser "descoberta". 
Deve retornar um booleano informando se a jogada foi válida. A jogada é válida somente se a célula selecionada ainda 
não foi clicada e ainda não tem uma bandeira. Caso a célula clicada seja válida, não tenha uma bomba e seja vizinha 
de zero bombas, todos os vizinhos sem bomba e sem bandeira daquela célula também devem ser descobertas, e devem seguir 
esta mesma lógica para seus próprios vizinhos (esse é o comportamento de expansão quando clicamos em uma grande área 
sem bombas no jogo de campo minado).

  - flag: adiciona uma bandeira a uma célula ainda não clicada ou remove a bandeira preexistente de uma célula. Retorna 
um booleano informando se a jogada foi válida.

  - still_playing?: retorna true se o jogo ainda está em andamento, ou false se o jogador tiver alcançado a condição de 
vitória (todas as células sem bomba foram descobertas) ou de derrota (jogador clicou em uma célula sem bandeira e ela tinha uma bomba).

  - victory?: retorna true somente se o jogo já acabou e o jogador ganhou.

  - board_state: retorna uma representação atual do tabuleiro, indicando quais células ainda não foram descobertas, 
se alguma foi descoberta e tem uma bomba, quais foram descobertas e têm células com bombas como vizinhas (indicar quantas 
são as vizinhas minadas), quais não estão descobertas e com bandeira. Se o cliente passar o hash {xray: true} como parâmetro, 
deve indicar a localização de todas as bombas, mas somente se o jogo estiver terminado.


3. Uma célula descoberta deve saber informar o número de bombas adjacentes a ela, se houver alguma (entre 1 e 8). Se não 
tiver bombas adjacentes, deve ser considerada uma célula descoberta e vazia.

4. Crie pelo menos dois tipos de objeto "printer" que mostrem no terminal o estado do tabuleiro. Esses printers servem 
como exemplo de como um cliente pode consumir o método "board_state" da sua engine. Por exemplo, um deles pode simplesmente 
imprimir uma matriz mapeando os estados para caracteres segundo a especificação:

```ruby
board_format = {
  unknown_cell: '.',
  clear_cell: ' ',
  bomb: '#',
  flag: 'F'
}
```

5. Ao efetuar uma jogada em uma bomba (sem bandeira), o jogo deve terminar e nenhuma outra jogada subsequente deve ser considerada válida.

6. Demonstre, da maneira que achar melhor, que o seu projeto funciona como especificado.

## Instalação

Adicione esta linha no Gemfile de sua aplicação:

```ruby
gem 'engine'
```

Então execute:

    $ bundle

Ou instale:

    $ gem install engine

## Uso

```ruby
width, height, num_mines = 10, 20, 50
game = Minesweeper.new(width, height, num_mines)

while game.still_playing?
  valid_move = game.play(rand(width), rand(height))
  valid_flag = game.flag(rand(width), rand(height))
  if valid_move or valid_flag
  printer = (rand > 0.5) ? SimplePrinter.new : PrettyPrinter.new
  printer.print(game.board_state)
  end
end

puts "Fim do jogo!"
if game.victory?
  puts "Você venceu!"
else
  puts "Você perdeu! As minas eram:"
  PrettyPrinter.new.print(game.board_state(xray: true))
end
```

## Desenvolvimento

* `bin/setup` para instalar as dependencias.
* `rake spec` para executar os testes. 
* `bin/console` para utilizar um prompt interativo.
* `bundle exec rake install` para instalar esta gem.
* `bundle exec rake release` para lançar uma nova versão, atualize `version.rb`.

## Licença

Esta gem é de código aberto sobre os termos [MIT License](http://opensource.org/licenses/MIT).

