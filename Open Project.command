#!/bin/zsh
cd "${0:A:h}"
open .
if [[ -d "Ollama OpenEnd.app" ]]; then
  open "Ollama OpenEnd.app"
fi
