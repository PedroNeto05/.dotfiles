# Definir o diretório onde o Makefile está localizado
DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

# Encontrar todas as pastas no diretório, excluindo Makefile, .git e .gitignore
SUBDIRS := $(filter-out $(DIR)Makefile $(DIR).git $(DIR).gitignore,$(wildcard $(DIR)*/))

# Alvo padrão
all: stow

# Aplica o stow -R em todas as pastas, exceto Makefile, .git e .gitignore
stow:
	for dir in $(SUBDIRS); do \
		stow -R $$dir; \
	done
