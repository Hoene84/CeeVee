.PHONY: all clean validate
PRODUCT=cv
DATA=honegger/cv.xml

all: pdf

target:
	mkdir -p target

validate: data/$(DATA) src/$(PRODUCT).xsd
	xmllint --noout data/$(DATA) --schema src/$(PRODUCT).xsd

common: target src/$(PRODUCT).xsl src/common.xsl data/$(DATA)
	saxonb-xslt data/$(DATA) src/$(PRODUCT).xsl > target/$(PRODUCT).html
	cp -r data/honegger/res/* target/.
	cp -r data/common/res/* target/.
	cp -r data/theme/res/* target/.

html: validate common target
	xdg-open target/$(PRODUCT).html &> /dev/null ;

pdf: html target target/$(PRODUCT).html
	chromium-browser --headless --disable-gpu --print-to-pdf=target/$(PRODUCT).pdf target/$(PRODUCT).html ; then xdg-open target/$(PRODUCT).pdf &> /dev/null ;

example: html pdf
	mkdir -p example
	cp target/* example/.

clean:
	rm -rf target
