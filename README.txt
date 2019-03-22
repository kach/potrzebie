Potrzebie is a smart, unit-aware desktop calculator, inspired by WolframAlpha
and Frink <https://frinklang.org>.

To hack on Potrzebie's core, you need a few things:
* OCaml, as installed by OPAM
  https://opam.ocaml.org
* ocamlbuild
  https://github.com/ocaml/ocamlbuild
* Menhir (via OPAM)
  http://gallium.inria.fr/~fpottier/menhir/
* js_of_ocaml (via OPAM)
  https://ocsigen.org/js_of_ocaml/3.1.0/manual/overview
Then you can compile with `make all`, which produces both a native binary and a
JavaScript blob for the web interface.

To hack on the standard library or web interface, just work with the relevant
HTML and JS files.
