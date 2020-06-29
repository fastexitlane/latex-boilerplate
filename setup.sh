#!/bin/bash

function write_help {
    echo "Usage:"
    echo "    ./setup.sh markdown    Setup Boilerplate for usage with Markdown"
    echo "    ./setup.sh latex       Setup Boilerplate for usage with LaTex"
}

if [ $# == 0 ]
then
    write_help
    exit 1
fi
    
if [ $1 == "markdown" ]
then
    cp templates/markdown.gitlab-ci.yml ./.gitlab-ci.yml
    cp templates/markdown.azure-pipelines.yml ./azure-pipelines.yml
    cp templates/markdown.tasks.json ./.vscode/tasks.json
elif [ $1 == "latex" ]
then
    cp templates/latex.gitlab-ci.yml ./.gitlab-ci.yml
    cp templates/latex.azure-pipelines.yml ./azure-pipelines.yml
    cp templates/latex.tasks.json ./.vscode/tasks.json
else
    write_help
fi
