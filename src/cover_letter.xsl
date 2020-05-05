<?xml version="1.0" encoding="UTF-8"?>
<?altova_samplexml cv.xml?>
<xsl:stylesheet version="2.0"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fn="http://www.w3.org/2005/xpa-functions"
                xmlns:cv="http://cv">

    <xsl:output method="html" version="4.0" encoding="UTF-8" indent="yes"/>

    <xsl:template name="main">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:include href="common.xsl"/>
</xsl:stylesheet>
