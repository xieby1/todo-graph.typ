.SECONDARY:

MAIN_TYPs = $(shell find . -name "*main.typ")
MAIN_PDFs = $(subst .typ,.pdf,${MAIN_TYPs})

test: $(addsuffix .test,${MAIN_PDFs})

%.pdf: %.typ $(shell find $(<D) -name "*.typ") lib.typ graph.typ
	typst compile $< $@

%main.pdf.test: %main.pdf %main.regex
	pdftotext $< - | check_regex_order.py $(filter-out $<,$^)

clean:
	rm -f ${MAIN_PDFs}
