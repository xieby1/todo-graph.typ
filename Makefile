.SECONDARY:

MAIN_TYPs = $(shell find . -name "*main.typ")
MAIN_PDFs = $(subst .typ,.pdf,${MAIN_TYPs})

test: $(addsuffix .test,${MAIN_PDFs})

%main.pdf.test: %main.pdf %main.regex
	pdftotext $< - | check_regex_order.py $(filter-out $<,$^)
