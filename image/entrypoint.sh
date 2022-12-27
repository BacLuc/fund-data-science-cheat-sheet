#!/bin/sh

if [ "$1" = "default" ]; then
  pdflatex_path=$(which pdflatex)
  cmd="$pdflatex_path -output-format=pdf -halt-on-error"
  cmd="$cmd -interaction=nonstopmode"
  cmd="$cmd -output-directory=/out ${LATEX_MAIN_FILE}"
  exec $cmd
fi

if [ "$1" = "format" ]; then
  cmd="prettier --write ."
  exec $cmd
fi

if [ "$1" = "check-format" ]; then
  cmd="prettier --check ."
  exec $cmd
fi

exec "$@"
