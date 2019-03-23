all: _build/unitjs.js stdlib.js _build/unitml.native
	# easy

stdlib.js: stdlib.p
	echo '// THIS FILE WAS AUTOMATICALLY GENERATED.' > stdlib.js
	echo 'var SI = `' >> stdlib.js
	cat stdlib.p >> stdlib.js
	echo '`.split("\\n")' >> stdlib.js

_build/unitjs.js:    parser.mly lexer.mll units.ml ast.ml math.ml unitjs.ml
	ocamlbuild -use-ocamlfind -use-menhir -package js_of_ocaml -package js_of_ocaml-ppx unitjs.byte
	js_of_ocaml _build/unitjs.byte

_build/unitml.native: parser.mly lexer.mll units.ml ast.ml math.ml unitml.ml
	ocamlbuild -use-menhir unitml.native

clean:
	rm -rf _build/ *.native *.byte

.PHONY: clean
