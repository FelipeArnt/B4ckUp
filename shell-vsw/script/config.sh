#!/usr/bin/env bash

echo "Script para configurar o ambiente linux para a shell e seus comandos."

configurar_comandos() {
  sudo mv ../out /usr/local/bin/vsw
  sudo mv build.sh /usr/local/bin/b
  sudo mv clean.sh /usr/local/bin/c
  sudo mv router.sh /usr/local/bin/roteador
  sudo mv tvbox.sh /usr/local/bin/tvbox

}
main() {
  configurar_comandos
}

main "@$"
