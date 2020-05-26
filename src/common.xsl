<?xml version="1.0" encoding="UTF-8"?>
<?altova_samplexml cv_honegger.xml?>
<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fn="http://www.w3.org/2005/xpa-functions"
    xmlns:html="http://www.w3.org/1999/xhtml"
    xmlns="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="html"
    xmlns:cv="http://cv">

    <!--____________________________________________________main tamplate-->
    <!--to do the outline, should call main tamplate-->
    <xsl:template match="/">
        <html>
            <head>
                <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
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
        <style type="text/css">
            <xsl:value-of select="unparsed-text(concat('../style/', @type, '.css'), 'UTF-8')" disable-output-escaping="yes"/>
        </style>
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

    <xsl:template match="extScript" mode="layout">
        <script type="text/javascript" src="{current()}" />
    </xsl:template>

    <!--________________________________________________________exclude for common-->
    <xsl:template match="layout"/>

    <xsl:template name="dateFormat">
        <xsl:if test="@day != ''">
            <xsl:apply-templates select="@day"/>
            <xsl:text> </xsl:text>
        </xsl:if>
        <xsl:choose>
            <xsl:when test="@style = 'text'">
                <xsl:apply-templates select="text()"/>
            </xsl:when>
            <xsl:when test="@month != '' and @style = 'plain'">
                <xsl:value-of select="@month"/>
                <xsl:text>.</xsl:text>
            </xsl:when>
            <xsl:when test="@month != ''">
                <xsl:value-of select="cv:month-name-de(@month)"/>
                <xsl:text> </xsl:text>
            </xsl:when>
        </xsl:choose>
        <xsl:apply-templates select="@year"/>
    </xsl:template>

    <xsl:function name="cv:month-name-de" as="xs:string?">
        <xsl:param name="month" as="xs:integer?"/>
        <xsl:sequence select="('Jan.', 'Feb.', 'März', 'Apr.', 'Mai', 'Juni', 'Juli', 'Aug.', 'Sep.', 'Okt.', 'Nov.', 'Dez.') [$month]"/>
    </xsl:function>

    <xsl:template match="text()">
        <xsl:value-of select="cv:replace(.)" disable-output-escaping="yes"/>
    </xsl:template>
    <xsl:template match="@*">
        <xsl:value-of select="cv:replace(.)" disable-output-escaping="yes"/>
    </xsl:template>

    <xsl:function name="cv:replace">
        <xsl:param name="text" as="xs:string?"/>
        <xsl:value-of select="replace(replace(replace($text, '\\', '&lt;br/&gt;'), '!\?', '&lt;span class=acc&gt;'), '\?!', '&lt;/span&gt;')" disable-output-escaping="yes"/>
    </xsl:function>

</xsl:stylesheet>
