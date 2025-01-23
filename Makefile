DIRECTORIES := $(wildcard */)

stow:
	@for dir in $(DIRECTORIES); do \
		echo "Stow in $$dir"; \
		stow --adopt $$dir; \
	done
	git restore .

all: stow
