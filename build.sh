#!/bin/bash

function run_clean {
    latexmk -C

    if [ -f main.bbl ]
    then
    rm main.bbl
    fi

    if [ -f main.lol ]
    then
    rm main.lol
    fi

    if [ -f main.ptc ]
    then
    rm main.ptc
    fi

    if [ -f main.run.xml ]
    then
    rm main.run.xml
    fi

    if [ -f chapter/out.tex ]
    then
        rm chapter/out.md
        rm chapter/out.tex
    fi

    shopt -s nullglob
    for f in appendix/generated/*.tex
    do
        rm $f
    done
}

function run_pandoc {
    if [ -f chapter/out.tex ]
    then
        rm chapter/out.md
        rm chapter/out.tex
    fi
    
    cat chapter/*.md > chapter/out.md
    pandoc --lua-filter templates/germanquotes.lua --citeproc --filter pandoc-crossref \
        -M cref=true --top-level-division=chapter \
        --bibliography library/library.bib --biblatex \
        -o chapter/out.tex chapter/out.md
}

function run_latexmk {
    latexmk -latexoption="-shell-escape" main.tex
}

function run_pandoc_appendix {
    shopt -s nullglob
    
    for f in appendix/generated/*.tex
    do
        rm $f
    done

    for f in appendix/*.md
    do
        filename=$(basename -- "$f")
        filename="${filename%.*}"
        pandoc --lua-filter templates/germanquotes.lua --citeproc --filter pandoc-crossref \
        -M cref=true --top-level-division=chapter \
        --bibliography library/library.bib --biblatex \
        -o appendix/generated/$filename.tex appendix/$filename.md
    done
}

case $1 in
    "clean")
        run_clean
        ;;
    "pandoc")
        run_pandoc
        run_pandoc_appendix
        run_latexmk
        ;;
    "latex")
        run_latexmk
        ;;
    "appendix")
        run_pandoc_appendix
        ;;
    *)
        echo $"Usage: $0 {clean|pandoc|latex}"
        exit 1
esac
