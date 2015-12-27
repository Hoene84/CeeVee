.PHONY: all clean validate

all: pdf

target:
	mkdir -p target

common: src/cv_common.xsl data/cv.xml

validate: data/cv.xml src/cv.xsd
	xmllint --noout data/cv.xml --schema src/cv.xsd

html: validate common target src/cv_html.xsl
	if $$(saxonb-xslt data/cv.xml src/cv_html.xsl > target/cv.html) ; then xdg-open target/cv.html &> /dev/null ; fi ;
	cp -r data/res/* target/.

pdf: html target target/cv.html
	if $$(wkhtmltopdf target/cv.html -> target/cv.pdf) ; then xdg-open target/cv.pdf &> /dev/null ; fi ;

clean:
	rm -rf target
