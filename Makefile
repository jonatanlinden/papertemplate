LATEX=pdflatex
BIBTEX=bibtex

GENPDF=./tools/gen-pdf.sh

LATEX_FLAGS=-file-line-error -halt-on-error
BIBTEX_FLAGS=

CLEAN_EXT=pdf aux bbl log blg snm nav out toc
CLEAN_FILE=$(foreach ext, $(CLEAN_EXT), genpaper.$(ext))

$(shell ./vc.sh)

PAPER=genpaper.tex
BIBNAME=genpaper

TEX=$(PAPER)			\
    sections/*


all: pdf

fast: $(TEX) #pdf-graphs
	$(LATEX)  $(LATEX_FLAGS)  $(PAPER)


pdf: $(TEX) #pdf-graphs
	$(LATEX)  $(LATEX_FLAGS)  $(PAPER)
	$(BIBTEX) $(BIBTEX_FLAGS) $(BIBNAME)
	$(LATEX)  $(LATEX_FLAGS)  $(PAPER)
	$(LATEX)  $(LATEX_FLAGS)  $(PAPER)

pdf-graphs:
	$(MAKE) -f Makefile.plots

.PHONY: clean
clean:
	$(RM) $(CLEAN_FILE)

.PHONY: dist-clean
dist-clean: clean
	$(MAKE) -f Makefile.plots clean
