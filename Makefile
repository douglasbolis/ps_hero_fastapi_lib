# Variáveis
APP_NAME=app
PACKAGE_NAME=ps_hero_fastapi_lib
VERSION=0.1.0

# Instalar dependências gerais (FastAPI, Uvicorn, etc.)
install:
	python -m pip install --upgrade pip
	python -m pip install sqlmodel "fastapi[standard]"

# Instalar dependências de desenvolvimento (build, wheel, twine, pytest, etc.)
install-dev: install
	python -m pip install wheel build twine pytest

# Instalar a lib ps_hero_fastapi_lib do PyPI
install-lib:
	python -m pip install $(PACKAGE_NAME)

# Rodar testes da aplicação FastAPI
test-app:
	pytest $(APP_NAME)/test/

# Rodar testes da biblioteca ps_hero_fastapi_lib
test-lib:
	pytest $(PACKAGE_NAME)/test/

# Rodar testes de app e lib
test:
	make test-app
	make test-lib

# Buildar a lib para publicação (modo tradicional)
build-lib:
	python setup.py sdist bdist_wheel

# Buildar a lib usando ferramenta moderna
build-modern: clean
	python -m build

# Publicar a lib no PyPI
publish-lib: build-modern
	python -m twine upload dist/*

# Limpar artefatos de build
clean:
	rm -rf build dist *.egg-info

# Mostrar ajuda
help:
	@echo "Comandos disponíveis:"
	@echo "  make install            - Instalar dependências gerais"
	@echo "  make install-lib        - Instalar a lib ps_hero_fastapi_lib"
	@echo "  make install-dev        - Instalar ferramentas de build/teste"
	@echo "  make test-lib           - Rodar testes da biblioteca"
	@echo "  make test-app           - Rodar testes da API"
	@echo "  make build-lib          - Buildar lib tradicional (setup.py)"
	@echo "  make build-modern       - Buildar lib moderno (python -m build)"
	@echo "  make publish-lib        - Publicar lib"
	@echo "  make clean     			   - Limpar artefatos de build"
