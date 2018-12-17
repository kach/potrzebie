all: _build/unitjs.js _build/unitml.native
	# easy

_build/unitjs.js:    parser.mly lexer.mll units.ml ast.ml math.ml unitjs.ml
	ocamlbuild -use-ocamlfind -use-menhir -package js_of_ocaml -package js_of_ocaml-ppx unitjs.byte
	js_of_ocaml _build/unitjs.byte

_build/unitml.native: parser.mly lexer.mll units.ml ast.ml math.ml unitml.ml
	ocamlbuild -use-menhir unitml.native

clean:
	rm -rf _build/ *.native *.byte

.PHONY: clean
