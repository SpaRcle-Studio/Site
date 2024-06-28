mkdir .venv

GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo -e "${GREEN}Updating system python...${NC}"
python -m pip install --upgrade pip

echo -e "${GREEN}Installing python pipenv...${NC}"
python -m pip install pipenv

python_app = ""

if [ -f "/proc/version" ]; then
    echo -e "${GREEN}Installing python3.10-venv...${NC}"
    sudo apt install python3.10-venv --yes

    echo -e "${GREEN}Creating python venv...${NC}"
    python -m venv .venv

    python_app = ".venv/bin/python"
else
    echo -e "${GREEN}Creating python venv...${NC}"
    python -m venv .venv
    
    python_app = "./.venv/Scripts/python.exe"
fi

echo -e "${GREEN}Installing python pipenv...${NC}"
${python_app} -m pip install pipenv

echo -e "${GREEN}Installing python GitPython...${NC}"
${python_app} -m pip install GitPython

echo -e "${GREEN}Installing python termcolor...${NC}"
${python_app} -m pip install termcolor

echo -e "${GREEN}Installing python django-admin...${NC}"
${python_app} -m pip install django-admin

echo -e "${GREEN}Installing python django...${NC}"
${python_app} -m pip install django