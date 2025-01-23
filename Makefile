DIRECkkkTORIES = $(wildcard */)

all:
	@for dir in $(DIRECTORIES); do \
		echo "Stow in $$dir"; \
		stow --adopt $$dir; \
	done;
