# Definindo o diretório atual
CUR_DIR := $(shell pwd)

# Encontrar todas as pastas no diretório atual (exceto o próprio Makefile)
DIRS := $(filter-out $(CUR_DIR)/Makefile, $(wildcard $(CUR_DIR)/*/))

# Alvo para rodar o stow em todas as pastas
all: $(DIRS)
	@echo "Stow aplicado em todos os diretórios"

# Alvo para rodar o stow em cada diretório
$(DIRS):
	@echo "Rodando stow em $(notdir $@)"
	@stow -d $(CUR_DIR) -t ~ $(notdir $@)

# Alvo para limpar links simbólicos criados pelo stow
clean:
	@echo "Removendo links simbólicos"
	@stow -d $(CUR_DIR) -t ~ -D $(DIRS)
