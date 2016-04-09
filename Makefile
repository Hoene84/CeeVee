.PHONY: all clean validate

all: pdf

target:
	mkdir -p target

validate: data/honegger/cv.xml src/cv.xsd
	xmllint --noout data/honegger/cv.xml --schema src/cv.xsd

common: target src/cv_common.xsl data/honegger/cv.xml
	saxonb-xslt data/honegger/cv.xml src/cv_html.xsl > target/cv.html
	cp -r data/honegger/res/* target/.
	cp -r data/common/res/* target/.

html: validate common target src/cv_html.xsl
	xdg-open target/cv.html &> /dev/null ;

pdf: html target target/cv.html
	wkhtmltopdf -L 10mm -R 10mm -T 20mm -B 20mm target/cv.html -> target/cv.pdf; then xdg-open target/cv.pdf &> /dev/null ;

exsample: html pdf
	mkdir -p example
	cp target/* example/.

clean:
	rm -rf target
