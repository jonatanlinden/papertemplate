LATEX=pdflatex
XELATEX=xelatex
BIBTEX=bibtex

LATEX_FLAGS=-file-line-error -halt-on-error
BIBTEX_FLAGS=

PAPER=genpaper


CLEAN_EXT=pdf aux bbl log blg snm nav out toc
CLEAN_FILE=$(foreach ext, $(CLEAN_EXT), $(PAPER).$(ext))

$(shell ./vc.sh)


TEX=$(PAPER).tex		\
    sections/*

all: pdf

fast: $(TEX) plots
	$(LATEX)  $(LATEX_FLAGS)  $(PAPER)


pdf: $(TEX) plots
	$(LATEX)  $(LATEX_FLAGS)  $(PAPER)
	$(BIBTEX) $(BIBTEX_FLAGS) $(PAPER)
	$(LATEX)  $(LATEX_FLAGS)  $(PAPER)
	$(LATEX)  $(LATEX_FLAGS)  $(PAPER)

plots:
	$(MAKE) -f Makefile.plots

.PHONY: clean
clean:
	$(RM) $(CLEAN_FILE)

.PHONY: dist-clean
dist-clean: clean
	$(MAKE) -f Makefile.plots clean
