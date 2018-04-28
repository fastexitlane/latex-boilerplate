# LaTex Boilerplate

This is a simple preconfigured boilerplate for medium-sized LaTex projects including continuous integration for GitLab CI.
It's based on the `scrbook` document class and currently layed out for german scientiefic documents.

<!-- TOC -->

- [Getting Started](#getting-started)
- [Basic Structure](#basic-structure)
- [Inserting basic content](#inserting-basic-content)
- [Bibliography](#bibliography)
- [Layout and further configuration](#layout-and-further-configuration)
- [Document Outline](#document-outline)
- [Continuous Integration using GitLab CI](#continuous-integration-using-gitlab-ci)
    - [Basic Requirements](#basic-requirements)
    - [Spellchecking](#spellchecking)
    - [Building the PDF](#building-the-pdf)
- [Some special effects...](#some-special-effects)
    - [Lists](#lists)
    - [Images](#images)
    - [Acronyms](#acronyms)
    - [Code Listings](#code-listings)
    - [Paragraph Distances and Onehalf Spacing](#paragraph-distances-and-onehalf-spacing)

<!-- /TOC -->

***

## Getting Started
To use this template in a new project, either download the [ZIP](https://github.com/fastexitlane/latex-boilerplate/archive/master.zip) directly from GitHub or clone it using Git:

```bash
git clone git@github.com:fastexitlane/latex-boilerplate.git
# now set up your own Git workspace:
git remote remove origin
git remote add origin git@your-own-gitlab.host:path/to/repo.git
git push origin master
```

If you already have set up an empty Git workspace for your project, add it as additional remote and then fetch and pull:

```bash
git remote add boilerplate git@github.com:fastexitlane/latex-boilerplate.git
git fetch boilerplate
git pull boilerplate master
# if you don't want to keep the remote, remove it:
git remote remove boilerplate
```

In order to use the preconfigured continuous integration, make sure your GitLab CI meets the [Basic Requirements](#basic-requirements).

If you know what you're doing, simply start adding your content files in `chapter/` and `\input` them in `main.tex`.
If you do not know what you're doing or get into trouble, you may want to read on. ;-)


## Basic Structure
The main entry point for the document compilation is the file `main.tex` in the repo root.
Besides setting some common parameters for the document (like author name, title, date etc.), the basic document structure is created here (mostly by including seperate files) in the following order:

* configuration (`config/config.tex`)
* title page (`additionals/title.tex`)
* disclosure notice (`additionals/disclosure.tex`, decomment in `main.tex` if neccessary)
* table of contents
* list of acronyms (`additionals/acronyms.tex`)
* list of figures
* list of tables
* list of code listings
* chapter files (`chapter/*`, needs to be filled up manually)
* bibliography (`config/references.tex`, using the entries defined in `library/library.bib`)
* declaration of authorship (`additionals/affirmation.tex`)

If you don't need one of the predefined document parts or want to omit it, simply remove or comment out the corresponding statements in `main.tex`.

**(i)** Please note: Before starting with content, you should change the common variables in `main.tex`.


## Inserting basic content
For each chapter create a single chapter file in the `chapter/` directory.
Chapter files need to reference the main file using

```latex
%!TEX root = ../main.tex
```

Next, include it in `main.tex` using

```latex
\input{chapter/myfile}
\newpage
```

Numbering the files with prefixes (like `01_introduction`) is recommended.


## Bibliography
The bibliography index uses `biblatex`.
Entries are taken from `library/library.bib`, you may add your PDF files here too and link them to the bibliography entries (e.g. using biblatex frontend/gui tools like *JabRef*).

To be included in the document, every bibliography entry needs to be keyword-classified manually.
For each keyword there will be a seperate subsection in the bibliography section in the document.
If there's no bibliography entry for a keyword, the bibliography type will be ommitted and no subsection will be created in the bibliography section in the document.

Here's an overview of the supported document types and their keywords:

| type                  | biblatex document type | keyword |
|-----------------------|------------------------|---------|
| monographs            | `@Book`                | `mono`  |
| essays                | `@Article`             | `mag`   |
| articles              | `@Article`             | `art`   |
| web pages             | `@Online`              | `web`   |
| legislative documents |                        | `leg`   |
| company internal docs | `@Misc`                | `comp`  |


References within the document are usually done using the `\autocite[prefix][postfix]{bibkey}` statement.
The default citation format is footnote.
When referencing within a footnote, please create a manual reference using `\cite`.

**(!)** For the references to be syntactically complete and correct, pleae consider the correct document types shown in the table above.


## Layout and further configuration
The predefined document layout is the following:

* page size: A4
* borders: left=40mm, right=20mm, top=25mm, bottom=25mm (using `geometry`)
* Roman page numbering is used for introductory pages; arabic page numbering starts with first content chapter (see `main.tex` for that)

Further configuration can be done in `config/config.tex`.


## Document Outline
The `scrbook` document class provides the following elements (in said order) to outlining a document:

* `\part{}`: roman numbering, e.g. *I*
* `\chapter{}`: arabic 1st level numbering, e.g. *1*
* `\section{}`: arabic 2nd level numbering, e.g. *1.1*
* `\subsection{}`: arabic 3rd level numbering, e.g. *1.1.1*
* `\subsubsection{}`: arabic 3rd level numbering, e.g. *1.1.1.1*
* `\paragraph{}`: no numbering and independent from preceding hierarchy elements


## Continuous Integration using GitLab CI
The `.gitlab-ci.yml` file comes preconfigured to spellcheck and compile the LaTex document.

### Basic Requirements
If you want to use the preconfigured CI scripts, you need to register a shell runner which basically has the following tools installed:

* `latexmk` as LaTex build system
* `xelatex` as LaTex PDF environment
* Python and the Pygments library (for source code listings using the `minted` environment)
* `hunspell` for spellchecks

The provided configuration `gitlab-ci.yml` assumes that you have rununers with the tags `hunspell` and `latex` assigned.
It's recommended to register at least two runners (they may reside on the same box) in order to parallelize pipelines and speed up builds.

**(!)** Please adapt the configuration to your own runner setup if neccessary.

### Spellchecking
Spellchecking is done using `hunspell`.
As LaTex `\input` directives are not recognized, all TeX files containing content need to be spellchecked seperately.
Therefore, only the `chapter` files are included in the spellcheck.

If you need certain words to be ignored during spellcheck (e.g. if they're not in the standard dictionaries), please insert them into the file `.hunspellignore`.
This is a simple word list structured by one word per line.

By default, the spellcheck job is allowed to fail.

### Building the PDF
The CI pipeline will build `main.tex` (and everything included here) to PDF using `xelatex`.
It provides better handling of unicode characters and typesets special characters (like german umlauts) more precise.

The build output is generated to `main.pdf`, which can be downloaded from GitLab coordinator for two days (each pipeline run).


## Some special effects...
### Lists
Please use `\compactitem` environment for unordered lists and `\compactenum` environment for ordered lists.
Unlike the usual itemization environments they do not break lines with the usual paragraph spacing (which would be way too much due to the `\onehalfspacing`).

### Images
Resource files for images may be stored in `resources/`.
To reference an image from within the document, use the `figure` environment:

```latex
\begin{figure}[H]
    \centering
    \fbox{\includegraphics[width=0.75\textwidth]{resources/myimage.png}}
    \caption{Caption for my image goes here...}
    \label{fig:myimage}
    \source{source of the image}
\end{figure}
```

The `\label` is used to cross-reference the image using `\ref`.

The `\caption` may contain a usual `\cite` directive (see below).

### Acronyms
If you introduce acronyms, add them to `additionals/acronyms.tex` in the following way:

```latex
\acro{VMCS}{Virtual Machine Control Structure}
```

**(i)** Please note: If you have acronyms that are longer than four characters, you may extend the parameter in brackets behind the `\begin{acronym}` statement.

### Code Listings
Listings (code snippets) are done using the `minted` environment.
It provides syntax highlighting for several languages via an external Python library (*Pygments*) and has comprehensive layout capabilities.
Though, handling of captions is a bit complicated, which is why it's wrapped into a custom `code` environment:

```latex
\begin{code}
    \inputminted{bash}{resources/yoursource.sh}
    \label{yourlabel}
    \captionof{listing}{Some Caption goes here...}
    \source{and you can tell people where you got the code from...}
\end{code}
```

If you want to provide your source code directly in the LaTex document, replace the `\inputminted` directive by a whole `minted environment`:

```latex
\begin{code}
    \begin{minted}{bash}
        # your code goes here...
    \end{minted}
    \label{yourlabel}
    \captionof{listing}{Some Caption goes here...}
    \source{and you can tell people where you got the code from...}
\end{code}
```

Inline code is done using `\mintinline{bash}{# your inline snippet}`.

The config for syntax highlighting etc. is centrally provided in `config/config.tex` using the `\setminted` directive.
For changes, see the official docs.

### Paragraph Distances and Onehalf Spacing
There are certain LaTex environments that cause huge paragraph distances in combination with the `onehalfspacing` option (1.5 line height).
For that reason you may wrap such environments (e.g. lists, images, tables, paragraphs etc.) with a `vspace`:

```latex
\vspace{-\topsep}
```
