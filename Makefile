.PHONY: all clean validate
PRODUCT=cv
DATA=honegger
all: pdf

target:
	mkdir -p target

validate: data/$(DATA)/$(PRODUCT).xml src/$(PRODUCT).xsd
	xmllint --noout data/$(DATA)/$(PRODUCT).xml --schema src/$(PRODUCT).xsd

common: target src/$(PRODUCT).xsl src/common.xsl data/$(DATA)/$(PRODUCT).xml
	saxonb-xslt data/$(DATA)/$(PRODUCT).xml src/$(PRODUCT).xsl > target/$(PRODUCT).html
	cp -r data/honegger/res/* target/.
	cp -r data/common/res/* target/.
	cp -r data/theme/res/* target/.

html: validate common target
# 	xdg-open target/$(PRODUCT).html &> /dev/null ;

pdf: html target target/$(PRODUCT).html
	chromium-browser --headless --disable-gpu --virtual-time-budget=100 --print-to-pdf=target/$(PRODUCT).pdf target/$(PRODUCT).html ; then xdg-open target/$(PRODUCT).pdf &> /dev/null ;

example: clean html pdf
	THEME=$$(xmllint --xpath '(//theme)[1]/text()' data/honegger/cv.xml); \
	mkdir -p example/$(DATA)/$$THEME/$(PRODUCT); \
	cp -r target/* example/$(DATA)/$$THEME/$(PRODUCT)/.

clean:
	rm -rf target
