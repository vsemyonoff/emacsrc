#!/usr/bin/env bash

aspell --dict-dir=${PWD} -l ru -d ru-yeyo dump master \
    |  aspell --dict-dir=${PWD} -l ru expand \
    |  perl -e 'while(<>){ print join("\n", split), "\n";}' > ru-en.wl

aspell -l en -d en_US dump master \
    | aspell -l en expand >> ru-en.wl

aspell --dict-dir=${PWD} --lang=ru --encoding=utf-8 create master ./ru-en.rws < ru-en.wl
