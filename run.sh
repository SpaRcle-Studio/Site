clear

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

is_need_install_deps=true
is_debug=false
is_gunicorn_active=false

# Обработка аргументов командной строки
while [ "$1" != "" ]; do
    case $1 in
        --help )    
            ;;
        --nodeps )
            is_need_install_deps=false
            ;;
        --debug )
            export DJANGO_DEBUG=True
            is_debug=true
            ;;
        * )
            echo "[Bash] Invalid option: $1" >&2
            ;;
    esac
    shift
done

find_python_and_setup_gunicorn() {
  echo -e "${GREEN}[Bash] Try to find python...${NC}"

  if [ -f "/proc/version" ] && ! [ "$OSTYPE" = "msys" ] && ! [ "$OSTYPE" = "cygwin" ]; then
      echo -e "${GREEN}[Bash] Use linux python...${NC}"

      python_app="./.venv/bin/python"

      if [ "$is_debug" = false ]; then
          is_gunicorn_active=true
          echo -e "${GREEN}[Bash] Starting gunicorn...${NC}"
          sudo /etc/init.d/nginx start

          ${python_app} -m gunicorn --bind 0.0.0.0:8000 Site.wsgi
          #${python_app} -m gunicorn --bind unix:/run/gunicorn.sock Site.wsgi
      fi
  else
      echo -e "${GREEN}[Bash] Use windows python...${NC}"
      python_app="./.venv/Scripts/python.exe"
  fi
}

perform_task() {
    if [ -e "Cache/reload" ]; then
        rm Cache/reload
    fi

    if $is_need_install_deps; then
        echo -e "${GREEN}[Bash] Initalizing the server dependencies...${NC}"
        sh install.sh
    fi

    echo -e "${GREEN}[Bash] Starting the server...${NC}"

    find_python_and_setup_gunicorn

    if [ "$is_gunicorn_active" = false ]; then
        ${python_app} manage.py runserver --noreload
    fi
}

while true; do
    perform_task

    echo -e "${RED}[Bash] The server was closed!${NC}"

    if [ -e "Cache/reload" ]; then
        echo -e "${GREEN}[Bash] Restarting the server...${NC}"
        is_need_install_deps=true
    else
        break
    fi
done

echo -e "${RED}[Bash] Press Ctrl + C to exit...${NC}"

sleep 1d