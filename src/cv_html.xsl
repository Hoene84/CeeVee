<?xml version="1.0" encoding="UTF-8"?>
<?altova_samplexml cv_honegger.xml?>
<xsl:stylesheet version="2.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fn="http://www.w3.org/2005/xpa-functions"
    xmlns:html="http://www.w3.org/1999/xhtml" 
    xmlns="http://www.w3.org/1999/xhtml" 
    exclude-result-prefixes="html">

    <xsl:output method="html" version="4.0" encoding="UTF-8" indent="yes"/>

    <!--____________________________________________________main tamplate-->
    <!--to do the outline, should call main tamplate-->
    <xsl:template match="/">
        <html>
            <head>
                <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
                <style type="text/css">
                    <xsl:value-of select="unparsed-text('../style/cv.css', 'UTF-8')" disable-output-escaping="yes"/>
                </style>
                <style type="text/css" media="screen">
                    <xsl:value-of select="unparsed-text('../style/screen.css', 'UTF-8')" disable-output-escaping="yes"/>
                </style>
                <style type="text/css" media="print">
                    <xsl:value-of select="unparsed-text('../style/print.css', 'UTF-8')" disable-output-escaping="yes"/>
                </style>
                <xsl:apply-templates mode="layout"/>
            </head>
            <body>
                <div class="container">
                    <xsl:call-template name="main"/>
                </div>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="text()" mode="layout" />

    <xsl:template match="layout" mode="layout">
        <xsl:apply-templates mode="layout"/>
    </xsl:template>

    <xsl:template match="theme" mode="layout">
        <style type="text/css">
            <xsl:value-of select="unparsed-text(concat('../style/cv_', /current(), '.css'), 'UTF-8')" disable-output-escaping="yes"/>
        </style>
    </xsl:template>

    <xsl:template match="script" mode="layout">
        <script type="text/javascript">
            <xsl:value-of select="unparsed-text(concat('../js/', /current(), '.js'), 'UTF-8')" disable-output-escaping="yes"/>
        </script>
    </xsl:template>

    <!--________________________________________________________include of the common-->
    <!--processing of the xml-->
    <xsl:include href="cv_common.xsl"/>

    <!--________________________________________________________exclude for common-->
    <xsl:template match="layout"/>


</xsl:stylesheet>
