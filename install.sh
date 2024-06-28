mkdir .venv

GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo -e "${GREEN}Updating system python...${NC}"
python -m pip install --upgrade pip

echo -e "${GREEN}Installing python pipenv...${NC}"
python -m pip install pipenv

if [ -f "/proc/version" ]; then
    echo -e "${GREEN}Installing python3.10-venv...${NC}"
    sudo apt install python3.10-venv --yes
fi

echo -e "${GREEN}Creating python venv...${NC}"
python -m venv .venv

echo -e "${GREEN}Installing python pipenv...${NC}"
"./.venv/Scripts/python.exe" -m pip install pipenv

echo -e "${GREEN}Installing python GitPython...${NC}"
"./.venv/Scripts/python.exe" -m pip install GitPython

echo -e "${GREEN}Installing python termcolor...${NC}"
"./.venv/Scripts/python.exe" -m pip install termcolor

echo -e "${GREEN}Installing python django-admin...${NC}"
"./.venv/Scripts/python.exe" -m pip install django-admin

echo -e "${GREEN}Installing python django...${NC}"
"./.venv/Scripts/python.exe" -m pip install django