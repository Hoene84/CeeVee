.PHONY: all clean validate

all: pdf

target:
	mkdir -p target

common: src/cv_common.xsl data/honegger/cv.xml

validate: data/honegger/cv.xml src/cv.xsd
	xmllint --noout data/honegger/cv.xml --schema src/cv.xsd

html: validate common target src/cv_html.xsl
	if $$(saxonb-xslt data/honegger/cv.xml src/cv_html.xsl > target/cv.html) ; then xdg-open target/cv.html &> /dev/null ; fi ;
	cp -r data/honegger/res/* target/.
	cp -r data/common/res/* target/.

pdf: html target target/cv.html
	if $$(wkhtmltopdf -L 10mm -R 10mm -T 20mm -B 20mm target/cv.html -> target/cv.pdf) ; then xdg-open target/cv.pdf &> /dev/null ; fi ;

clean:
	rm -rf target
