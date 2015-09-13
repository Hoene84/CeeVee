<?xml version="1.0" encoding="UTF-8"?>
<?altova_samplexml cv_honegger.xml?>
<xsl:stylesheet version="2.0" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fn="http://www.w3.org/2005/xpa-functions" xmlns="http://www.w3.org/1999/XSL/Format" exclude-result-prefixes="fo">
<xsl:output method="xml" version="1.0" encoding="ISO-8859-1" indent="yes"/>
	<!--___________________________________________________________element mapping-->
	<xsl:variable name="block">block</xsl:variable>
	<xsl:variable name="table">table</xsl:variable>
	<xsl:variable name="tableBody">table-body</xsl:variable>
	<xsl:variable name="tableRow">table-row</xsl:variable>
	<xsl:variable name="tableCell">table-cell</xsl:variable>
	<xsl:variable name="list">list-block</xsl:variable>
	<xsl:variable name="listItem">list-item</xsl:variable>
	<xsl:variable name="listItemLabel">list-item-label</xsl:variable>
	<xsl:variable name="bold">inline</xsl:variable>
	<xsl:variable name="listItemBody">list-item-body</xsl:variable>
	<xsl:variable name="listLabelSign">&#183;</xsl:variable>
	<!--___________________________________________________attributes sets for elements-->
	<xsl:attribute-set name="listItemBodyAttrs">
		<xsl:attribute name="start-indent">body-start()</xsl:attribute>
	</xsl:attribute-set>
    <xsl:attribute-set name="boldAttrs">
		<xsl:attribute name="font-weight">bold</xsl:attribute>
	</xsl:attribute-set>
	<!--font sytle attrs, should be applicable for block and paragraphs-->
	<xsl:attribute-set name="defaultFontAttrs">
		<xsl:attribute name="font-family">Nimbus Sans L</xsl:attribute>
		<xsl:attribute name="font-size">10pt</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="defaultParagraphAttrs">
		<xsl:attribute name="padding-top">1mm</xsl:attribute>
		<xsl:attribute name="padding-bottom">2mm</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="highlightedAttrs">
		<xsl:attribute name="font-style">italic</xsl:attribute>
		<xsl:attribute name="font-weight">bold</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="centeredParagrapthAttrs">
		<xsl:attribute name="text-align">center</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="keepWithNextParagrapthAttrs" use-attribute-sets="defaultParagraphAttrs">
		<xsl:attribute name="keep-with-next">always</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="h1Attrs">
		<xsl:attribute name="font-size">14pt</xsl:attribute>
		<xsl:attribute name="font-weight">bold</xsl:attribute>
		<xsl:attribute name="space-before">10mm</xsl:attribute>
		<xsl:attribute name="space-after">5mm</xsl:attribute>
		<xsl:attribute name="keep-with-next">always</xsl:attribute>
		<xsl:attribute name="hyphenate">false</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="h2Attrs" use-attribute-sets="h1Attrs">
		<xsl:attribute name="font-size">12pt</xsl:attribute>
		<xsl:attribute name="space-before">5mm</xsl:attribute>
		<xsl:attribute name="space-after">2mm</xsl:attribute>
		<xsl:attribute name="keep-with-next">always</xsl:attribute>
		<xsl:attribute name="hyphenate">false</xsl:attribute>
        <xsl:attribute name="text-align">center</xsl:attribute>
	</xsl:attribute-set>
	<!--table style Attrs-->
	<xsl:attribute-set name="oddRowAttrs">
		<xsl:attribute name="background-color">#DDFFE0</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="evenRowAttrs">
		<xsl:attribute name="background-color">#EEFFE0</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="verticalCenteredCellAttrs" use-attribute-sets="defaultCellAttrs">
		<xsl:attribute name="display-align">center</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="defaultCellAttrs">
		<xsl:attribute name="padding">4px 4px 4px 4px</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="borderedTableAttrs">
		<xsl:attribute name="background-color">#FFFFFF</xsl:attribute>
		<xsl:attribute name="border-width">2px,0px,2px,0px</xsl:attribute>
		<xsl:attribute name="border-style">solid</xsl:attribute>
		<xsl:attribute name="border-color">#DDFFE0</xsl:attribute>
	</xsl:attribute-set>
	<!--___________________________________________________________variables-->
	<xsl:variable name="personPictureWidth">42mm</xsl:variable>
	<xsl:variable name="personPictureHeigth">54mm</xsl:variable>
	<xsl:template name="tableColumnDefs">
		<table-column column-width="17%"/>
		<table-column/>
	</xsl:template>
	<!--______________________________________________________templates to call-->
	<xsl:template name="rigthFixedColumnDefs">
		<table-column/>
		<table-column column-width="38.17%"/>
	</xsl:template>
	<!--adds a picture tag with given parameters-->
	<xsl:template name="picture">
		<xsl:param name="uri"/>
		<xsl:param name="heigth"/>
		<xsl:param name="width"/>
		<fo:external-graphic src="{$uri}" content-width="{$width}" content-height="{$heigth}"/>
	</xsl:template>
	<!--____________________________________________________main tamplate-->
	<!--to do the outline, should call main tamplate-->
	<xsl:template match="/">
		<root xmlns:fo="http://www.w3.org/1999/XSL/Format">
			<layout-master-set>
				<simple-page-master page-height="297mm" page-width="210mm" margin="0mm 25mm 0mm 25mm" master-name="PageMaster">
					<region-body margin="17.5mm 0mm 15mm 0mm"/>
				</simple-page-master>
			</layout-master-set>
			<page-sequence master-reference="PageMaster">
				<flow flow-name="xsl-region-body">
					<xsl:call-template name="main"/>
				</flow>
			</page-sequence>
		</root>
	</xsl:template>
	<!--________________________________________________________include of the common-->
	<!--processing of the xml-->
	<xsl:include href="cv_common_honegger.xsl"/>
</xsl:stylesheet>
