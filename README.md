# Connect-a-Caml

## OS X installation
This repository contains a Rake task that automates building the game and running tests. It requires
homebrew to find and install OCaml.

The happy path:

```
$ git clone git@github.com:ecmendenhall/connect-a-caml.git
$ cd connect-a-caml
$ rake
```

This will install OCaml, run specs, build a native binary, and start the game.

Other tasks:
- `rake deps` to install the OCaml dependencies
- `rake spec` to run unit tests
- `rake build` to build the game
- `rake clean` to remove build artifacts

To run the game once built:

```
$ ./TTT.native
```

_NB:_ If the rake task fails on the first run, Ocaml's package management configuration
may not have been sourced in your current terminal. Try opening a new one and
trying again before proceeding. An error like the one below means the Opam environment isn't sourced.
Try <code>eval `opam config env`</code> in the terminal to load it.

```
+ ocamlfind ocamldep -package Str -package ounit -modules Spec.ml > Spec.ml.depends
/bin/sh: ocamlfind: command not found
Command exited with code 127.
Compilation unsuccessful after building 1 target (0 cached) in 00:00:00.
rake aborted!
Command failed with status (10): [ocamlbuild Spec.native -pkg ounit -pkg Str...]
/Users/mike/projects/ttt/connor/Rakefile:70:in `block (2 levels) in <top (required)>'
/Users/mike/projects/ttt/connor/Rakefile:69:in `block in <top (required)>'
/Users/mike/.rvm/gems/ruby-1.9.3-p448/bin/ruby_noexec_wrapper:14:in `eval'
/Users/mike/.rvm/gems/ruby-1.9.3-p448/bin/ruby_noexec_wrapper:14:in `<main>'
Tasks: TOP => default => build => spec
(See full trace by running task with --trace)
```

The unhappy path:

Install OCaml:

```
$ brew install ocaml
```

Install opam, the OCaml package manager:

```
$ brew install opam
```

Set up opam and source its configuration:
```
$ opam init
$ eval `opam config env`
```

Install the oUnit test library:
```
$ opam install ounit
```

Once you've installed these requirements by hand, try Rake again. If it fails:

Build specs (from the project directory):
```
$ ocamlbuild Spec.native -pkg ounit -pkg Str -Is src,spec -use-ocamlfind
```

Build the game (from the project directory):
```
$ ocamlbuild TTT.native -Is src -pkg Str -use-ocamlfind
```

## The Game
Is Tic-Tac-Toe. Once it's built, just run:

```
$ ./TTT.native
```

The default configuration uses ANSI terminal colors, which should work in Terminal
and iTerm. If they don't work or you'd prefer something simpler, there are several
other views available from the command line by passing a flag argument:

```
$ ./TTT.native -f <format>
```
Options are:
- `-f normal` for a black-and-white, all-ASCII game.
- `-f emoji` for a game using basic emoji characters.
- `-f spooky` for a spooky, scary Halloween themed game.
- `-f camel` for a camel-themed game. (This would have been the default if the camels didn't look so similar).

Try them all and find your favorite!

## A Tour of OCaml
OCaml was invented in France and named after a stubborn land mammal, so it has some peculiarities.
Below are a few things I learned. Or, if you'd prefer an interactive tour,
check out [Try Ocaml](http://try.ocamlpro.com/)

### Types
OCaml is typed, but you won't see many type declarations. The compiler infers types from values and
optional signatures. New types are declared with the `type` keyword:

```
type gamepiece = X | O
```

This binds a type name (`gamepiece`) to a type constructor (`X` or `O`).
Type constructors can also take arguments:

```
type square = Empty | Full of gamepiece
type gamestate = Win of gamepiece | Draw | Pending
```

Here, a square is either `Empty`, `Full X`, or `Full O`.

Complex and nested types can get weird, but they're relatively easy to decode by
reading in reverse. For instance, a board has type `square list list`, which is a list of
lists of squares, like `[[Empty; Empty; Full X;]]`.

### Lists
Lists are semicolon-separated: `[1; 2; 3; 4; 5]`.

### Functions
The `let <name> =` construct binds a name to a value or function. If the thing after `let` is followed by `=`,
it's a value. If the thing after `let` is followed by more things, it's a function and those things are its
arguments.

```
let pi = 3.14

let circle_area radius =
  pi *. radius ** 2.0
```

Functions can also be declared anonymously:

```
# List.map (fun r -> pi *. r ** 2.0) [5.0; 10.0; 20.0];;
- : float list = [78.5; 314.; 1256.]
```

The body of a function contains both an implicit do (statements terminated with a semicolon are
evaluated for side effects) and an implicit return (the last thing in the body is the return value).

Ocaml functions are curried, so feeding a function fewer arguments than it expects returns a partial. You'll
see this often in combination with `List.map`.

### Interfaces
Like C, interfaces are specified in separate files from implementations. Interface files
end in `.mli` and describe names and type signatures for each function in a module. They can
be written by hand, or generated by a friendly OCaml compiler.

For example, the `IO` interface looks like this:

```
module type IO =
  sig
    val clear_screen: unit -> unit
    val get_input : unit -> string
    val show_board : Types.square list list -> unit
    val show_message : string -> Types.message -> unit
  end
```
You'll find the `unit` type hanging out around functions with side effects. A function that returns
nothing returns `unit`, so here `clear_screen` takes no arguments and returns no value, `get_input`
takes no args but returns a string, and `show_board` and `show_message` both take things and display
them without returning values.

An interesting thing: Module types are inferred based on the interface files OCaml finds on the
project build path. Any module that provides the four functions above will be recognized as type `IO`,
and substitutable for any other.

This example is a pure interface (there is no corresponding 'IO.ml' file), but every OCaml file is
a module, and every module has an interface.

### Pattern matching

Here's a function that takes a winning row and maps it to a
`Pending` or `Win` game state. Each pattern is tried in succession
(much like Lisp `cond` clauses), and the function returns the value
of the first guard that matches. Here, it's matching against the first
element in a winning row.

```
let row_state row =
  if (row_has_win row) then match List.hd row with
    | Empty  -> Pending
    | Full O -> Win O
    | Full X -> Win X
  else
    Pending
```

Notice that the first guard should never match, since a winning row should not
contain an `Empty` square. The OCaml compiler flags incomplete matches with a warning,
so it's included here only to placate it.

Even though pattern matching is totally rad, there are times when it's a _faux pas_ (French
intended)&mdash;mostly when it can be replaced with an `if` statement. Thus this:

```
let player_message symbol =
  let suffix = " be a [h]uman or [c]omputer?" in
  if symbol = X then
    IO.show_message ("Will Player X" ^ suffix) (Prompt X)
  else
    IO.show_message ("Will Player O" ^ suffix) (Prompt O)
```

is preferred to this:

```
let player_message symbol =
  let suffix = " be a [h]uman or [c]omputer?" in
  match symbol with
    | X -> IO.show_message ("Will Player X" ^ suffix) (Prompt X)
    | O -> IO.show_message ("Will Player O" ^ suffix) (Prompt O)
```

and this:

```
if valid_size size then size else get_size ()
```

to this:

```
match valid_size size with
  | true  -> size
  | false -> get_size ()
```

### Destructuring
The `::` symbol is the cons operator, which works just like `cons` in Lisp:

```
# 1 :: [];;
- : int list = [1]

# 1 :: 2 :: [];;
- : int list = [1; 2]
```

It's also used for destructuring patterns. Here, the first case checks
against the empty list, the second case extracts the first element, checks
it against `Full O` and ignores the rest, and the third case ignores the
first element and recurs on the rest of the list:

```
let rec contains_O row = match row with
  | []           -> false
  | Full O :: _  -> true
  | _ :: xs      -> contains_O xs
```

### Functors
Functors are functions that take modules as
parameters, plug those modules into a template, and return a new module _parameterized_ by those modules.
Which is all just a confusing way to say "functors do dependency injection."

For instance, I wanted to keep my `Game` module decoupled from I/O and player implementations, so I
use the following functor, that takes a module of type `IO` and two modules of type `PLAYER` as parameters.
(`ALL_CAPS` is the style for module types).

```
open IOInterface
open IOInterface
open PlayerInterface
open Engine

module GameFunctor (IO : IO) (PlayerX : PLAYER) (PlayerO : PLAYER) =
  struct
    open Types
    include Types

    let play_round turn board = match turn with
      | X -> PlayerX.next_move board
      | O -> PlayerO.next_move board

    let game_over_message state =
      let prefix = "Game over: " in
        match state with
          | Draw  -> IO.show_message (prefix ^ "it's a draw.") Info
          | Win X -> IO.show_message (prefix ^ "Player X wins.") (Prompt X)
          | Win O -> IO.show_message (prefix ^ "Player O wins.") (Prompt O)
          | _     -> ()

    let rec game_loop turn board =
      IO.show_board board;
      let next_turn = match turn with X -> O | O -> X in
        match Engine.board_state board with
          | Pending  -> game_loop next_turn (play_round next_turn board)
          | end_type -> game_over_message end_type
  end;;
```

elsewhere, I can construct a `Game` module dynamically and call its functions like any other:

```
let module Game = GameFunctor (JumbotronIO) (NeuralNetPlayer) (EvolutionaryPlayer)

let _ = Game.game_loop X (Board.empty_board 3)
```

### Type conversion
Idiomatic OCaml uses function names like `int_of_string` and `float_of_int` for casting one
type to another.

### Parentheses
Are used to control order of evaluation. Unfortunately, there is nothing like Haskell's `$` operator,
and it would probably be `€` anyways.

### Other symbols
The `^` operator concatenates strings. The `@` operator concatenates collections.

### More resources
- [Caml programming guidelines](http://caml.inria.fr/resources/doc/guides/guidelines.en.html)
- [OCaml style guide](http://www.cs.cornell.edu/courses/cs3110/2011sp/handouts/style.htm)
- [Official language documentation](http://caml.inria.fr/pub/docs/manual-ocaml/)
