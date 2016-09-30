all: authors.tex pprint.pdf paper.pdf supplement.pdf rebuttal.pdf

paper.pdf: paper.tex authors.tex introduction.tex architecture.tex features.tex assumptions.tex basic_usage.tex simplification.tex numerics.tex domain_specific.tex projects_that_depend_on_sympy.tex conclusion_and_future_work.tex siamart0216_uppercase_fix.tex pprint.pdf pprint.tex printers.tex calculus.tex matrices.tex solvers.tex images/circuitplot-qft.pdf paper.bib
	pdflatex -shell-escape --halt-on-error paper.tex
	bibtex paper.aux
	pdflatex -shell-escape --halt-on-error paper.tex
	pdflatex -shell-escape --halt-on-error paper.tex

supplement.pdf: categories.tex comparison_with_mma.tex diophantine.tex examples.tex gamma.tex gruntz.tex logic.tex nsimplify.tex polys.tex series.tex sets.tex solvers.tex stats.tex supplement.tex tensors.tex paper.bib images/integral_steps.png
	pdflatex -shell-escape --halt-on-error supplement.tex
	bibtex supplement
	pdflatex -shell-escape --halt-on-error supplement.tex
	pdflatex -shell-escape --halt-on-error supplement.tex

rebuttal.pdf: rebuttal.tex coverletter.pdf
	pdflatex -shell-escape --halt-on-error rebuttal.tex
	pdflatex -shell-escape --halt-on-error rebuttal.tex

coverletter.pdf: coverletter.tex
	pdflatex -shell-escape --halt-on-error coverletter.tex
	pdflatex -shell-escape --halt-on-error coverletter.tex

authors.tex: authors/list_latex.py authors/authors.json
	cd authors; ./list_latex.py

pprint.pdf: pprint.tex
	xelatex --halt-on-error pprint.tex

.PHONY: test
test:
	python test-paper.py

.PHONY: clean
clean:
	(rm -rf *.ps *.log *.dvi *.aux *.*% *.lof *.lop *.lot *.toc *.idx *.ilg *.ind *.bbl *.blg *.cpt)
	(rm -rf authors.tex pprint.pdf paper.pdf supplement.pdf rebuttal.pdf)
