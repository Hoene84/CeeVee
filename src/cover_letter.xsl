<?xml version="1.0" encoding="UTF-8"?>
<?altova_samplexml cv.xml?>
<xsl:stylesheet version="2.0"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fn="http://www.w3.org/2005/xpa-functions"
                xmlns:cv="http://cv">

    <xsl:output method="html" version="4.0" encoding="UTF-8" indent="yes"/>
    <xsl:include href="common.xsl"/>

    <xsl:template name="main">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="date|content|salutation|fullname">
        <div class="{local-name()}">
            <xsl:apply-templates select="current()" mode="content"/>
        </div>
    </xsl:template>

    <xsl:template match="subject">
        <h2>
            <xsl:apply-templates/>
        </h2>
    </xsl:template>

    <xsl:template match="date" mode="content">
        <xsl:call-template name="dateFormat"/>
    </xsl:template>

</xsl:stylesheet>
