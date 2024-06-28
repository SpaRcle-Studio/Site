clear

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

is_need_install_deps=true

# Обработка аргументов командной строки
while [[ "$1" != "" ]]; do
    case $1 in
        --help )    
            ;;
        --nodeps )
            is_need_install_deps=false
            ;;
        * )
            echo "Invalid option: $1" >&2
            ;;
    esac
    shift
done

perform_task() {
  if $is_need_install_deps; then
    echo -e "${GREEN}Initalizing the server dependencies...${NC}"
    sh install.sh
  fi

  echo -e "${GREEN}Starting the server...${NC}"
  ".venv/Scripts/python.exe" manage.py runserver
}

perform_task

if [ $? -eq 100 ]; then
    echo -e "${GREEN}Restarting the server...${NC}"
    is_need_install_deps=true
    perform_task
fi

echo -e "${RED}Server closed. Press Ctrl + C to exit...${NC}"

sleep 1d