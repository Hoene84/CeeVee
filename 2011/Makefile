.PHONY: all clean validate

all: pdf html

common: cv_common_honegger.xsl cv_honegger.xml

validate: cv_honegger.xml cv.xsd
	xmllint --noout cv_honegger.xml --schema cv.xsd

pdf: validate common cv_fo_honegger.xsl
	if $$(saxonb-xslt cv_honegger.xml cv_fo_honegger.xsl > cv_honegger.fo) && $$(fop -c fop.cfg -fo cv_honegger.fo -pdf cv_honegger.pdf) ; then evince cv_honegger.pdf ; else gedit cv_honegger.fo ; fi ;

html: validate cv_html_honegger.xsl
	if $$(saxonb-xslt cv_honegger.xml cv_html_honegger.xsl > cv_honegger.html) ; then google-chrome cv_honegger.html ; fi ;

clean:
	rm cv_honegger.fo
	rm cv_honegger.pdf
	rm cv_honegger.html
