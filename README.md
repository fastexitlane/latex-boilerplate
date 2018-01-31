# LaTex Boilerplate

This is a simple preconfigured boilerplate for medium-sized LaTex projects including continuous integration for GitLab CI.
It's based on the `scrartcl` document class and currently layed out for german scientiefic documents.


## Basic Structure
The main entry point for the document compilation is the file `main.tex` in the repo root.
Besides setting some common parameters for the document (like author name, title, date etc.), the basic document structure is created here (mostly by including seperate files) in the following order:

* configuration (`configuration/config.tex`)
* title page (`config/title.tex`)
* table of contents
* list of acronyms (`config/abkuerzungen.tex`)
* list of figures
* list of tables
* list of code listings
* chapter files (`chapter/*`, needs to be filled up manually)
* bibliography (`config/quellenverzeichnis.tex`, using the entries defined in `library/library.bib`)
* declaration of authorship (`config/ehrenwoertliche_erklaerung.tex`)

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
| web pages             | `@Misc`                | `web`   |
| legislative documents |                        | `leg`   |
| company internal docs | `@Misc`                | `comp`  |


References within the document are usually done using the `\autocite` statement.
The default citation format is footnote.
When referencing within a footnote, please create a manual reference using `\cite`.

**(!)** For the references to be syntactically complete and correct, pleae consider the correct document types shown in the table above.


## Layout and further configuration
The predefined document layout is the following:

* page size: A4
* borders: left=40mm, right=20mm, top=25mm, bottom=25mm (using `geometry`)

Further configuration can be done in `config/config.tex`.


## Continuous Integration
The `.gitlab-ci.yml` file comes preconfigured to compile `main.tex` (and everything included here) to PDF using `pdflatex`.
Build output is the file `main.pdf` that can be downloaded from GitLab coordinator for two days (each pipeline run).

**(!)** Please adapt the configuration to your own runner setup if neccessary.


## Some special effects...
### Lists
Please use `\compactitem` environment for unordered lists and `\compactenum` environment for ordered lists.

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
If you introduce acronyms, add them to `config/abkuerzungen.tex` in the following way:

```latex
\acro{VMCS}{Virtual Machine Control Structure}
```

**(i)** Please note: If you have acronyms that are longer than four characters, you may extend the parameter in brackets behind the `\begin{acronym}` statement.

### Code Listings
Listings (code snippets) are done using the `\lstlisting` environment.
It can have it's own caption, positioned with the parameter `captionpos` (see official docs):

```latex
\begin{lstlisting}[caption=caption goes here,captionpos=b]
    // code goes here...
\end{lstlisting}
```

Config for syntax highlighting is centrally provided in `config/config.tex` using the `\lstset` directive (defaulting to `C#` in this boilerplate).
It may be done individually for each listing.
Please see official docs for that.

### Paragraph distances
You may wrap the blocks (lists, images, tables, paragraphs etc.) with a

```latex
\vspace{-\topsep}
```

if the paragraph distances above and/or below seem too large to you.
