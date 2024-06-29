clear

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

is_need_install_deps=true

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
            ;;
        * )
            echo "[Bash] Invalid option: $1" >&2
            ;;
    esac
    shift
done

if [ -f "/proc/version" ] && ! [ "$OSTYPE" = "msys" ] && ! [ "$OSTYPE" = "cygwin" ]; then
    python_app="./.venv/bin/python"
    if $DJANGO_DEBUG; then
        sudo /etc/init.d/nginx start
    fi
else
    python_app="./.venv/Scripts/python.exe"
fi

perform_task() {
    if [ -e "Cache/reload" ]; then
        rm Cache/reload
    fi

    if $is_need_install_deps; then
        echo -e "${GREEN}[Bash] Initalizing the server dependencies...${NC}"
        sh install.sh
    fi

    echo -e "${GREEN}[Bash] Starting the server...${NC}"
    ${python_app} manage.py runserver --noreload #| tee /dev/fd/2 | tail -1
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