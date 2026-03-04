.SECONDARY:

MAIN_TYPs = $(shell find . -name "*main.typ")
MAIN_PDFs = $(subst .typ,.pdf,${MAIN_TYPs})
TEST_SHs = $(shell find . -name "*test.sh")

test: $(addsuffix .test,${MAIN_PDFs}) $(addsuffix .run,${TEST_SHs})

%.pdf: %.typ $(shell find $(<D) -name "*.typ") lib.typ graph.typ
	typst compile $< $@

%main.pdf.test: %main.pdf %main.regex
	pdftotext $< - | check_regex_order.py $(filter-out $<,$^)

%test.sh.run: %test.sh %test.typ
	bash $<

clean:
	rm -f ${MAIN_PDFs}
