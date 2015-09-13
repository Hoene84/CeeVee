<?xml version="1.0" encoding="UTF-8"?>
<?altova_samplexml cv_honegger.xml?>
<xsl:stylesheet version="2.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:fn="http://www.w3.org/2005/xpa-functions" 
    xmlns:html="http://www.w3.org/1999/xhtml" 
    xmlns="http://www.w3.org/1999/xhtml" 
    exclude-result-prefixes="html">

	<xsl:output method="html" version="4.0" encoding="ISO-8859-1" indent="yes"/>
	<!--___________________________________________________________element mapping-->
	<xsl:variable name="block">div</xsl:variable>
	<xsl:variable name="table">table</xsl:variable>
	<xsl:variable name="tableBody">tbody</xsl:variable>
	<xsl:variable name="tableRow">tr</xsl:variable>
	<xsl:variable name="tableCell">td</xsl:variable>
	<xsl:variable name="list">ul</xsl:variable>
	<xsl:variable name="listItem">li</xsl:variable>
	<xsl:variable name="listItemLabel">div</xsl:variable>
    <xsl:variable name="bold">b</xsl:variable>
	<!--has no result-->
	<xsl:variable name="listItemBody">div</xsl:variable>
	<!--has no result-->
	<xsl:variable name="listLabelSign"/>
	<!--___________________________________________________attributes sets for elements-->
	<xsl:attribute-set name="listItemBodyAttrs"/>
    <xsl:attribute-set name="boldAttrs"/>
	<!--font sytle attrs, should be applicable for block and paragraphs-->
	<xsl:attribute-set name="defaultFontAttrs"/>
	<xsl:attribute-set name="defaultParagraphAttrs">
		<xsl:attribute name="class">paragraph</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="highlightedAttrs">
		<xsl:attribute name="class">highlighted</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="centeredParagrapthAttrs">
		<xsl:attribute name="class">centered</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="leftParagrapthAttrs">
		<xsl:attribute name="class">left</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="keepWithNextParagrapthAttrs"/><!--makes no sense in html-->
	<xsl:attribute-set name="h1Attrs">
		<xsl:attribute name="class">h1</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="h2Attrs">
		<xsl:attribute name="class">h2</xsl:attribute>
	</xsl:attribute-set>
	<!--table style Attrs-->
	<xsl:attribute-set name="borderedTableAttrs">
		<xsl:attribute name="class">bordered</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="oddRowAttrs">
		<xsl:attribute name="style">background-color:#FFFFDD</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="evenRowAttrs">
		<xsl:attribute name="style">background-color:#FFFFEE</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="verticalCenteredCellAttrs">
		<xsl:attribute name="class">verticalCentered</xsl:attribute>
	</xsl:attribute-set>
	<!--see css in header-->
	<xsl:attribute-set name="defaultCellAttrs"/>
	<!--___________________________________________________________variables-->
	<xsl:variable name="personPictureWidth">175px</xsl:variable>
	<xsl:variable name="personPictureHeigth">225px</xsl:variable>
	<!--______________________________________________________templates to call-->
	<xsl:template name="tableColumnDefs">
		<colgroup>
			<col style="width:20%;"/>
			<col/>
		</colgroup>
	</xsl:template>
	<xsl:template name="rigthFixedColumnDefs">
		<colgroup>
			<col/>
			<col style="width:38.17%;"/>
		</colgroup>
	</xsl:template>
	<!--adds a picture tag with given parameters-->
	<xsl:template name="picture">
		<xsl:param name="uri"/>
		<xsl:param name="heigth"/>
		<xsl:param name="width"/>
		<img src="{$uri}" width="{$width}" height="{$heigth}"/>
	</xsl:template>
	<!--____________________________________________________main tamplate-->
	<!--to do the outline, should call main tamplate-->
	<xsl:template match="/">
		<html>
			<head>
				<style type="text/css">
					<xsl:text>
					*, body, html { font-family:Nimbus Sans L;font-size:10pt; }
					table { width:100%; }
					table.bordered { border-width:2px border-color:black; border-style:solid; background-color:#FFFFDD; } 
					td { vertical-align:top;padding:2px 2px 2px 2px; }
					td.verticalCentered { vertical-align:middle; }
					div.h1 { font-size:16pt;font-weight:bold;margin-top:10mm;margin-bottom:5mm; }
					div.h2 { font-size:12pt;font-weight:bold;bold;margin-top:5mm;margin-bottom:2mm; }
					div.centered { text-align:center; padding:10px 10px 10px 10px; }
					div.paragraph { padding-top:2mm;padding-bottom:2mm}
					div.highlighted { font-style: italic;font-weight:bold; }
					div.left { width:80%; }
					div.picture { width:80%; }
					</xsl:text>
				</style>
			</head>
			<body>
				<div style="width:800px;margin: 0 auto;">
					<xsl:call-template name="main"/>
				</div>
			</body>
		</html>
	</xsl:template>
	<!--________________________________________________________include of the common-->
	<!--processing of the xml-->
	<xsl:include href="cv_common_honegger.xsl"/>
</xsl:stylesheet>
