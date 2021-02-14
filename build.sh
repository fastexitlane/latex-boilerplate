#!/bin/bash

# cleanup
latexmk -C
if [ -f chapter/out.tex ]
then
    rm chapter/out.md
    rm chapter/out.tex
fi

# run pandoc
if [ $1 == "pandoc" ]
then
    cat chapter/*.md > chapter/out.md
    pandoc --lua-filter templates/germanquotes.lua --citeproc --filter pandoc-crossref \
        -M cref=true --top-level-division=chapter \
        --bibliography library/library.bib --biblatex \
        -o chapter/out.tex chapter/out.md
fi

# run latex build
if [ $1 != "clean" ]
then
    latexmk -latexoption="-shell-escape" main.tex
fi
