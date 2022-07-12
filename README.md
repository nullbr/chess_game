## [Chess](https://replit.com/@nullbr/chessgame)

A classic Chess game, written in Ruby. It was developed applying Test Driven Development techniques, automating tests with RSpec. This was the final project from TheOddinProject Ruby programming curriculum. The game can be played as multiplayer or against an artificial intelligence (under development). Play it at [Replit](https://replit.com/@nullbr/chessgame)!

<div style="display: inline_block">

  <img alt="Ruby" width="31%" src="https://user-images.githubusercontent.com/94543524/176027193-9a1a208f-87b0-4675-8bbb-5b7100d6cabb.jpg">
  <img alt="Ruby" width="65%" src="https://user-images.githubusercontent.com/94543524/176027212-5d367530-d76e-4120-8325-1cf1fc20ab3e.jpg">
  
</div>

## Rules

If you’ve never played, be sure to read up on the rules (see the [Wikipedia Page](https://en.wikipedia.org/wiki/Chess)) first. Also checkout [Chess.com](https://www.chess.com/learn-how-to-play-chess)

The game is played using chess notation

K: King, Q: Queen, B: Bishop, R: Rook, N: Knight, P: Pawn

x: Capturing, =: Promoting to , +: Check, #: Checkmate

Here's a few examples:

```
     e4 | Pawn (P ommited) to e4
    Nc4 | Knight to c4
   Qd7+ | Queen to d7, + representing a check
  Kxb5# | King captures at b5, # representing a checkmate
   exf6 | Pawn (from column e) captures at f6
 fxg7=Q | Pawn (from column f) captures at g7 and gets promoted to a Queen
```

## Dependencies

Ruby: 
- "3.1.2"

Gems:
- rspec
- ruby_figlet
- colorize

