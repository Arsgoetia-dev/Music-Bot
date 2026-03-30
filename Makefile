SHELL := /bin/sh

PYTHON ?= python
VENV ?= .venv
VENV_BIN := $(VENV)/bin

.PHONY: help check-python bootstrap install run clean

help:
	@echo "Available targets:"
	@echo "  make help         - Show this help"
	@echo "  make check-python - Verify Python 3.11 is active"
	@echo "  make bootstrap    - Create venv and install dependencies"
	@echo "  make install      - Install/refresh dependencies in existing venv"
	@echo "  make run          - Run the bot using venv interpreter"
	@echo "  make clean        - Remove local caches and virtual environment"

check-python:
	@$(PYTHON) -c "import sys; assert sys.version_info[:2] == (3, 11), f'Python 3.11 required, got {sys.version.split()[0]}'"
	@echo "Python OK: $$($(PYTHON) --version)"

bootstrap: check-python
	$(PYTHON) -m venv $(VENV)
	$(VENV_BIN)/python -m pip install --upgrade pip
	$(VENV_BIN)/pip install -r requirements.txt

install: check-python
	@test -x $(VENV_BIN)/python || (echo "Virtualenv not found. Run: make bootstrap" && exit 1)
	$(VENV_BIN)/python -m pip install --upgrade pip
	$(VENV_BIN)/pip install -r requirements.txt

run: check-python
	@test -x $(VENV_BIN)/python || $(MAKE) bootstrap
	$(VENV_BIN)/python main.py

clean:
	rm -rf $(VENV)
	find . -type d -name "__pycache__" -prune -exec rm -rf {} +
	find . -type d -name ".cache" -prune -exec rm -rf {} +
	@echo "Local development artifacts cleaned"
