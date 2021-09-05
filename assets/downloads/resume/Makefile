# template LateX Makefile
PAPER=*.tex
DIRECTORIES=Figures


make:
	@pdflatex -pdf $(PAPER)
	@echo Successful pdflatex compile.

clean:
	@rm -f *.aux
	@rm -f *.log
	@rm -f *.nav
	@rm -f *.out
	@rm -f *.snm
	@rm -f *.synctex.gz
	@rm -f *.toc
	@rm -f *.blg
	@rm -f *.vrb
	@rm -f *.fls
	@rm -f *.fdb_latexmk
	@echo Successfully removed all non-essential files.

clean_all:
	@rm -rf $(DIRECTORIES)/*
	@rmdir $(DIRECTORIES)
	@rm -f *
	@echo Successfully removed all files.
