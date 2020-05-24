# LaTex Boilerplate
This is a simple preconfigured boilerplate for medium-sized LaTex projects including continuous integration for GitLab CI.
It's based on the `scrbook` document class and currently layed out for german scientiefic documents.
Furthermore, it provides the possibility to write documents in Markdown instead of LaTex.


## Getting Started
To use this template in a new project, either download the [ZIP](https://gitlab.com/fastexitlane/latex-boilerplate/-/archive/master/latex-boilerplate-master.zip) directly from GitLab or clone it using Git:

```bash
git@gitlab.com:fastexitlane/latex-boilerplate.git
# now set up your own Git workspace:
git remote remove origin
git remote add origin git@your-own-gitlab.host:path/to/repo.git
git push origin master
```

If you already have set up an empty Git workspace for your project, add it as additional remote and then fetch and pull:

```bash
git remote add boilerplate git@gitlab.com:fastexitlane/latex-boilerplate.git
git fetch boilerplate
git pull boilerplate master
# if you don't want to keep the remote for pulling future updates, remove it:
git remote remove boilerplate
```

In order to use the preconfigured CI / CD pipeline for building PDFs, copy either `latex.gitlab-ci.yml` or `markdown.gitlab-ci.yml` to `.gitlab-ci`, depending on which workflow you want to use.
On GitLab.com, this will use Dockerized builds by default.
If you want to use the workflow on own hardware, make sure your GitLab CI meets the [Basic Requirements](https://gitlab.com/fastexitlane/latex-boilerplate/wikis/GitLab-CI#basic-requirements).

If you know what you're doing, simply start adding your content files in `chapter/` as LaTex `\chapter`s and `\input` them into `main.tex`.
If you do not know what you're doing or get into trouble - or want to use the **Markdown Workflow**, you may want to consider the [wiki](https://gitlab.com/fastexitlane/latex-boilerplate/wikis/home) ;-)


## Docker Images
If you need a Docker image to build your documents, head over to [pandoc-latex](https://github.com/fastexitlane/pandoc-latex) ([DockerHub](https://hub.docker.com/r/fastexitlane/pandoc-latex)).
Also, there's a prebuilt Docker image for spellchecking using Hunspell - head over to [docker-hunspell](https://github.com/fastexitlane/docker-hunspell).