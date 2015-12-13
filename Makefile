.PHONY: all clean validate

all: pdf

common: cv_common_honegger.xsl cv_honegger.xml

validate: cv_honegger.xml cv.xsd
	xmllint --noout cv_honegger.xml --schema cv.xsd

html: validate cv_html_honegger.xsl
	if $$(saxonb-xslt cv_honegger.xml cv_html_honegger.xsl > cv_honegger.html) ; then xdg-open cv_honegger.html ; fi ;

pdf: html
	if $$(wkhtmltopdf cv_honegger.html -> cv_honegger.pdf) ; then xdg-open cv_honegger.pdf ; fi ;

clean:
	rm cv_honegger.fo
	rm cv_honegger.pdf
	rm cv_honegger.html
